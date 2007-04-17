<?php
include_once('paths.php');
include_once(LOKI_2_INC.'Loki_Options.php'); // so we can get L_DEFAULT etc.
/**
 * 2nd generation of the Loki XHTML editor
 *
 * Takes care of building the (x)html to instantiate Loki
 * 
 * <strong>Minimal Usage:</strong>
 * <code>
 * $widgets = array('em','strong','ulist'); // or $widgets = 'all'; or $widgets = 'default'; etc.
 * $loki = new Loki2( 'field_name', 'field_value' );
 * $loki->print_form_children();
 * </code>
 *
 * <strong>More sophisticated usage:</strong>
 * <code>
 * $widgets = array('em','strong','ulist');
 * $admin = true; // for code editing
 * $loki = new Loki2( 'field_name', 'field_value', $widgets, $admin );
 * $loki->print_form_children();
 * </code>
 *
 * <strong>Very sophisticated usage -- integrated into a content management system:</strong>
 * <code>
 * $widgets = array('em','strong','ulist');
 * $admin = true; // for code editing
 * $paths = array('image_feed'=>'http://foo.com','site_feed'=>'http://bar.net','finder'=>'http://baz.edu','default_site_regexp'=>'http:\/\/foofoo.org\/','
 * $loki = new Loki2( 'field_name', 'field_value', $widgets, $admin );
 *
 * // see Loki's integration documentation for an explanation of the values in this area
 * $loki->set_feed('images','http://foo.com/image_feed.xml');
 * $loki->set_feed('sites','http://bar.net/site_feed.xml');
 * $loki->set_feed('finder','http://baz.edu/feed_finder.xml');
 * $loki->set_default_site_regexp('http:\/\/foofoo.org\/');
 * $loki->set_default_type_regexp('http:\/\/barbar.org\/');
 *
 * $loki->print_form_children();
 * </code>
 */

class Loki2
{
	var $_asset_path;
	var $_current_options;

	var $_field_name;
	var $_field_value;
	var $_editor_id;
	var $_editor_obj;
	var $_user_is_admin;
	var $_feeds = array();
	var $_default_site_regexp = '';
	var $_default_type_regexp = '';
	var $_sanitize_unsecured = false;

	/**
	 * Constructor
	 *
	 * @param	string	$field_name		  How Loki is identified within its containing form. This will become the name of the textarea that Loki creates
	 *                                    and therefore of the request variable received by the form's action.
	 * @param   string  $field_value      The HTML that Loki will initially be editing.
	 * @param	string	$current_options  Indicates which buttons etc Loki should present to the user. For the possible values, see js/UI.Loki_Options.js
	 * @param	boolean	$user_is_admin	  Whether the user is an administrator. Administrators can get options normal users can't.
	 */
	function Loki2( $field_name, $field_value = '', $current_options = 'default', $user_is_admin = false, $debug = false )
	{
		$this->_asset_protocol = strpos($_SERVER['SCRIPT_URI'], 'https') === 0 ? 'https://' : 'http://';
		$this->_asset_host = $_SERVER['HTTP_HOST'];
		$this->_asset_path = LOKI_2_HTTP_PATH;
		$this->_asset_uri = $this->_asset_protocol . $this->_asset_host . $this->_asset_path;
		$this->_asset_file_path = LOKI_2_INC;
		$this->_current_options = $current_options;

		$this->_field_name = $field_name;
		$this->_set_field_value($field_value);
		$this->_editor_id = uniqid('loki');
		$this->_editor_obj = $this->_editor_id."_obj";
		$this->_user_is_admin = $user_is_admin;
        $this->_debug = $debug;
	}

	/**
	 * Sets the given feed.
	 *
	 * @param	string	$feed_name	The name of the feed.
	 * @param	string	$feed_url	The url of the feed.
	 */
	function set_feed($feed_name, $feed_url)
	{
		$this->_feeds[$feed_name] = $feed_url;
	}

