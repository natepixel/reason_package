<?php
/**
 *
 * @author Nick Jones
 * Simple character counting script that responds to AJAX POST
 * Used to maintain consistency in character counting between counting characters in real time in
 * the browser and with counting characters in Reason/php/database
 */
    include_once( 'paths.php');
    include_once( CARL_UTIL_INC . 'basic/misc.php' );
    if(isset($_REQUEST['text']))
    {
	    echo carl_util_count_html_text_characters($_REQUEST['text']);
	}
	else
	{
		echo 0;
	}
?>