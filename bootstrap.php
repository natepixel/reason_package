<?php
/**
 * This is the reason_package bootstrap file. It must be included by any web facing php scripts that use code in reason_package/lib.
 *
 * It defines INCLUDE_PATH and the method reason_package_include_once.
 *
 * @package reason_package
 */

/** 
 * The location of the reason_package folder
 */
define ('INCLUDE_PATH', dirname(__FILE__));

/**
 * Function to include something from the reason_package lib directory
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
?>