	/**
	 * Sets the regular expression used by the link dialog to determine which site 
	 * to display as default when no link is selected.
	 *
	 * @param	string	$regexp	The _Javascript_ regexp. You might want to use 
	 *                          {@link js_regexp_quote()} to make things easier.
	 */
	function set_default_site_regexp($regexp)
	{
		$this->_default_site_regexp = $regexp;
	}

	/**
	 * Sets the regular expression used by the link dialog to determine which type 
	 * to display as default when no link is selected.
	 *
	 * @param	string	$regexp	The _Javascript_ regexp. You might want to use 
	 *                          {@link js_regexp_quote()} to make things easier.
	 */
	function set_default_type_regexp($regexp)
	{
		$this->_default_type_regexp = $regexp;
	}
	
	/**
	 * Sets whether or not Loki will sanitize embedded content the transmission
	 * of which is not SSL-secured by not displaying it in the editor.
	 * @param bool $value true to perform the sanitization, false if otherwise
	 * @return void
	 */
	function sanitize_unsecured($value)
	{
		$this->_sanitize_unsecured = (bool) $value;
	}

	/**
	 * Prints the html which needs to be placed within a form.
	 */
	function print_form_children()
	{
		$this->_include_loki_js();
		?>

		<!--div><a href="javascript:void(0);" onclick="Util.Window.alert(document.body.innerHTML);">View virtual source</a></div-->
		<script type="text/javascript" language="javascript">
		//document.domain = 'carleton.edu'; /// XXX: for testing; maybe remove later if not necessary
		var loki;
		var loki_debug = <?php echo $this->_debug ? 'true' : 'false' ?>; // set to false or remove when live
		function loki_do_onload()
		{
			var options = new UI.Loki_Options;
			<?php
			if ( is_array($this->_current_options) )
			{
				echo "options.init(['";
				echo implode("', '", $this->_current_options)."'";
			}
			else
				echo "options.init(['" . $this->_current_options . "'";

			// Source is only available if the user is an admin
			if ($this->_user_is_admin)
				echo ", 'source'";
			echo "], '');\n";
			// XXX deal with minuses

			//echo "options.init(['all', 'source'], '');\n"; // XXX tmp, for testing
			?>
			
			/*
			try
			{
			*/
				var settings = {
					base_uri : '<?php echo $this->_asset_path; ?>',
					images_feed : '<?php if(!empty($this->_feeds['images'])) echo $this->_feeds['images']; ?>',
					sites_feed : '<?php if(!empty($this->_feeds['sites'])) echo $this->_feeds['sites']; ?>',
					finder_feed : '<?php if(!empty($this->_feeds['finder'])) echo $this->_feeds['finder']; ?>',
					default_site_regexp : new RegExp('<?php echo $this->_default_site_regexp; ?>'),
					default_type_regexp : new RegExp('<?php echo $this->_default_type_regexp; ?>'),
					use_https : <?php echo $this->_asset_protocol == 'https://' ? 'true' : 'false'; ?>,
					use_reason_integration : false,
                    use_xhtml : true,
					sanitize_unsecured : <?php echo (($this->_sanitize_unsecured) ? 'true' : 'false') ?>,
					options : options
				};

				loki = new UI.Loki;
				loki.init(document.getElementById('loki__<?php echo $this->_field_name; ?>__textarea'), settings);
			/*
			}
			catch(e)
			{
				mb('Error:', e.message);
				throw e;
			}
			*/
		}
		try
		{
			window.addEventListener('load', loki_do_onload, false);
		}
		catch(e)
		{
			try
			{
				window.attachEvent('onload', loki_do_onload);
			}
			catch(f)
			{
				throw(new Error('Neither the W3C nor the IE way of adding the event listener to start Loki worked. When the W3C way was tried, an error with the following message was thrown: <<' + e.message + '>>. When the IE way was tried, an error with the following message was thrown: <<' + f.message + '>>.'));
			}
		}
		</script>
		<?php // we htmlspecialchars because Mozilla converts all greater and less than signs in the textarea to entities, but doesn't convert amperstands to entities. When the value of the textarea is copied into the iframe, these entities are resolved, so as to create tags ... but then so are greater and less than signs that were originally entity'd. This is not desirable, and in particular allows people to add their own HTML tags, which is bad bad bad. ?>
		<textarea name="<?php echo $this->_field_name; ?>" rows="20" cols="80" id="loki__<?php echo $this->_field_name; ?>__textarea"><?php echo htmlentities($this->_field_value, ENT_QUOTES, 'UTF-8'); ?></textarea>
		<?php

	}
	
