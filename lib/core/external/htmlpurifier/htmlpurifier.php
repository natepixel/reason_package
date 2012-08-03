<?php
include_once('paths.php');
reason_package_include_once( 'carl_util/basic/misc.php');

/**
 * Loads the HTML_Purifier class appropriate for the version of PHP
 */
if (!defined("HTMLPURIFIER_CACHE")) define("HTMLPURIFIER_CACHE", '/tmp/');
require_once( HTML_PURIFIER_INC . 'htmlpurifier-4.4.0-standalone/HTMLPurifier.standalone.php' );
?>
