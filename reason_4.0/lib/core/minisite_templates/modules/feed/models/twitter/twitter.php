<?php
/**
 * @package reason
 * @subpackage classes
 */

/**
 * Include the base class
 */
include_once( 'reason_header.php' );
include_once( CARL_UTIL_INC . 'basic/misc.php' );
reason_include_once( 'classes/mvc.php' );

/**
 * Register MVC component with Reason
 */
$GLOBALS[ '_reason_mvc_model_class_names' ][ reason_basename( __FILE__) ] = 'ReasonTwitterFeedModel';

/**
 * ReasonTwitterFeedModel returns the last 20 tweets, json_decoded and put in an associative array, from the Twitter API v1.1.
 *
 * It requires twitter_api_settings.php to be populated with valid credentials.
 *
 * We add a key to each tweet called 'html' which is populated with a version that basically mimics what the old SimplePie twitter module provided.
 *
 * You may choose to roll your own view, including entity handling, in the view.
 *
 * User Configurables
 *
 * - cache_duration
 * - screen_name OR
 * - search_string
 *
 * @author Nathan White
 */
class ReasonTwitterFeedModel extends ReasonMVCModel // implements ReasonFeedInterface
{
	/**
	 * Sets a few configuration defaults
	 *
	 * - cache_duration - 600 seconds (10 minutes)
	 */
	var $config = array('cache_duration' => 600);

	/**
	 * Make sure that the model is configured with a valid URL.
	 *
	 * @return mixed model data
	 */
	function build()
	{
		if ($this->config('screen_name') || $this->config('search_string'))
		{
			$roc = new ReasonObjectCache('reason_twitter_feed_model_tweets_for_' . $this->config('screen_name'), $this->config('cache_duration'));
			$tweets = $roc->fetch();
			if ($tweets === FALSE) // nothing in the cache - lets get em
			{
				$obj = $this->get_oauth_object();
				if ($this->config('screen_name'))
					$result = $obj->request('GET', $obj->url('1.1/statuses/user_timeline'), array('screen_name' => $this->config('screen_name')));
				else if ($this->config('search_string'))
					$result = $obj->request('GET', $obj->url('1.1/search/tweets.json'), array('q' => $this->config('search_string'), 'result_type' => 'recent'));

				if ($result == '200')
				{
					$tweets = json_decode($obj->response['response'], true); // make an associative array
					$this->add_html_version_to_tweets($tweets);
					$tweets = (is_array($tweets)) ? $tweets : array();
					$roc->set($tweets);
				}
				else // if we have something older in the cache lets refresh it and use it but trigger a warning.
				{
					$roc2 = new ReasonObjectCache('reason_twitter_feed_model_tweets_for_' . $this->config('screen_name'), -1);
					$tweets = $roc2->fetch();
					if ($tweets !== FALSE) // if we found something lets refresh the timer on the cache - perhaps twitter is down.
					{
						trigger_error('Using expired tweets for ' . $this->config('screen_name') . ' because the twitter API responded with code ' . $result . ' instead of giving us tweets');
						$roc->set($tweets);
					}
					else // we could have much more robust error messages here if we wanted.
					{
						trigger_error('No new or expired tweets available for ' . $this->config('screen_name') . '. The twitter API returned code ' . $result . ' - we will retry when we have a fresh cache interval.');
						$tweets = array();
						$roc->set($tweets);
					}
				}
			}
			return $tweets;
		}
		else
		{
			trigger_error('The ReasonTwitterFeedModel must be provided with the configuration parameter screen_name or search_string.', FATAL);
		}
	}

	/**
	 * Include appropriate settings files and create the thmOAuth object.
	 *
	 * @return object tmhOAuth object
	 */
	protected function get_oauth_object()
	{
		if (!isset($this->_oauth_obj))
		{
			require_once(SETTINGS_INC . 'twitter_api_settings.php');
			require_once(TMHOAUTH_INC . 'tmhOAuth.php');
			$this->_oauth_obj = new tmhOAuth(array(
				'consumer_key'    => TWITTER_API_CONSUMER_KEY,
				'consumer_secret' => TWITTER_API_CONSUMER_SECRET,
				'user_token'      => TWITTER_API_ACCESS_TOKEN,
				'user_secret'     => TWITTER_API_ACCESS_TOKEN_SECRET,
			));
		}
		return $this->_oauth_obj;
	}

