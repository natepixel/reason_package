<?php
/**
 * Wraps up several useful functions for managing database connections
 *
 * @package carl_util
 * @subpackage db
 */

/**
 * include the error handler so that errors are logged, etc.
 */
include_once_lib( 'carl_util/error_handler/error_handler.php' );

/**
 * Set up a spot in the $GLOBALS array to store the current database connection name
 */
$GLOBALS['_current_db_connection_name'] = '';

/**
 * Wraps up MySQL database connection code.
 * Uses get_db_credentials() to lookup authenticaton information from a central XML file.
 * All parameters except for dbName are deprecated.
 *
 * @param string $dbName A database connector name - this maps to an entry in the XML file
 * @param string $dbuser Deprecated - is now ignored
 * @param string $dbpasswd Deprecated - is now ignored
 * @param string $dbhost Deprecated - is now ignored
 * @return resource database connection resource
 *
 * @todo remove the $dbuse, $dbpasswd, and $dbhost parameters entirely to remove a potential source of confusion
 */
function connectDB($dbName, $dbuser = '', $dbpasswd = '', $dbhost='')
{
	$db_info = get_db_credentials( $dbName );
	// try to connect to server
	// If a connection can not be made, sleep for 1 second and try again, up to a maximum of $max_tries times
	$max_tries = 5;
	$tries = 0;
	do
	{
		// wait for one second if this is not the first try
		if( $tries > 0 )
		{
			trigger_error('Unable to connect to database, sleeping and trying again (Reconnect attempt #'.$tries.'; Error #'.mysql_errno().':'.mysql_error().')', WARNING);
			sleep( 1 );
		}
		$db = @mysql_connect($db_info['host'], $db_info['user'], $db_info['password']);
		$tries++;
	} while(!$db AND $tries <= $max_tries);
	
	if( !$db )
	{
		$db_info['password'] = '*************'; // replace password so it will not be exposed onscreen - nwhite
		trigger_fatal_error('Unable to connect to database using connection "'.$dbName.'" (Error #'.mysql_errno().':'.mysql_error().')');
	}
	elseif( $tries > 1 )
	{
		trigger_error('Successfully connected to database after an initial failure.  Reconnect attempts: '.($tries-1));
	}

	// select database
	if( !mysql_select_db($db_info[ 'db' ], $db) )
	{
		$db_info['password'] = '*************'; // replace password so it will not be exposed onscreen - nwhite
		trigger_error( 'Unable to select database "'.$db_info[ 'db' ].'" ('.mysql_error().')', EMERGENCY );
	}
	$GLOBALS['_current_db_connection_name'] = $dbName;
	return $db;
}

/**
 * Find out what database connection is currently in use
 * @return string name of db connection
 */
function get_current_db_connection_name()
{
	return (isset($GLOBALS['_current_db_connection_name'])) ? $GLOBALS['_current_db_connection_name'] : false;
}

/**
 * Find out what database is currently in use
 * @return string name of db
 */
function get_database_name()
{
	$conn_name = get_current_db_connection_name();
	$creds = get_db_credentials($conn_name);
	return $creds['db'];
}

/**
 * Return authentication credentials for the specified database connection.
 *
 * @param string $conn_name The name of the db connection you want to retrieve
 * @param boolean $lack_of_creds_is_fatal defaults to true for historical purposes
 * @return array Array with all the db connection info defined for the specified named connection.
 */
function get_db_credentials( $conn_name, $lack_of_creds_is_fatal = true )
{
	static $db_info;
	// if db_info has not been set, this is the first time this function has been run.
	if( !isset($db_info) )
	{
		if( !defined( 'DB_CREDENTIALS_FILEPATH' ) ) trigger_fatal_error('The DB_CREDENTIALS_FILEPATH constant is not defined.');
		$db_info = array();
		require_once( XML_PARSER_INC . 'xmlparser.php' );
        if(file_exists(DB_CREDENTIALS_FILEPATH) && ($xml = trim(file_get_contents(DB_CREDENTIALS_FILEPATH))))
        {
        	$xml_parse = new XMLParser($xml);
        	$parse = $xml_parse->Parse();
        	if (isset($xml_parse->document->database))
        	{
        		foreach ($xml_parse->document->database as $database)
  	 	    	{
  	 	     		$tmp = array();
  	 	     		$db_conn_name = (isset($database->connection_name[0]->tagData)) ? $database->connection_name[0]->tagData : false;
  	 	     		$tmp['db'] = (isset($database->db[0]->tagData)) ? $database->db[0]->tagData : false;
   	    	 		$tmp['user'] = (isset($database->user[0]->tagData)) ? $database->user[0]->tagData : false;
   	    	 		$tmp['password'] = (isset($database->password[0]->tagData)) ? $database->password[0]->tagData : false;
   	    	 		$tmp['host'] = (isset($database->host[0]->tagData)) ? $database->host[0]->tagData : false;
   	    	 		if ($db_conn_name && ($tmp['db'] !== false)
   	    	 						  && ($tmp['user'] !== false)
   	    	 						  && ($tmp['password'] !== false)
   	    	 						  && ($tmp['host'] !== false))
   	    	 		{
   	    	 			$db_info[$db_conn_name] = $tmp;
   	    	 		}
   	    	 		else
   	    	 		{
   	    	 			$invalid_entries[] = $db_conn_name;
   	    	 		}
        		}
        	}
        	if (isset($invalid_entries))
        	{
        		$invalid_str = ($invalid_entries == 1) ? $invalid_entries . ' entry appears' : $invalid_entries . ' entries appear'; 
        		turn_carl_util_error_context_off();
        		foreach ($invalid_entries as $conn_name)
        		{
        			if (!empty($conn_name))
        			{
        				trigger_error('The connection ' . $conn_name . ' in the db credentials XML file ('.DB_CREDENTIALS_FILEPATH.') appears to have missing or invalid values.', WARNING);
        			}
        			else trigger_error('An entry without a connection name is defined in the db credentials XML file ('.DB_CREDENTIALS_FILEPATH.')', WARNING);
        		}
        		turn_carl_util_error_context_on();
        	}
        	if (empty($db_info)) trigger_error('Check the xml in the db credentials XML file ('.DB_CREDENTIALS_FILEPATH.') - no valid database connection information could be built.', WARNING);
		}
		else
		{
			trigger_fatal_error('The DB_CREDENTIALS_FILEPATH ('.DB_CREDENTIALS_FILEPATH.') refers to a file that is missing or does not have any content.');
		}
	}

	// if this was the first time, the code above should have run successfully so db_info is populated.
	// if this is not the first time, then the code above should have been skipped since it was populated the first
	// run of the function.
	if( isset( $db_info[ $conn_name ] ) )
	{
		return $db_info[ $conn_name ];
	}
	else
	{
		// disable context display so we do not show passwords on screen.
		turn_carl_util_error_context_off();
		if ($lack_of_creds_is_fatal)
		{
			trigger_fatal_error('Unable to use database connection '.$conn_name.' - No credential information found for the connection named ' . $conn_name . ' in database credential file ('.DB_CREDENTIALS_FILEPATH.').', 2);
		}
		else
		{
			trigger_warning('Unable to use database connection '.$conn_name.' - No credential information found for the connection named ' . $conn_name . ' in database credential file ('.DB_CREDENTIALS_FILEPATH.').', 2);
		}
		turn_carl_util_error_context_on();
	}
	return false;
}

?>
