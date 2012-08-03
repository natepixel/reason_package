<?php

/**
 * Hidden input type library.
 *
 * @package disco
 * @subpackage plasmature
 */

require_once PLASMATURE_TYPES_INC."default.php";

/**
 * A hidden form input field.
 * @package disco
 * @subpackage plasmature
 */
class hiddenType extends defaultType
{
	var $type = 'hidden';
	var $_hidden = true;
	
	function grab()
	{
		$value = $this->grab_value();
		if($value !== NULL && $value != $this->get() && preg_replace('/\s+/','',$value) != preg_replace('/\s+/','',$this->get()))
		{
			trigger_error('hidden element ('.$this->name.') value changed in userland. This is deprecated (insecure) behavior and will not be allowed in future releases.');
		}
		parent::grab();
	}
	
	function get_display()
	{
		$str = '<input type="hidden" id="'.$this->name.'Element" name="'.$this->name.'" value="'.htmlspecialchars($this->get(),ENT_QUOTES).'" />';
		return $str;
	}
}

/**
 * @package disco
 * @subpackage plasmature
 */
class protectedType extends hiddenType
{
 	var $type = 'protected';
 	function grab()
	{
	}
}

/**
 * Type for data that should never be written to a page (e.g. a password hash)
 * @package disco
 * @subpackage plasmature
 */
class cloakedType extends hiddenType
{
	var $type = 'cloaked';
	function grab()
	{
	}
	function get_display()
	{
		// don't put any code here!
	} // }}
}
