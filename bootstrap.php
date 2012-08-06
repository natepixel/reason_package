<?php
/**
 * This is a bootstrap file. It must be included by any web facing php scripts that use code in lib.
 *
 * It does the following:
 *
 * - defines INCLUDE_PATH to be the current Directory
 * - defined include_once_lib and include_once_www
 * - loads the error handler
 *
 * @package reason_package
 */

/** 
 * The location of the reason_package folder
 */
define ('INCLUDE_PATH', dirname(__FILE__) .'/');

/**
 * Function to include something from the reason_package lib directory
 *
 * - prefer the local folder
 * - fallback to the core folder
 *
 * @return mixed string path to included file or boolean false
 * @author Nathan White
 */
function include_once_lib( $path )
{
	$local = INCLUDE_PATH .'local/lib/'.$path;
	$core = INCLUDE_PATH .'core/lib/'.$path;
	
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

function include_once_www( $path )
{
	$local = INCLUDE_PATH .'local/www/'.$path;
	$core = INCLUDE_PATH .'core/www/'.$path;
	
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
 * Defines a constant using the settings for the current domain, if available, or the provided default value.
 * 
 * @param constant string name of the constant to define
 * @param default string default value to set if there is not a value for $GLOBALS['_current_domain_settings[$constant]
 *
 * @todo stop using and deprecate me
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
 * Include package settings
 */
include_once_lib('settings/package_settings.php');

/**
 * Load the error handler
 */
include_once_lib('carl_util/error_handler/error_handler.php');

?>