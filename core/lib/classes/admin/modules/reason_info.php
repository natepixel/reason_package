<?php
/**
 * @package reason
 * @subpackage admin
 */
 
 /**
  * Include the default module and other needed utilities
  */
	reason_include_once('classes/admin/modules/default.php');
	
	/**
	 * an administrative module that produces an "About Reason" page
	 */
	class ReasonInfoModule extends DefaultModule// {{{
	{
		function ReasonInfoModule( &$page ) // {{{
		{
			$this->admin_page =& $page;
		} // }}}
		function init() // {{{
		{
			$this->admin_page->title = 'About Reason';
		} // }}}
		function run() // {{{
		{
			?>
				<p><strong>Reason</strong> is an attempt to create a broad and general way of managing database-driven websites.</p>
				<p>Its purpose is to make a user-friendly editing environment which is as extensible as possible.</p>
				<p>If you have want to learn more about Reason, please visit the <a href="http://apps.carleton.edu/opensource/reason/">Reason website</a>.</p>
				<p class="smallText">Current Version: <?php echo REASON_VERSION; ?></p>
			<?php
		} // }}}
	} // }}}
?>