<?php
/**
 * I am deprecated.
 *
 * @todo remove me after i figure out what happens with domain define.
 * @package carl_util
 */


/**
 * Defines a constant using the settings for the current domain, if available, or the provided default value.
 * 
 * @param constant string name of the constant to define
 * @param default string default value to set if there is not a value for $GLOBALS['_current_domain_settings[$constant]
 * @return void
 */
function domain_define($constant, $default) 
{
	define ($constant, (isset($GLOBALS['_current_domain_settings'][$constant])) ? $GLOBALS['_current_domain_settings'][$constant] : $default);
	$GLOBALS['_default_domain_settings'][$constant] = $default; // lets store the default in case something cares about the difference
}
 
/**
 * Load in domain specific settings. Any setting defined with the domain_define will use domain specific settings when available
 */
include_once_lib ('settings/domain_settings.php');

/**
 * Load the package_settings for the reason_packge.
 */
//require_once( SETTINGS_INC . 'package_settings.php');

?>
