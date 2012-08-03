<?php
/** 
 * Configuration file for directory services module
 * @package carl_util
 * @subpackage dir_service
 */

/**
 * $available_services contains the list of services that you want to use for lookups, in the order
 * that you want to use them. If a lookup (or authentication) fails in the first service, it will 
 * fall through to the next, until a success occurs or all have been checked.
 *
 * Services are tied to service files in the "services" directory.  They have names like "ds_default", 
 * "ds_ldap", etc.  The names of the services are just "default", "ldap", etc. The "default" service is just a 
 * stub from which real services inherit. It will fail all lookups.
 *
 * You can change the services used on the fly by calling the set_service method on the general 
 * directory class.
 */

include_once('paths.php');

$available_services = array('reason');

$service_names_to_paths = array(
	'default'=>'services/ds_default.php',
	'ldap'=>'services/ds_ldap.php',
	'mysql'=>'services/ds_mysql.php',
	'reason'=>REASON_INC.'hooks/dir_service.php',
);


?>