	/**
	 * Include all js files
	 *
	 * If loki_script_src, load the js files using a script src. 
	 * (Note: if we're behind https, this is much slower than echoing the js inline.)
	 * XXX: this should be a setting, probably, not a request var
	 *
	 * NOTE: This function will only run once per page generation so as not to bloat the page.
	 * it is important to make sure method contains only the hooks to the general Loki 
	 * libraries, and nothing else, because a single block of javascript is used for all Loki 
	 * instances on a page.
	 *
	 * NOTE: static vars in a method are shared by all objects in PHP
	 * we are depending on this fact to make sure that only the first Loki object spits 
	 * out the Loki js.
	 */
	function _include_loki_js()
	{
		static $loki_js_has_been_included = false;
		
		if(!$loki_js_has_been_included)
		{
			// Set up hidden iframe for clipboard operations
			?>
			<script type="text/javascript" language="javascript">
				UI__Clipboard_Helper_Privileged_Iframe__src = 'jar:<?php echo $this->_asset_protocol . $this->_asset_host . $this->_asset_path; ?>auxil/privileged.jar!/Clipboard_Helper_Privileged_Iframe.html';
				UI__Clipboard_Helper_Editable_Iframe__src = '<?php echo $this->_asset_protocol . $this->_asset_host . $this->_asset_path; ?>auxil/loki_blank.html';
			</script>
			<?php
			if(!empty($_REQUEST['loki_script_src']))
			{
				include_once(LOKI_2_INC.'auxil/preg_ls.php');
				$files = preg_ls($this->_asset_file_path . "js", true, "/.*\.js$/i");
				// the following two lines are a hack to get UI.js and Util.js first
				sort($files);
				$files = array_reverse($files);
				foreach ($files as $filename )
					echo '<script type="text/javascript" language="javascript" src="' . $this->_asset_path . 'js/' . $filename .'"></script>' . "\n";
			}
			// Otherwise, load the js files by echoing them all inline in the html.
			else
			{
				echo '<script type="text/javascript" language="javascript">';
				include_once(LOKI_2_INC.'auxil/preg_ls.php');
				$files = preg_ls($this->_asset_file_path . "js", true, "/.*\.js$/i");
				// the following two lines are a hack to get UI.js and Util.js first
				sort($files);
				$files = array_reverse($files);
				foreach ($files as $filename )
					readfile($this->_asset_file_path . "js/" . $filename);
	
				echo '</script>' . "\n";
			}
			$loki_js_has_been_included = true;
		}
	}

	/**
	 * Quotes a javascript regular expression.
	 *
	 * @param	string	$s	The unquoted regexp.
	 * @return	string		The quoted regexp.
	 */
	function js_regexp_quote($s)
	{
		$specials_pat = '/(\/|\.|\*|\+|\?|\||\(|\)|\[|\]|\{|\}|\\\\)/';
		// first two \\\\ are for one \ each in the ultimate javascript code; last \1 is a backreference:
		return preg_replace($specials_pat, '\\\\\\\\\1', $s);
	}

	/**
	 * Gets the field's value.
	 * @return  string  The value of the Loki-ized field (before being edited).
	 */
	function get_field_value()
	{ 
		return $this->_field_value; 
	}


	/**
	 * Sets the field's value.
	 * @param  string  $field_value  The value of the Loki-ized field (before being edited).
	 */
	function _set_field_value($field_value) 
	{
		$this->_field_value = $field_value;
	}
}
?>
