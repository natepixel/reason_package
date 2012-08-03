<?php

/**
 * HTML editor type library.
 *
 * @package disco
 * @subpackage plasmature
 */

require_once PLASMATURE_TYPES_INC."default.php";
require_once PLASMATURE_TYPES_INC."text.php";

/**
 * Edit HTML using a Loki 1 editor.
 * @package disco
 * @subpackage plasmature
 */
class lokiType extends defaultType
{
	var $type = 'loki';
	var $widgets = 'default';
	var $user_is_admin = false;
	var $site_id = 0;
	var $paths = array();
	var $type_valid_args = array('widgets', 'user_is_admin', 'site_id', 'paths');
	function do_includes()
	{
		include_once( LOKI_INC.'lokiOptions.php3' );	// for loki Options
		include_once( LOKI_INC.'object.php' );
	}
	function grab()
	{
		$HTTP_VARS = $this->get_request();
		if ( isset( $HTTP_VARS[ $this->name ] ) )
		{
			$this->loki_process = new Loki_Process( $HTTP_VARS[ $this->name ] );
			$val = tidy( $this->loki_process->get_field_value() );
			if( empty( $val ) )
			{
				$tidy_err = tidy_err( $this->loki_process->get_field_value() );
				if( !empty($tidy_err) )
				{
					$tidy_err = nl2br( htmlentities( $tidy_err,ENT_QUOTES,'UTF-8' ) );
					$this->set_error( 'Your HTML appears to be ill-formatted.  Here is what Tidy has to say about it: <br />'.$tidy_err );
					$this->set( $this->loki_process->get_field_value() );
				}
				else
					$this->set( $val );
			}
			else
			{
				$val = preg_replace("|</table>\n\n<br />\n<br />\n|i","</table>\n", $val);
				$this->set( $val );
			}
		}
		$length = strlen( $this->value );
		if( ($this->db_type == 'tinytext' AND $length > 255) OR ($this->db_type == 'text' AND $length > 65535) OR ($this->db_type == 'mediumtext' AND $length > 16777215) )
			$this->set_error( 'There is more text in '.$this->display_name.' than can be stored ' );
	}
	function display()
	{
		$http_vars = $this->get_request();
		if( $this->has_error )
		{
			$this->loki = new Loki( $this->name, $this->loki_process->_field_value, $this->widgets, (!empty( $http_vars['site_id'] ) ? $http_vars['site_id'] : -1), $this->user_is_admin );
		}
		else
		{
			$this->loki = new Loki( $this->name, $this->value, $this->widgets, (!empty( $http_vars['site_id'] ) ? $http_vars['site_id'] : -1), $this->user_is_admin );
		}
		$this->loki->print_form_children();
		//loki( $this->name, $this->value , $this->widgets);
	}
}

/**
 * Edit HTML using a Loki 2 editor.
 * @package disco
 * @subpackage plasmature
 */
class loki2Type extends defaultType
{
	var $type = 'loki2';
	var $widgets = 'default';
	var $site_id = 0;
	var $paths = array();
	var $allowable_tags = array();
	
