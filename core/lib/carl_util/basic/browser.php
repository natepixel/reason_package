<?php
/**
 * @package carl_util
 * @subpackage basic
 */
 
 /**
  * Determine if the current user agent string matches a given regular expression
  * @param string $regex
  * @return integer 0 for no matches, 1 for a match
  */
	function match_ua( $regex )
	{
		return preg_match( '/'.$regex.'/', $_SERVER['HTTP_USER_AGENT'] );
	}

 /**
  * Determine if the current browser is Mac Netscape Navigator 4.x
  * @deprecated Deprecated since 15 November 2007, as this is not apparently used anywhere and is just dumb
  * @todo remove this function entirely before official release
  * @return boolean (now always returns false)
  */
	function is_mac_nn4()
	{
		trigger_error('is_mac_nn4() is deprecated. Please remove any calls to this function from your code.');
		return false;
	}

 /**
  * Determine if the current ip address is on the Carleton College campus
  * @deprecated Deprecated since 15 November 2007, as this is not apparently used anywhere and is Carleton-specific code
  * @todo remove this function entirely before official release
  * @return integer 0 (false); 1 (true)
  */
	function is_on_campus()
	{
		trigger_error('is_on_campus() is deprecated. Please remove any calls to this function from your code.');
		return preg_match( '/^137/' , $_SERVER[ 'REMOTE_ADDR' ] );
	}

	/**
	 *   Uses Javascript to test the user's browser for cookie settings.
	 *
	 *   Behavior defaults to showing a message if the user does not have cookies enabled and to show nothing is cookies
	 *   ARE enabled.  Custom strings can be passsed to the function for custom messages for both possibilities.
	 *   Also note that there is no styling of the messages.  Any style should either be wrapped around the call to this
	 *   function or should be passed in the strings to the function.
	 *
	 *	@todo reimplement in an XHTML strict-comliant manner
	 */
	function show_cookie_capability( $no_cookie_msg = '', $cookie_msg = '')
	{
		if( empty( $no_cookie_msg ) )
			$no_cookie_msg = 'Cookies are not currently enabled in your browser.';
		?>
		<script language="JavaScript" type="text/javascript">
		<!--
		function ReadCookie(cookieName) {
		 var theCookie=""+document.cookie;
		 var ind=theCookie.indexOf(cookieName);
		 if (ind==-1 || cookieName=="") return "";
		 var ind1=theCookie.indexOf(';',ind);
		 if (ind1==-1) ind1=theCookie.length; 
		 return unescape(theCookie.substring(ind+cookieName.length+1,ind1));
		}

		function SetCookie(cookieName,cookieValue,nDays) {
		 var today = new Date();
		 var expire = new Date();
		 if (nDays==null || nDays==0) nDays=1;
		 expire.setTime(today.getTime() + 3600000*24*nDays);
		 document.cookie = cookieName+"="+escape(cookieValue)
						 + ";expires="+expire.toGMTString();
		}

		testValue=Math.floor(1000*Math.random());
		SetCookie('AreCookiesEnabled',testValue);
		if (testValue!=ReadCookie('AreCookiesEnabled')) 
			document.write('<?php echo $no_cookie_msg ?>')
		<?php
		if( !empty( $cookie_msg ) )
		{
		?>
		else
			document.write('<?php echo $cookie_msg ?>')
		<?php
		}
		?>
		//-->
		</script>
		<?php
	}
?>
