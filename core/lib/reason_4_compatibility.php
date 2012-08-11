<?php
/**
 * Reason 4 Compatibility Library
 *
 * Defines deprecated functions used in Reason 4.0 - provides appropriate warnings and invokes new functionality.
 */

function reason_include_once( $path )
{
	trigger_error('reason_include_once is deprecated - use include_once_lib instead');
	return include_once_lib( $path );
}

function reason_require_once( $path )
{
	trigger_error('reason_require_once is deprecated - use include_once_lib instead');
	return include_once_lib( $path );
}

function file_is_includable($file)
{
	$paths = explode(PATH_SEPARATOR, get_include_path());
	foreach ($paths as $path)
	{
		if ($path != ".")
		{
			$fullpath = $path . DIRECTORY_SEPARATOR . $file;
 			if (file_exists($fullpath)) return true;
		}
        }
	return false;
}

// lets set the ini path to include reason_package/core/lib such that reason_header.php and paths.php can be included with a plain include_once
if (!file_is_includable('reason_header.php'))
{
	$include_path = ini_get('include_path');
	$path_to_reason_package = realpath(dirname(__FILE__)).'/';
	$new_include_path = $include_path.PATH_SEPARATOR.$path_to_reason_package;
	ini_set('include_path', $new_include_path);
}

// start a session if this is a web page and if the session variable is set.
if( empty( $_SERVER[ '_' ] ) )
{
	ini_set( 'session.use_cookies', 1 );
	ini_set( 'session.use_only_cookies', 1 );
	ini_set( 'session.use_trans_sid', 0 );
	session_start();
}

// start output buffering
ob_start();
	
// setup the REASON_LOGIN_URL constant dynamically based upon value of HTTPS_AVAILABLE
if (HTTPS_AVAILABLE)
{
	define( 'REASON_LOGIN_URL', 'https://'.HTTP_HOST_NAME.'/login/' );
}
else define( 'REASON_LOGIN_URL', 'http://'.HTTP_HOST_NAME.'/login/' );
	
if (function_exists('date_default_timezone_set')) // for php5, set default timezone if the constant is defined
{
	if (defined('REASON_DEFAULT_TIMEZONE'))
	{
		date_default_timezone_set(REASON_DEFAULT_TIMEZONE);
	}
}
if(!defined('REASON_DEFAULT_ALLOWED_TAGS'))	
{
	define('REASON_DEFAULT_ALLOWED_TAGS','<a><abbrev><acronym><address><area><au><author><b><big><blockquote><bq><br><caption><center><cite><code><col><colgroup><credit><dfn><dir><div><dl><dt><dd><em><fn><form><h1><h2><h3><h4><h5><h6><hr><i><img><input><lang><lh><li><link><listing><map><math><menu><multicol><nobr><note><ol><option><p><param><person><plaintext><pre><samp><select><small><strike><strong><sub><sup><table><tbody><td><textarea><tfoot><th><thead><tr><tt><u><ul><var><wbr>');
}
?>