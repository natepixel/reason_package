<?php
/**
 * Includes connectDB.php and db_query.php, along with a few useful libraries
 *
 * @package carl_util
 * @subpackage db
 *
 * @todo remove old method of enforcing require_once
 */

/**
 * Old php3-style method of enforcing require_once
 */
if(!defined("_DBPHP3" ))
{
	define("_DBPHP3", 1);
	include_once_lib( 'carl_util/db/connectDB.php' );
	include_once_lib( 'carl_util/db/db_query.php' );
}
?>
