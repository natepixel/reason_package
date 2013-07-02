<?php
/**
 * include dependencies
 * TODO: require authentication.
 */
$reason_session = false;
include_once( 'reason_header.php' );
include_once( CARL_UTIL_INC . 'basic/misc.php');
reason_include_once( 'classes/entity_selector.php' );
reason_include_once('function_libraries/image_tools.php');
reason_include_once('classes/object_cache.php');

$start_time = get_microtime();
/**
 * ReasonJSON is just a stub that you can extend for some JSON-
 * handling goodness.
 **/
class ReasonJSON
{
	var $es;
	var $_raw_items;
	var $_caching;
	var $_items;
	var $json;
	var $_num;
	var $_offset;
	var $_type;
	var $_site_id;
	var $_last_mod;

	/**
	 * The constructor instantiates an entity and adds some
	 * defaults.
	 *
	 **/
	function __construct($type, $site_id)
	{
		if (empty($type) || empty($site_id))
			trigger_error("A type or ID was not given for the json generator.", E_ERROR);

		$this->es = new entity_selector($site_id);
		$this->es->add_type($type);
		$this->es->set_order('last_modified DESC');

		$this->type($type);
		$this->site_id($site_id);
		$this->last_mod(false);
	}

	function get_most_recent_date()
	{
		if (!isset($this->_most_recent)) {
			$esCopy = carl_clone($this->es);
			$esCopy->set_num(1);
			$esCopy->limit_tables();
			$esCopy->limit_fields('last_modified');
			$result = $esCopy->run_one();
			$this->_most_recent = array_shift($result)->get_value('last_modified');
		}

		return $this->_most_recent;
	}

	function type($type = NULL) {
		if (empty($type))
			return $this->_type;
		else
			$this->_type = $type;
	}
	function site_id($site_id = NULL)
	{
		if (empty($site_id))
			return $this->_site_id;
		else
			$this->_site_id = $site_id;
	}

	function cache($key = NULL, $obj = NULL)
	{
		if (isset($this->_cache)) {
			$cache = $this->_cache;
		} else {
			$cache = new ReasonObjectCache();
			$most_recent = $this->get_most_recent_date();
			if (empty($key) && empty($obj)) {
			// Retrieve particular cached results
				if ($this->last_mod() != false && $this->last_mod() != null) {
					$cacheKey = "jsongen_" . $this->type() . $this->site_id() . $this->last_mod();
					$cache->init($cacheKey);
				} else { // Retrieve the most recent cached results
					$cacheKey = "jsongen_" . $this->type() . $this->site_id() . $most_recent;
					$cache->init($cacheKey);
				}
			} else {
				$cache->init($key);
				$cache->set($obj);
				return;
			}
			return $cache->fetch();
		}
	}

	function last_mod($last_mod = NULL)
	{
		if (empty($last_mod))
			return $this->_last_mod;
		else
			$this->_last_mod = $last_mod;
	}

	function _fetch_raw_items() {
		$this->_raw_items = $this->es->run_one();
	}

	function _get_items() {
		if (!$this->_items) {
			$this->_fetch_raw_items();
			$this->_transform_and_count_items();
		}
		
		return $this->_items;
	}

	function num($num = NULL)
	{
		if (empty($num))
			return $this->_num;
		else {
			$this->_num = $num;
			$this->es->set_num($num);
		}
	}
	function offset($offset = NULL)
	{
		if (empty($offset))
			return $this->_offset;
		else
			$this->_offset = $offset;
	}
}

class ReasonImagesJSON extends ReasonJSON
{
	function __construct($site, $type)
	{
		parent::__construct($site, $type);

		$this->site_id($site);
		$this->type($type);

		if( !empty($_REQUEST['q']) )
		{
			$this->es->add_relation('(entity.name LIKE "%'.addslashes($_REQUEST['q']) . '%"' .
						      ' OR meta.description LIKE "%' . addslashes($_REQUEST['q']) . '%"'.
							  ' OR meta.keywords LIKE "%' . addslashes($_REQUEST['q']) . '%"'.
							  ' OR chunk.content LIKE "%' . addslashes($_REQUEST['q']) . '%"'.
							  ')');
		}
	}

	/**
	 * After items have been fetched from the db, this function does some
	 * work to ready them for serialization.
	 **/
	function _transform_and_count_items()
  {
    $this->_items['count'] = count($this->_raw_items);
		if (empty($this->_raw_items))
		  return;
    else foreach ($this->_raw_items as $k => $v)
    {
      $this->_items['items'][] = $this->_transform_item($v);
		}
	}

	/**
	 * This function should be overloaded in each new ReasonJSON type. It is the
	 * mapping of values from the Reason object to the JSON object.
	 **/
  function _transform_item($v)
  {
			$newArray = array();
			$newArray['id'] = $v->get_value('id');
			$newArray['name'] = $v->get_value('name');
			$newArray['description'] = $v->get_value('description');
			$newArray['pubDate'] = $v->get_value('creation_date');
      $newArray['lastMod'] = $v->get_value('last_modified');
			$newArray['link'] = $this->make_image_link($newArray['id'], 'standard');
			$newArray['thumbnail'] = $this->make_image_link($newArray['id'], 'thumbnail');
      $newArray['content'] = $v->get_value('content');
      $newArray['keywords'] = $v->get_value('keywords');

			return $newArray;
  }


	function _make_chunk($obj)
	{
		$chunk = Array();
		$chunk['count'] = $obj['count'];
		$chunk['items'] = array_slice($obj['items'], $this->offset(), $this->num());
		return $chunk;
	}

	function make_image_link($id, $size=null)
	{
		$filename = reason_get_image_filename($id, $size);
		return 'http://' . REASON_HOST.WEB_PHOTOSTOCK. $filename;
	}

	function caching($caching = NULL) {
		if (isset($caching))
			$this->_caching = $caching;
		else
			return $this->_caching;
	}

	function run()
	{
		$cached_results = $this->cache();
		if (!$cached_results || !$this->caching()) {
			$this->es->set_order( 'entity.last_modified DESC, dated.datetime DESC, entity.name ASC' );
			$this->_get_items();
			$cacheKey = "jsongen_" . $this->type() . $this->site_id() . ($this->last_mod() ? $this->last_mod() : $this->get_most_recent_date());
			$this->cache($cacheKey, $this->_items);
		}
		return json_encode($this->_make_chunk($this->cache()));
	}
}


if (isset($_GET['type']) && isset($_GET['site_id'])) {
		$type = turn_into_string($_GET['type']);
		$site_id = turn_into_int($_GET['site_id']);
		$last_mod = (isset($_GET['lastmod'])) ? $_GET['lastmod'] : false;
		if (id_of($type) == id_of('image')) {
				$reasonImagesJson = new ReasonImagesJSON(id_of($type), $site_id);
				$num = !empty($_REQUEST['num']) ? turn_into_int($_REQUEST['num']) : '500';
				$offset = !empty($_REQUEST['offset']) ? turn_into_int($_REQUEST['offset']) : '0';
				$reasonImagesJson->num($num);
				$reasonImagesJson->offset($offset);
				$reasonImagesJson->last_mod($last_mod);
				$reasonImagesJson->caching((isset($_GET['caching']))? turn_into_boolean($_GET['caching']) : true);
				print($reasonImagesJson->run());
		}
} else
{
	http_response_code(400);
	echo json_encode(array("error" => 400));
}

reason_log_page_generation_time( round( 1000 * (get_microtime() - $start_time) ) );


?>
