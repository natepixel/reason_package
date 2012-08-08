<?php
/**
 * This is a bootstrap file. It must be included by any web facing php scripts that use code in lib.
 *
 * It does the following:
 *
 * - defines INCLUDE_PATH to be the directory that contains this file.
 * - defined include_once_lib and include_once_www
 * - loads the error handler
 *
 * Lets define some not user customizable things
 *
 * @todo define WEB_PATH (absolute web root)
 *
 * @todo error handling should be first thing - right now it has to be loaded late due to dependencies
 * @package reason_package
 */
ini_set("display_errors", "on");

/** 
 * The location of the reason_package folder
 */
define ('INCLUDE_PATH', dirname(__FILE__) .'/');

//define ('REASON_PACKAGE_DATA', INCLUDE_PATH . 'data/'); // is this necessary?
/**
 *
 */
 
/**
 * SETTINGS_INC is deprecated (really??) but we keep it here list in case. It would be nice to trigger an error whenever it is used if there was a good way to do that.
 */
define ('SETTINGS_INC', INCLUDE_PATH . 'core/lib/settings/');

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
		if (function_exists('trigger_warning'))
		{
			trigger_error('File does not exist at ' . $local . ' or ' . $core);
			
		}
		else trigger_error('File does not exist at ' . $local . ' or ' . $core);
		foreach(debug_backtrace() as $k=>$v){ 
        if($v['function'] == "include" || $v['function'] == "include_once" || $v['function'] == "require_once" || $v['function'] == "require"){ 
            $backtracel .= "#".$k." ".$v['function']."(".$v['args'][0].") called at [".$v['file'].":".$v['line']."]<br />"; 
        }else{ 
            $backtracel .= "#".$k." ".$v['function']."() called at [".$v['file'].":".$v['line']."]<br />"; 
        } 
    }
    echo 'bah';
    echo $backtracel;
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