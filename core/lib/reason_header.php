<?php
/**
 * This file should be used to bring in the Reason libraries.
 * It must be included in any script execution for Reason to work.
 *
 * @package reason
 */
	if (ob_get_level() == 0) ob_start();
		rp_include_once( 'header.php' );
?>
