<?php
/**
 * @package reason
 * @subpackage minisite_modules
 */
 
 /**
  * Include base class & other dependencies
  */
	reason_include_once( 'minisite_templates/modules/generic3.php' );
	reason_include_once( 'classes/av_display.php' );
	reason_include_once( 'function_libraries/url_utils.php' );
	
	/**
	 * Register the class so the template can instantiate it
	 */
	$GLOBALS[ '_module_class_names' ][ basename( __FILE__, '.php' ) ] = 'AvModule';
	
	/**
	 * A minisite module to display media works & media files
	 */
	class AvModule extends Generic3Module
	{
		var $type_unique_name = 'av';
		var $style_string = 'av';
		var $jump_to_item_if_only_one_result = false;
		var $use_dates_in_list = true;
		var $num_per_page = 7;
		var $use_pagination = true;
		var $item_counter = 1;
		var $acceptable_params = array(
			'limit_to_current_site'=>true,
			'limit_to_current_page'=>true,
			'sort_direction'=>'DESC', // Normally this page shows items in reverse chronological order, but you can change this to ASC for formward chronological order
			'sort_field'=>'dated.datetime',
			'thumbnail_width'=>0,
			'thumbnail_height'=>0,
			'thumbnail_crop'=>''
		);
		var $make_current_page_link_in_nav_when_on_item = true;
		var $no_items_text = 'There is no audio or video attached to this page yet.';
		var $media_format_overrides = array('Flash Video'=>'Flash');
		
		function alter_es() // {{{
		{
			if($this->params['limit_to_current_page'])
			{
				$this->es->add_right_relationship( $this->parent->cur_page->id(), relationship_id_of('minisite_page_to_av') );
			}
			$this->es->set_order( $this->params['sort_field'].' '.$this->params['sort_direction'] );
			$this->es->add_relation( 'show_hide.show_hide = "show"' );
		} // }}}
		function show_item_content( $item ) // {{{
		{
			$this->get_primary_image( $item );
			if($item->get_value('datetime') || $item->get_value('media_publication_datetime') )
			{
				echo '<p class="date">';
				echo $this->get_date_information($item);
				echo '</p>'."\n";
			}
			if($item->get_value('author'))
			{
				echo '<p class="author">By '.$item->get_value('author').'</p>'."\n";
			}
			if($item->get_value('description'))
			{
				echo '<div class="desc">'.$item->get_value('description').'</div>'."\n";
			}
			$this->display_av_files($item, $this->get_av_files( $item ));
			$this->display_transcript($item);
			$this->display_rights_statement($item);
		} // }}}
		function get_date_information($item)
		{
			$ret = '';
			if($item->get_value('datetime') && $item->get_value('datetime') != '0000-00-00 00:00:00')
			{
				$ret .= '<span class="created">';
				if($item->get_value('media_publication_datetime')) $ret .= 'Created ';
				$ret .= prettify_mysql_datetime($item->get_value('datetime'),$this->date_format).'</span>';
				if($item->get_value('media_publication_datetime')) $ret .= '; ';
			}
			if($item->get_value('media_publication_datetime'))
			{
				$ret .= '<span class="published">Published '.prettify_mysql_datetime($item->get_value('media_publication_datetime'),$this->date_format).'</span>';
			}
			return $ret;
		}
		//Called on by show_list_item()
		function show_list_item_pre( $item ) // {{{
		{
			$this->get_primary_image( $item );
		}
		//Called on by show_list_item
		function show_list_item_desc( $item )
		{
			if($item->get_value('description'))
			{
				echo '<div class="desc">'.$item->get_value('description').'</div>'."\n";
			}
		}
		function show_list_item_date( $item )
		{
			if($this->use_dates_in_list && ( $item->get_value( 'datetime' )|| $item->get_value('media_publication_datetime') ) )
				echo '<div class="smallText date">'.$this->get_date_information($item).'</div>'."\n";
		}
		function get_primary_image( $item )
		{
			if(empty($this->parent->textonly))
			{
				$item->set_env('site_id',$this->parent->site_id);
				$images = $item->get_left_relationship( relationship_id_of('av_to_primary_image') );
				if(!empty($images))
				{
					$image = current($images);
					if($this->params['thumbnail_width'] != 0 or $this->params['thumbnail_height'] != 0)
					{
						$rsi = new reasonSizedImage();
						if(!empty($rsi))
						{
							$rsi->set_id($image->id());
							if($this->params['thumbnail_width'] != 0)
							{
								$rsi->set_width($this->params['thumbnail_width']);
							}
							if($this->params['thumbnail_height'] != 0)
							{
								$rsi->set_height($this->params['thumbnail_height']);
							}
							if($this->params['thumbnail_crop'] != '')
							{
								$rsi->set_crop_style($this->params['thumbnail_crop']);
							}
							$image = $rsi;
						}
					}
					
					$die_without_thumbnail = true;
					$show_popup_link = false;
					$show_description = false;
					$additional_text = '';
					if(empty($this->request[ $this->query_string_frag.'_id' ]) || $this->request[ $this->query_string_frag.'_id' ] != $item->id() )
					{
						$link = $this->construct_link($item);
					}
					else
					{
						$link = '';
					}
					
					show_image( $image, $die_without_thumbnail, $show_popup_link, $show_description, $additional_text, $this->parent->textonly, false, $link );
				}
			}
		}
		function get_cleanup_rules()
		{
			$this->cleanup_rules[$this->query_string_frag . '_id'] = array('function' => 'turn_into_int');
			$this->cleanup_rules['av_file_id'] = array('function'=>'turn_into_int');
			$this->cleanup_rules['show_transcript'] = array('function'=>'check_against_array','extra_args'=>array('true','false'));
			return $this->cleanup_rules;
		}
		function get_av_files( $item ) // {{{
		{
			$avf = new entity_selector();
			$avf->add_type( id_of('av_file' ) );
			$avf->add_right_relationship( $item->id(), relationship_id_of('av_to_av_file') );
			$avf->set_order('av.media_format ASC, av.av_part_number ASC');
			return $avf->run_one();
		}
		function display_av_files( $item, $av_files )
		{
			$av_file_count = count($av_files);
			if ($av_file_count > 0)
			{
				$prev_format = '';
				echo '<div class="avFiles">'."\n";
				$first_list = true;
				$query_args = array();
				if(!empty($this->request['show_transcript']))
				{
					$query_args['show_transcript'] = 'true';
				}
				foreach( $av_files as $av_file )
				{
					if($prev_format != $av_file->get_value( 'media_format' ) )
					{
						if(!$first_list)
						{
							echo '</ul>'."\n";
						}
						else
						{
							$first_list = false;
						}
						echo '<ul>'."\n";
					}
					if($av_file_count == 1 || (!empty($this->request['av_file_id']) && $this->request['av_file_id'] == $av_file->id() ) )
					{
						$is_current = true;
						$attrs = ' class="current"';
					}
					else
					{
						$is_current = false;
						$attrs = '';
					}
					echo '<li'.$attrs.'>';
					if($is_current)
					{
						echo '<strong>';
					}
					elseif($av_file->get_value( 'url' ))
					{
						$args = $query_args + array('av_file_id'=>$av_file->id());
						echo '<a href="'.$this->construct_link($item,$args).'" title="'.$av_file->get_value( 'media_format' )." ".$av_file->get_value( 'av_type' ).': '.htmlspecialchars($item->get_value('name')).'" class="fileLink">';
					}
					$file_desc = '';
					if ( $av_file->get_value( 'av_part_number' ) )
					{
						$file_desc .= 'Part '.$av_file->get_value( 'av_part_number' );
						if( $av_file->get_value( 'av_part_total' ) )
						{
							$file_desc .= ' of '.$av_file->get_value( 'av_part_total' );
						}
						$file_desc .= ': ';
					}
					if( $av_file->get_value( 'description' ) )
					{
						$file_desc .= $av_file->get_value( 'description' ).': ';
					}
					if(!empty($this->media_format_overrides[$av_file->get_value( 'media_format' ) ] ) )
					{
						$file_desc .= $this->media_format_overrides[$av_file->get_value( 'media_format' ) ];
					}
					else
					{
						$file_desc .= $av_file->get_value( 'media_format' );
					}
					$file_desc .= ' '.$av_file->get_value( 'av_type' );
					echo $file_desc;
					if($is_current)
					{
						echo '</strong>';
					}
					elseif($av_file->get_value( 'url' ))
					{
						echo "</a>";
					}
					if ( $av_file->get_value( 'media_size' ) || $av_file->get_value( 'media_duration' ) || $av_file->get_value( 'media_quality' ) )
					{
						echo " <span class='smallText'>(";
						$xtra_info = array();
						if ( $av_file->get_value( 'media_size' ) )
						{
							$xtra_info[] = $av_file->get_value( 'media_size' );
						}
						if ( $av_file->get_value( 'media_duration' ) )
						{
							$xtra_info[] = $av_file->get_value( 'media_duration' );
						}
						if ( $av_file->get_value( 'media_quality' ) )
						{
							$xtra_info[] = $av_file->get_value( 'media_quality' );
						}
						if( $av_file->get_value('default_media_delivery_method') )
						{
							$xtra_info[] = str_replace('_',' ',($av_file->get_value('default_media_delivery_method')));
						}
						echo implode(', ',$xtra_info);
						echo ')</span>'."\n";
					}
					if($is_current && $av_file->get_value('url'))
					{
						$avd = new reasonAVDisplay();
						// $avd->set_parameter( 'flv', 'controlbar', '0' );
						$embed_markup = $avd->get_embedding_markup($av_file);
						if(!empty($embed_markup))
						{
							echo '<div class="player">'."\n".$embed_markup."\n".'</div>'."\n";

							$tech_note = $avd->get_tech_note($av_file);
							if(!empty($tech_note))
							{
								echo '<div class="techNote">'.$tech_note.'</div>'."\n";
							}
						}
						$other_links = array();
						if($av_file->get_value('media_is_progressively_downloadable') == 'true')
						{
							$other_links[] = '<a href="'.alter_protocol($av_file->get_value('url'),'rtsp','http').'" title="Direct link to download &quot;'.htmlspecialchars($item->get_value('name').': '.$file_desc).'&quot;" class="download">Download file</a>';
						}
						if($av_file->get_value('media_is_streamed') == 'true')
						{
							$other_links[] = '<a href="'.alter_protocol($av_file->get_value('url'),'http','rtsp').'" title="Direct link to stream &quot;'.htmlspecialchars($item->get_value('name').': '.$file_desc).'&quot;" class="stream">Direct link to stream</a>';
						}
						if(empty($other_links))
						{
							$other_links[] = '<a href="'.$av_file->get_value('url').'" title="Direct link to &quot;'.htmlspecialchars($item->get_value('name').': '.$file_desc).'&quot;">Direct link to file</a>';
						}
						echo '<p class="direct">'.implode(' ',$other_links).'</p>'."\n";
						
					}
					if(!$av_file->get_value( 'url' ))
					{
						$owner = $av_file->get_owner();
						if(!empty($owner) && $owner->get_value('name_cache') )
						{
							$phrase = 'File not available online. Please contact site maintainer ('.$owner->get_value('name_cache').') for this file.';
						}
						else
						{
							$phrase = 'File not available online. Please contact site maintainer for this file.';
						}
						echo ' <em>'.$phrase.'</em>';
					}
					echo "</li>\n";
					$prev_format = $av_file->get_value( 'media_format' );
				}
				echo '</ul>'."\n";
				echo '</div>'."\n";
			}
		}
		function display_transcript( $item )
		{
			
			if($item->get_value('transcript_status') == 'published')
			{
				$add_link_items = array();
				if(!empty($this->request['av_file_id']))
				{
					$add_link_items['av_file_id'] = $this->request['av_file_id'];
				}
				if(!empty($this->request['show_transcript']) && $this->request['show_transcript'] == 'true')
				{
					$link = $this->construct_link($item,$add_link_items);
					echo '<div class="transcript"><h4>Transcript</h4>'."\n";
					echo '<div class="transcriptToggle"><a href="'.$link.'">Hide Transcript</a></div>'."\n";
					echo $item->get_value('content');
					echo '<div class="transcriptToggle"><a href="'.$link.'">Hide Transcript</a></div>'."\n";
					echo '</div>'."\n";
				}
				else
				{
					$add_link_items['show_transcript'] = 'true';
					$link = $this->construct_link($item,$add_link_items);
					echo '<div class="transcriptToggle"><a href="'.$link.'">View Transcript</a></div>'."\n";
				}
			}
		}
		function display_rights_statement( $item )
		{
			if($item->get_value('rights_statement'))
			{
				echo '<div class="rights">'."\n";
				echo $item->get_value('rights_statement');
				echo '</div>'."\n";
			}
		}
		
		function further_checks_on_entity( $entity )
		{
			if($this->params['limit_to_current_page'])
			{
				$es = new entity_selector();
				$es->add_type(id_of('av'));
				$es->add_relation('`entity`.`id` = "'.addslashes($entity->id()).'"');
				$es->add_right_relationship( $this->page_id, relationship_id_of('minisite_page_to_av') );
				$es->set_num(1);
				$es->limit_tables();
				$es->limit_fields();
				$results = $es->run_one();
				return (!empty($results));
			}
			return true;
		}
		
		/**
		 * A nice handler for missing av things. Attempts to point the user to another
		 * place to access the item, even if that place is on another site.
		 * 
		 * Takes the ID of a missing item and looks for it on pages that use a page 
		 * type which uses a module defined in the module set 'av_module_derivatives'.
		 * Requires reason_page_types and reason_module_sets.
		 * 
		 * @param $id int The entity ID of the missing item
		 * @return null;
		 * 
		 */
		function handle_missing_item($id)
		{
			// Get the list of modules
			reason_include_once('classes/module_sets.php');
			$ms =& reason_get_module_sets();
			$av_module_derivatives = $ms->get("av_module_derivatives");
			
			// Get the page types that use these modules.
			$rpts =& get_reason_page_types();
			$allowed_page_types = array();
			foreach ($av_module_derivatives as $mod){
				$allowed_page_types = array_merge($allowed_page_types, array_diff($rpts->get_page_type_names_that_use_module($mod), $allowed_page_types));
			}
			
			// Turn this list into a string.
			$serialized = "'" . implode("','", $allowed_page_types) . "'";
			
			// Build the ES
			$es = new entity_selector();
			$es->add_type(id_of('minisite_page'));
			$es->add_left_relationship($id, relationship_id_of('minisite_page_to_av'));
			$es->add_right_relationship_field('owns', 'entity', 'name', 'site_name');
			$es->add_relation("page_node.custom_page IN ($serialized)");
			$result = $es->run_one();

			echo '<div class="notice itemNotAvailable"><h3>Sorry -- this item is not available</h3>';
			// If there are suitable replacements found, display them...
			if (!empty($result))
			{
				$url = parse_url(get_current_url());
				
				if (count($result) == 1)
				{
					$new_page_link = reason_get_page_url(current($result)->id()) . '?' . $url['query'];
					header( 'Location: ' . $new_page_link, true, 301 );
					exit;
				}
				echo "<p>However, you might be able to find it at the following location" . ((count($result)-1) ? "s" : "" ) . ":</p>\n<ul>\n";
				foreach ($result as $key => $entity)
				{
					// Don't forget to pass a nice query string that includes the item of the av as well as the av_file_id if it's in the request.
					echo '<li><a href="' . reason_get_page_url($key) . "?" . $url['query'] . "\">{$entity->get_value("site_name")}: {$entity->get_value("name")}</a></li>";
				}
				echo "</ul>";
			} else {
			// Else just echo the normal 404. 
				echo '<p>This might be because...</p><ul><li>the page you are coming from has a bad link</li><li>there is a typo in the web address</li><li>the item you are requesting has been removed</li></ul>';
			}
			echo "</div>";
		}
		
		function list_items()
		{
			parent::list_items();
			$media_file_type = new entity(id_of('av_file'));
			$feed_link = $this->parent->site_info->get_value('base_url').MINISITE_FEED_DIRECTORY_NAME.'/'.$media_file_type->get_value('feed_url_string');
			if($this->params['limit_to_current_page'])
			{
				$feed_link .= '?page_id='.$this->parent->cur_page->id();
			}
			echo '<p class="podcast">';
			echo '<a href="'.$feed_link.'" class="feedLink">Podcast Feed</a>';
			echo ' <a href="itpc://'.HTTP_HOST_NAME.$feed_link.'" class="subscribe">Subscribe in iTunes</a>';
			echo '</p>'."\n";
			if(defined('REASON_URL_FOR_PODCAST_HELP'))
			{
				echo '<p class="smallText podcastHelp"><a href="'.REASON_URL_FOR_PODCAST_HELP.'">What\'s a podcast, and how does this work?</a></p>';
			}
		}
	}
?>
