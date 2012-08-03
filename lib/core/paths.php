<?php
/**
 * This is the reason_package bootstrap file. It must be included by any web facing php scripts that use code in reason_package/lib.
 *
 * It defines INCLUDE_PATH and the method reason_package_include_once.
 *
 * reason
 *
 * @package carl_util
 */

/** 
 * The location of the reason_package folder
 */
define ('INCLUDE_PATH', dirname(__FILE__) . '../../');

/**
 * Include something from the reason_package lib directory
 *
 * - prefer the local folder
 * - fallback to the core folder
 *
 * @return mixed string path to included file or boolean false
 * @author Nathan White
 */
function reason_package_include_once( $path )
{
	$local = INCLUDE_PATH .'lib/local/'.$path;
	$core = INCLUDE_PATH .'lib/core/'.$path;
	
	if (file_exists($local) || file_exists($core))
	{
		if (file_exists($local))
		{
			include_once($local);
			return $local;
		}
		else
		{
			include_once($core);
			return $core;
		}
	}
	else
	{
		trigger_error('File does not exist at ' . $local . ' or ' . $core);
		return false;
	}
}

/**
 * Require something from the reason_package lib directory
 *
 * - prefer the local folder
 * - fallback to the core folder
 *
 * @todo do i really need this?
 * @return mixed string path to included file or boolean false
 * @author Nathan White
 */
function reason_package_require_once( $path )
{
	$local = INCLUDE_PATH .'lib/local/'.$path;
	$core = INCLUDE_PATH .'lib/core/'.$path;
	
	if (file_exists($local) || file_exists($core))
	{
		if (file_exists($local)) require_once($local);
		else require_once($core);
		return true;
	}
	else
	{
		trigger_error('File does not exist at ' . $local . ' or ' . $core, FATAL);
		return false;
	}
}

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
 * The location of the reason_package settings folder - this should be outside the web tree
 *
 * By default, the constant will be set to settings_local if such a directory exists parallel to settings
 */
define ('SETTINGS_INC', 
       (file_exists(INCLUDE_PATH . 'settings_local'))
       ? INCLUDE_PATH . 'settings_local/'
       : INCLUDE_PATH . 'settings/');
       
/**
 * Load in domain specific settings. Any setting defined with the domain_define will use domain specific settings when available
 */
include_once (SETTINGS_INC . 'domain_settings.php');

/**
 * Load the package_settings for the reason_packge.
 */
require_once( SETTINGS_INC . 'package_settings.php');
?>