	/**
	 * Add an HTML version of each tweet suitable for display. Here is what we do in detail.
	 *
	 * - If this is a retweet, unset retweeted_status prior to processing (this maintains the RT: @ScreenName which is otherwise stripped).
	 * - Use the tmhUtilities::entify_with_options to get our HTML version.
	 * - Store the html version in the original array as tweet['html'].
	 *
	 * @todo what I really want is the option to get the oembed version of our tweets from the API but twitter only lets you get one at a time. bah.
	 */
	protected function add_html_version_to_tweets(&$tweets)
	{
		foreach ($tweets as $k => $v)
		{
			if (isset($v['retweeted_status'])) unset($v['retweeted_status']);
			$html = $this->entify_with_options($v);
			$tweets[$k]['html'] = $html;
		}
	}
	
	/**
	 * Entifies the tweet using the given entities element, using the provided
	 * options.
	 * 
	 * Originally sourced from tmhUtilities::entify_with_options in
	 * https://github.com/themattharris/tmhOAuth in versions prior to 0.8.0 
	 * 
	 * @param array $tweet the json converted to normalised array
	 * @param array $options settings to be used when rendering the entities
	 * @param array $replacements if specified, the entities and their replacements will be stored to this variable
	 * @return the tweet text with entities replaced with hyperlinks
	 */
	public function entify_with_options($tweet, $options = array(), &$replacements = array())
	{
		$default_opts = array(
			'encoding' => 'UTF-8',
			'target' => '',
		);

		$opts = array_merge($default_opts, $options);

		$encoding = mb_internal_encoding();
		mb_internal_encoding($opts['encoding']);

		$keys = array();
		$is_retweet = false;

		if (isset($tweet['retweeted_status'])) {
			$tweet = $tweet['retweeted_status'];
			$is_retweet = true;
		}

		if (!isset($tweet['entities'])) {
			return $tweet['text'];
		}

		$target = (!empty($opts['target'])) ? ' target="' . $opts['target'] . '"' : '';

		// prepare the entities
		foreach ($tweet['entities'] as $type => $things) {
			foreach ($things as $entity => $value) {
				$tweet_link = "<a href=\"https://twitter.com/{$tweet['user']['screen_name']}/statuses/{$tweet['id']}\"{$target}>{$tweet['created_at']}</a>";

				switch ($type) {
					case 'hashtags':
						$href = "<a href=\"https://twitter.com/search?q=%23{$value['text']}\"{$target}>#{$value['text']}</a>";
						break;
					case 'user_mentions':
						$href = "@<a href=\"https://twitter.com/{$value['screen_name']}\" title=\"{$value['name']}\"{$target}>{$value['screen_name']}</a>";
						break;
					case 'urls':
					case 'media':
						$url = empty($value['expanded_url']) ? $value['url'] : $value['expanded_url'];
						$display = isset($value['display_url']) ? $value['display_url'] : str_replace('http://', '', $url);
						// Not all pages are served in UTF-8 so you may need to do this ...
						$display = urldecode(str_replace('%E2%80%A6', '&hellip;', urlencode($display)));
						$href = "<a href=\"{$value['url']}\"{$target}>{$display}</a>";
						break;
				}
				$keys[$value['indices']['0']] = mb_substr(
						$tweet['text'], $value['indices']['0'], $value['indices']['1'] - $value['indices']['0']
				);
				$replacements[$value['indices']['0']] = $href;
			}
		}

		ksort($replacements);
		$replacements = array_reverse($replacements, true);
		$entified_tweet = $tweet['text'];
		foreach ($replacements as $k => $v) {
			$entified_tweet = mb_substr($entified_tweet, 0, $k) . $v . mb_substr($entified_tweet, $k + strlen($keys[$k]));
		}
		$replacements = array(
			'replacements' => $replacements,
			'keys' => $keys
		);

		mb_internal_encoding($encoding);
		return $entified_tweet;
	}

	/**
	 * This is a convenience method that will return the id of the most_recent tweet.
	 */
	function get_most_recent_tweet_id()
	{
		$tweets = $this->get();
		if (!empty($tweets))
		{
			$tweet = reset($tweets);
			return $tweet['id'];
		}
		return false;
	}
}
?>
