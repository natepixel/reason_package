<?php
include_once('paths.php');
include_once(CARL_UTIL_INC.'basic/misc.php');

/**
 * Base class for API functionality
 *
 * Handles content_type headers and super basic error handling.
 *
 * - Currently we support json, html, and xml
 *
 * Right now outputs a 404 if content is not set ... we likely need something more robust.
 *
 * // output json with the application/json content type
 * $api = new CarlUtilAPI('json');
 * $api->set_content( json_encode(array('text' => 'hello world')));
 * $api->run();
 *
 * @todo add more extensive error / status code support with flexbility by content type
 * @todo allow extensibility with content type definitions - remove hard coded content type map
 *
 * @version .1
 * @author Nathan White
 * @package carl_util
 * @subpackage api
 */
class CarlUtilAPI
{
	/**
	 * @var array supported_content_types
	 */
	protected $supported_content_types = array();

	/**
	 * If set to a string, we will look for this in request and set the content type to its value.
	 * @var mixed string content_type_request_key or boolean FALSE to disable.
	 */
	protected $content_type_request_key = FALSE;
	
	/**
	 * Define the content types to use for all formats that an API could support.
	 */
	private $content_type_map = array(
		'json' => 'application/json',
		'html' => 'text/html',
		'xml' => 'text/xml'
	);
			
	private $content_type;
	private $api_name;
	private $content;
	
	/**
	 * Constructor allows specification of supported content types. The first listed type is considered the "default" content type.
	 *
	 * @param mixed support_types - optional param - string specifying content type or array specifying multiples content types.
	 */
	function __construct($support_types = NULL)
	{
		if (isset($support_types))
		{
			if (is_string($support_types)) $support_types = array($support_types);
			$this->set_supported_content_types($support_types);
		}
		if ($supported_types = $this->get_supported_content_types())
		{
			$type = reset($supported_types);
			$this->set_content_type($type);
		}
		if ($this->get_content_type_request_key() && (isset($_REQUEST['format']) && check_against_regexp($_REQUEST['format'], array('safechars'))))
		{
			$this->set_content_type($_REQUEST['format']);
		}
		$this->setup_api();
	}

	/**
	 * Setup api is called at the end of __construct - it provides a way to dynamically setup parameters.
	 */
	protected function setup_api()
	{
	}
	
	/**
	 * Setup content is called first thing in the run method - it provides a way to dynamically set content.
	 */
	protected function setup_content()
	{
	}

	/** 
	 * @return mixed array setup_method_names or boolean FALSE
	 */
	final function get_content_type_request_key()
	{
		return (!empty($this->content_type_request_key)) ? $this->content_type_request_key : FALSE;
	}
	
	/**
	 * @param array array of content types - replaces anything that may already be set!
	 */	
	final function set_supported_content_types($array)
	{
		$this->supported_content_types = array();
		foreach ($array as $content_type)
		{
			$this->set_supported_content_type($content_type);
		}
	}

	/**
	 * @param string a content type name to add to the supported content types array
	 */
	final function set_supported_content_type($string)
	{
		if (!in_array($string, $this->supported_content_types))
		{
			array_push( $this->supported_content_types, $string );
		}
	}

	/**
	 * @param string content type to use
	 */
	final function set_content_type($string)
	{
		$this->content_type = $string;
	}

	/**
	 * @param string name for the api
	 */
	final function set_name($name)
	{
		$this->api_name = $name;
	}

	/**
	 * @param string content
	 */
	final function set_content($content)
	{
		$this->content = $content;
	}

	final function get_name()
	{
		return $this->api_name;
	}
	
	/**
	 * Returns the content type header.
	 *
	 * @return mixed string content type header or boolean FALSE
	 */
	final function get_content_type_header()
	{
		$content_type = $this->get_content_type();
		return ($content_type && isset($this->content_type_map[$content_type])) ? $this->content_type_map[$content_type] : FALSE;
	}
	
	/** 
	 * @return mixed array supported_content_types or boolean FALSE
	 */
	final function get_supported_content_types()
	{
		return (!empty($this->supported_content_types) && is_array($this->supported_content_types)) ? $this->supported_content_types : FALSE;
	}
	
	/**
	 * Returns the content type.
	 *
	 * @return mixed string content_type or boolean FALSE
	 */
	final function get_content_type()
	{
		return (isset($this->content_type)) ? $this->content_type : FALSE;
	}
	
	/** 
	 * @return mixed string content or boolean FALSE
	 */
	final function get_content()
	{
		return (isset($this->content)) ? $this->content : FALSE;
	}
	
	/**
	 * @return boolean
	 */
	final function have_supported_content_type()
	{
		if ( ($content_type = $this->get_content_type()) && ($content_types = $this->get_supported_content_types()) )
		{
			if (in_array($content_type, $content_types)) return true;
		}
		return false;
	}
	
	/**
	 * echo content in correct content type and provide 404 message in all potential content types.
	 *
	 * @todo add customizable messages, additional status code support
	 */
	final function run()
	{
		$this->setup_content();
		$content = $this->get_content();
		$content_type = $this->get_content_type();
		$content_type_header = $this->get_content_type_header();
		$content_type_supported = $this->have_supported_content_type();
		
		if ($content && $content_type && $content_type_header && $content_type_supported)
		{
			header('Content-type: ' . $content_type_header);
			echo $content;
		}
		elseif (!$content && $content_type && $content_type_header && $content_type_supported) // we have a header and supported type but no content - 404
		{
			http_response_code(404);
			header('Content-type: ' . $content_type_header);
			switch ($this->get_content_type())
			{
				case "html":
					echo '<html><body><h1>404</h1><p>Resource Not Found</p></body></html>';
					break;
				case "json":
					echo json_encode(array('status' => '404', 'error' => 'Resource Not Found'));
					break;
				case "xml":
					$xml = '<?xml version=\'1.0\' standalone=\'yes\'?>';
					$xml .= '<root><status>404</status><error>Resource Not Found</error></root>';
					break;
			}
		}
		elseif ($content_type && !$content_type_supported) // this request is invalid - no content type set
		{
			http_response_code(400);
			header('Content-type: text/html');
			echo '<html><body><h1>400</h1><p>The Content Type Requested is Not Supported</p></body></html>';
		}
		elseif (!$content_type) // this request is invalid - no content type set
		{
			http_response_code(400);
			header('Content-type: text/html');
			echo '<html><body><h1>400</h1><p>No Content Type</p></body></html>';
		}
	}
}
?>