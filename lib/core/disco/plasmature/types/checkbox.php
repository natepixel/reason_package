<?php

/**
 * Checkbox type library.
 * @package disco
 * @subpackage plasmature
 */

require_once PLASMATURE_TYPES_INC."default.php";

/**
 * Displays a checkbox.
 * @see checkboxFirstType
 * @package disco
 * @subpackage plasmature
 */
class checkboxType extends defaultType
{
	var $type = 'checkbox';
	var $checkbox_id;
	var $description;
	var $checked_value = 'true';
	var $type_valid_args = array('checkbox_id', 'checked_value', 'description');
	function grab()
	{
		$HTTP_VARS = $this->get_request();
		if ( isset( $HTTP_VARS[ $this->name ] ) )
		{
			if( !is_array( $HTTP_VARS[ $this->name ] ) AND !is_object( $HTTP_VARS[ $this->name ] ) )
				$this->set( trim($HTTP_VARS[ $this->name ]) );
			else
				$this->set( $HTTP_VARS[ $this->name ] );
		}
		else
		{
			$this->set( '' );
		}
	}
	function get_display()
	{
		$this->checkbox_id = 'checkbox_'.$this->name;
		$str = '<input type="checkbox" id="'.$this->checkbox_id.'" name="'.$this->name.'" value="'.$this->checked_value.'"';
		if ( $this->value )
		{
			$str .= ' checked="checked"';
		}
		$str .= ' class="checkbox">';
		if (!empty($this->description)) {
			$str .= ' <label class="smallText" for="'.$this->checkbox_id.'">'.$this->description.'</label>';
		}
		return $str;
	}
}

/**
 * Like {@link checkboxType}, but displays the label to the right of the
 * checkbox.
 *
 * @see checkboxType
 * @package disco
 * @subpackage plasmature
 *
 * @todo Add a variable to the default class (and corresponding box class
 *       functionality) that lets you choose lets you choose where the label
 *       should be displayed for each element (left, right, above) and then
 *       deprecate this class.
 */
class checkboxfirstType extends checkboxType {
	var $type = 'checkboxfirst';
	var $_labeled = false;
	
	/**
	 * Set to false because {@link get_display()} includes the markup for the display name.
	 * Setting this to true will show the display name both to the left and to the right of the checkbox.
	 */
	var $use_display_name = false;
	
	function get_display()
	{
		return parent::get_display().' <label for="'.$this->checkbox_id.'">'.$this->display_name.'</label>';
	}
}
