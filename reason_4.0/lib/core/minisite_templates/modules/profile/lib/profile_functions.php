<?php
/**
 * Profile Functions - shared functions for profiles. Link building for now.
 *
 * Helps with tasks, including
 *
 * - link building
 *
 * @author Nathan White
 *
 * @todo implement profile_get_explore_slug()
 */
  
/**
 * Include dependencies
 */
include_once('reason_header.php');
reason_include_once( 'config/modules/profile/config.php' );
reason_include_once( 'function_libraries/url_utils.php' );

/**
 * Construct a profile link -
 *
 * - params set to a value use that value
 * - params set to an empty string are removed from the current URL if present
 * - params set to NULL maintain any present value they might have
 *
 * @author Nathan White
 */
function _profile_construct_link($params, $type, $is_redirect)
{
	$config = profile_get_config();
	$base_path = profile_get_base_url();
	if ($type == 'explore') $base_path .= profile_get_explore_slug();
	$preserve_params = array();
	foreach ($params as $k=>$v)
	{
		if (is_null($v))
		{
			$preserve_params[] = $k;
		}
		else $new_params[$k] = $v;
	}
	// remove from new_params and add to URL according to friendliness rules
	if ($config->friendly_urls)
	{
		if ($type == 'profile')
		{
			if (!empty($new_params['username']))
			{
				$base_path .= urlencode($new_params['username']);
				unset($new_params['username']);
			}
		}
		
		if ($type == 'explore') // support tag rewrite;
		{
			if (!empty($new_params['tag']))
			{
				$base_path .= urlencode($new_params['tag']);
				unset($new_params['tag']);
			}
		}
	}
	return ($is_redirect) ? carl_construct_redirect($new_params, $preserve_params, $base_path) : carl_construct_link($new_params, $preserve_params, $base_path);
}

function profile_construct_link($params = array())
{
	return _profile_construct_link($params, 'profile', false);
}

function profile_construct_redirect($params = array())
{
	return _profile_construct_link($params, 'profile', true);
}

function profile_construct_explore_link($params = array())
{
	return _profile_construct_link($params, 'explore', false);
}

function profile_construct_explore_redirect($params = array())
{
	return _profile_construct_link($params, 'explore', true);
}

function profile_construct_list_link($params = array())
{
	return _profile_construct_link($params, 'list', false);
}

function profile_construct_list_redirect($params = array())
{
	return _profile_construct_link($params, 'list', true);
}

function profile_get_base_url()
{
	$config = profile_get_config();
	$site_id = id_of($config->profiles_site_unique_name);
	$site = new entity($site_id);
	return $site->get_value('base_url');
}

/**
 * @todo return the slug of the page that runs the profile/explore module
 */
function profile_get_explore_slug()
{
	return 'explore/';
}

/**
 * Return our config object
 */
function profile_get_config()
{
	static $config;
	if (!isset($config))
	{
		$config = new ProfileConfig();
	}
	return $config;
}