	/**
	 * Exists for backwards compatibility with Loki 1
	 *
	 * Proper method to use now is to just pass the source option as a a widget, or not
	 * @deprecated
	 */
	var $user_is_admin;
	var $crash_report_uri;
	/**
	 * Allow for a custom sized text entry box
	 */
	var $rows = 20;
	var $cols = 80;
	var $type_valid_args = array('widgets', 'site_id', 'paths', 'allowable_tags', 'user_is_admin', 'crash_report_uri', 'rows', 'cols');
	function do_includes()
	{
		if (file_exists( LOKI_2_INC.'loki.php' ))
		{
			include_once( LOKI_2_INC.'loki.php' );
		}
		else
		{
			trigger_error('Loki 2 file structure has changed slightly. Please update LOKI_2_INC in package_settings.php to reference the ' . LOKI_2_INC . '/helpers/php/ directory.');
			include_once( LOKI_2_INC.'/helpers/php/inc/options.php' );
		}
	}
	function grab()
	{
		$http_vars = $this->get_request();
		if ( isset( $http_vars[ $this->name ] ) )
		{
			$val = tidy( $http_vars[ $this->name ] );
			if( empty( $val ) )
			{
				$tidy_err = tidy_err( $http_vars[ $this->name ] );
				if( !empty($tidy_err) )
				{
					$tidy_err = nl2br( htmlentities( $tidy_err,ENT_QUOTES,'UTF-8' ) );
					$this->set_error( 'Your HTML appears to be ill-formatted.  Here is what Tidy has to say about it: <br />'.$tidy_err );
					$this->set( $http_vars[ $this->name ] );
				}
				else
					$this->set( $val );
			}
			else
			{
				// this looks like a hack. We could look into removing it.
				// $val = eregi_replace("</table>\n\n<br />\n<br />\n","</table>\n", $val);
				$this->set( $val );
			}
		}
		$length = strlen( $this->value );
		if( ($this->db_type == 'tinytext' AND $length > 255) OR ($this->db_type == 'text' AND $length > 65535) OR ($this->db_type == 'mediumtext' AND $length > 16777215) )
			$this->set_error( 'There is more text in '.$this->display_name.' than can be stored ' );
	}
	function display()
	{
		$loki = new Loki2( $this->name, $this->value, $this->_resolve_widgets($this->widgets) );
		if(!empty($this->paths['image_feed']))
		{
			$loki->set_feed('images',$this->paths['image_feed']);
		}
		if(!empty($this->paths['site_feed']))
		{
			$loki->set_feed('sites',$this->paths['site_feed']);
		}
		if(!empty($this->paths['finder_feed']))
		{
			$loki->set_feed('finder',$this->paths['finder_feed']);
		}
		if(!empty($this->paths['default_site_regexp']))
		{
			$loki->set_default_site_regexp($this->paths['default_site_regexp']);
		}
		if(!empty($this->paths['default_type_regexp']))
		{
			$loki->set_default_type_regexp($this->paths['default_type_regexp']);
		}
		if(!empty($this->paths['css']))
		{
			$loki->add_document_style_sheets($this->paths['css']);
		}
		if(!empty($this->allowable_tags))
		{
			$loki->set_allowable_tags($this->allowable_tags);
		}
		if(!empty($this->crash_report_uri))
		{
			$loki->set_crash_report_uri($this->crash_report_uri);
		}
		$loki->print_form_children($this->rows, $this->cols);
	}
	function _resolve_widgets($widgets)
	{
		$widgets = $this->_flatten_widgets($widgets);
		if($this->user_is_admin)
		{
			$widgets .= ' +source +debug';
		}
		elseif($this->user_is_admin === false)
		{
			$widgets .= ' -source -debug';
		}
		return $widgets;
	}
	function _flatten_widgets($widgets)
	{
		if(is_array($widgets))
			return implode(' ',$widgets);
		else
			return $widgets;
	}
}

/**
 * Edit HTML using a TinyMCE editor.
 * @package disco
 * @subpackage plasmature
 */
class tiny_mceType extends textareaType
{
	var $type = 'tiny_mce';
	function display()
	{
		// we only want to load the main js file once.
		static $loaded_an_instance;
		if (!isset($loaded_an_instance))
		{
			echo '<script language="javascript" type="text/javascript" src="'.TINYMCE_HTTP_PATH.'tiny_mce.js"></script>'."\n";
			$loaded_an_instance = true;
		}
		
		echo '<script language="javascript" type="text/javascript">'."\n";
		echo 'tinyMCE.init({'."\n";
		echo 'mode : "exact",'."\n";
		echo 'theme : "advanced",'."\n";
		echo 'theme_advanced_toolbar_location : "top",'."\n";
		echo 'theme_advanced_path_location : "bottom",'."\n";
		echo 'theme_advanced_resizing : true,'."\n";
		echo 'elements : "'.$this->name.'"'."\n";
		echo '});'."\n";
		echo '</script>'."\n";
		$this->set_class_var('rows', $this->get_class_var('rows')+12 );
		parent::display();
	}
}
