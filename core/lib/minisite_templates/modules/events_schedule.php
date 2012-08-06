<?php
/**
 * @package reason
 * @subpackage minisite_modules
 */
 
 /**
  * include the base class and register the module with Reason
  */
	reason_include_once( 'minisite_templates/modules/events.php' );
	$GLOBALS[ '_module_class_names' ][ basename( __FILE__, '.php' ) ] = 'ScheduleEventsModule';

/**
 * A minisite module that includes additional information in listings (inc. description & location)
 */
class ScheduleEventsModule extends EventsModule
{
	function handle_params( $params )
	{
		$this->acceptable_params['list_type'] = 'schedule';
		parent::handle_params( $params );
	}
	
}
?>
