<?php
/**
 * @package reason
 * @subpackage feeds
 */

/**
 * Include dependencies & register feed with Reason
 */
include_once( 'reason_header.php' );
reason_include_once( 'feeds/page_tree.php' );
$GLOBALS[ '_feed_class_names' ][ basename( __FILE__, '.php' ) ] = 'faqFeed';

class faqFeed extends pageTreeFeed
{
	var $page_types = array('faqs',);
	var $query_string = 'faq_id';
	
	function alter_feed()
	{
		$this->feed->set_item_field_map('title','description');
		$this->feed->set_item_field_map('description','content');
		$this->feed->set_item_field_map('pubDate','datetime');
		$this->feed->set_item_field_map('author','author');
		
		$this->feed->es->set_order( 'last_modified DESC' );
	}
	function set_general_feed_rules()
	{
		if(!$this->site_specific)
		{
			$this->feed->es->add_relation( 'entity.no_share = "0"' );
			$this->feed->es->add_right_relationship_field( 'owns', 'site' , 'site_state' , 'site_state' );
			$this->feed->es->add_relation( 'site_state = "Live"' );
		}
	}
}

?>
