<?php
/**
 * @deprecated
 * @package carl_util
 */
 
/**
 * If trigger_warning exists, I am probably bootstrapped and should just trigger a useful warning. 
 */
if (function_exists('trigger_warning'))
{
	trigger_warning('paths.php is deprecated and should not be included', 2);
}
else // lets bootstrap
{
	trigger_error('paths.php is deprecated and should not be included - including bootstrap.php');
	include_once(dirname(__FILE__) . '/../../bootstrap.php');
}

?>