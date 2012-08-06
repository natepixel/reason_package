<?php
/**
 * Provides a web service for the Thor WYSIWYG editor to update the temporary XML file in the DB
 * @package thor
 */

include_once ( SETTINGS_INC.'thor_settings.php' );
include_once_lib( 'carl_util/dev/prp.php');
include_once_lib( 'carl_util/db/db.php');
include_once_lib( 'carl_util/db/sqler.php');

$tmp_id = $_REQUEST["tmp_id"];
$xml = $_REQUEST["xml"];

connectDB( THOR_FORM_DB_CONN );

$sqler = new SQLER;
if ( !empty($xml) )
{
	if ( !empty($tmp_id) )
	{
		$sqler->update_one('thor', Array('content' => conditional_stripslashes($xml)), $tmp_id);
	}
	else
	{
		$sqler->insert('thor', Array('content' => conditional_stripslashes($xml)));
		$tmp_id = mysql_insert_id();
		echo $tmp_id;
	}
}
else
{
	die('Please provide xml content.');
}

?>
