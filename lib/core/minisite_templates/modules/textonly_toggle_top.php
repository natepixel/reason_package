<?php
/**
 * @package reason
 * @subpackage minisite_modules
 */
 	/**
 	 * Include the parent class and register the module with Reason
 	 */
	reason_include_once( 'minisite_templates/modules/textonly_toggle.php' );

	$GLOBALS[ '_module_class_names' ][ basename( __FILE__, '.php' ) ] = 'TextOnlyToggleTopModule';

	/**
	 * A minisite module that displays a link to switch between full graphics and limited graphics mode
	 *
	 * This module is designed to use the class "hide" when in full graphics mode
	 */
	class TextOnlyToggleTopModule extends TextOnlyToggleModule
	{
		function generate_class()
		{
			if (!empty($this->textonly))
				return 'fullGraphicsLink';
			else
				return 'hide';
		}
		function get_documentation()
		{
			if (!empty($this->textonly))
				return parent::get_documentation();
			return false;
		}
	}
?>
