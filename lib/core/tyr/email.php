<?php
/**
 * @package tyr
 */

/**
 * include the paths settings
 */
include_once('paths.php');
/**
 * include the directory service so that usernames as well as email addresses can be sent to this class
 */
include_once( CARL_UTIL_INC . 'dir_service/directory.php' );
include_once( CARL_UTIL_INC . 'basic/misc.php' );

/**
 * This class represents an email. Example usage:
 * <code>
 * 		$email = new Email( $to, $from, $replyto, $subject, $txtbody, $htmlbody );
 *		$email->send();
 * </code>
 */
class Email
{
	var $_tos;
	var $_froms;
	var $_replytos;
	var $_subject;
	var $_txtbody;
	var $_htmlbody;

	/**
	 * Construct the Email object
	 * @param mixed $tos array or comma-separated string of usernames and/or email addresses
	 * @param mixed $froms array or comma-separated string of usernames and/or email addresses
	 * @param mixed $replaytos array or comma-separated string of usernames and/or email addresses
	 * @param string $subject the email's subject
	 * @param string $txtbody The text version of the email body
	 * @param string $htmlbody An HTML version of the email body (if available)
	 * @param string $address_types one of "mixed", "email", or "username" -- if tos, froms, and replytos are all either email addresses or usernames, indicating that here can save lookup time
	 * @return void
	 */
	function Email($tos, $froms = '', $replytos = '', $subject = '', $txtbody = '', $htmlbody = '', $address_types = 'mixed') {
		if($address_types != 'mixed' && $address_types != 'email' && $address_types != 'username')
		{
			trigger_error('$address_types parameter ('.$address_types.') must be "mixed","email", or "username." Defaulting to "mixed".');
			$address_types = 'mixed';
		}
		$this->add_tos($tos, $address_types);
		$this->add_froms($froms, $address_types);
		$this->add_replytos($replytos, $address_types);
		$this->set_subject($subject);
		$this->set_txtbody($txtbody);
		$this->set_htmlbody($htmlbody);
	}

	// For details about $tos see $this->_prettify_addresses()
	function add_tos($tos, $address_types) {
		$this->_tos .= $this->_prettify_addresses($tos, $address_types);
	}

	// For details about $froms see $this->_prettify_addresses()
	function add_froms($froms, $address_types) {
		$this->_froms .= $this->_prettify_addresses($froms, $address_types);
	}

	// For details about $replytos see $this->_prettify_addresses()
	function add_replytos($replytos, $address_types) {
		$this->_replytos .= $this->_prettify_addresses($replytos, $address_types);
	}

	function set_subject($subject) {
		$this->_subject = $subject;
	}

	function set_txtbody($txtbody) {
		$this->_txtbody = $txtbody;
	}

	function set_htmlbody($htmlbody) {
		$this->_htmlbody = $htmlbody;
	}

	/**
	 * Send the Email
	 *
	 * @return boolean Accepted for delivery
	 */
	function send() {
		$multipart_boundary = uniqid('the_multipart_boundary_is_');
		
		$crlf = "\r\n" ;
	
		$additional_headers =
			 'From: ' . $this->_froms . $crlf .
			 'Bcc: ' . $this->_tos . $crlf .
			 'Reply-To: ' . $this->_replytos . $crlf .
			 'MIME-version: 1.0'.$crlf;
		
		$email = '';

		if ( !empty($this->_htmlbody) ) {
			$additional_headers .= 'Content-Type: multipart/alternative; boundary="' . $multipart_boundary . '"' . $crlf; // define boundary
			$email .= "\n".'This is a MIME message. If you are reading this text, you may want to consider changing to a mail reader or gateway that understands how properly to handle MIME multipart messages.'.$crlf."\n"; // preamble
			$email .= "--" . $multipart_boundary . $crlf; // first boundary
			$email .= 'Content-Type: text/plain; charset=UTF-8'.$crlf;
			$email .= 'Content-Disposition: inline'.$crlf;
		}
		else
		{
			$additional_headers .= 'Content-Type: text/plain; charset=UTF-8'.$crlf;
			$additional_headers .= 'Content-Disposition: inline'.$crlf;
		}
	
		$email .= "\n\n" . $this->_txtbody;
	
		if ( !empty($this->_htmlbody) ) {
			$email .= "\n\n--" . $multipart_boundary . "\n";
			$email .= 'Content-Type: text/html; charset=UTF-8'.$crlf;
			$email .= 'Content-Disposition: inline'.$crlf."\n";
			$email .= $this->_htmlbody;
			$email .= "\n\n--" . $multipart_boundary . "--\n"; //last boundary
		}
		$subject = $this->mb_mime_header_encode($this->_subject);
		
		// it seems a little odd that we are sending the whole email in via the additional headers parameter when not running windows
		$success = (server_is_windows()) 
				 ? mail('', $subject, $email, $additional_headers )
				 : mail('', $subject, '', $additional_headers.$email );
		return $success;
	}
	
	/**
	 * Encode a multibyte string as a MIME header
	 *
	 * mb_encode_mimeheader is naive and therefore unusable (it splits multibyte characters) so this is a more robust replacement.
	 * This function uses base64 encoding, which is slightly heftier than quoted printable in many settings,
	 * but has the advantage of being a predictable length (which is important in this case!)
	 *
	 * @param string $string
	 * @param string $encoding the encoding of the string; pass a null value to use the current mb_internal_encoding
	 * @param string $linefeed the chars to be placed at the end of lines in the encoding
	 * @return string The encoded string
	 */
	function mb_mime_header_encode( $string, $encoding = 'UTF-8', $linefeed = "\r\n " )
	{
		if(!$encoding) $encoding = function_exists('mb_internal_encoding') ? mb_internal_encoding() : 'UTF-8';
		$encoded = '';
		
		while($length = carl_strlen($string, $encoding))
		{
			$encoded .= '=?'.$encoding.'?B?'
				. base64_encode(carl_substr($string,0,24,$encoding))
				. '?='.$linefeed;
		
			$string = carl_substr($string,24,$length,$encoding);
		}		
		return trim($encoded);
	}


	/**
	 * Take mixed username/netids and email addresses and resolve into "clean" array of good-looking email addresses
	 *
	 * By good-looking we mean that they satisfy this regex: /^([-.]|\w)+@([-.]|\w)+\.([-.]|\w)+$/i
	 *
	 * This function works as follows: For each address, first treats
	 * the address as a netid and tries to find a corresponding
	 * address in the directory (if this fails, it assumes that the address
	 * was intended as an address rather than a username); second, checks
	 * whether the address is valid
	 * 
	 * If the address is invalid, the webmaster is included in the recipient list and an error is triggered
	 *
	 * @param mixed $addresses can be any of the following: 1) a valid email address, 2) a username in the directory, 3) a comma-delimited combination of addresses and/or usernames, or 4) an array of addresses and/or usernames.
	 * @param string $address_type can be 'mixed', 'email', or 'username'
	 * @return string $pretty_addresses Comma separated email addresses
	 *
	 * @todo add ability to handle addresses that include names like this: "Jane Smith" <janesmith@example.com>
	 **/
	function _prettify_addresses($addresses, $address_type = 'mixed')
	{
		if($address_type != 'mixed' && $address_type != 'email' && $address_type != 'username')
		{
			trigger_error('$address_type parameter ('.$address_type.') must be "mixed","email", or "username." Defaulting to "mixed".');
			$address_type = 'mixed';
		}
		if ( !is_array($addresses) )
			$addresses = explode(',', $addresses);
		$pretty_address_array = array();
		foreach ( $addresses as $address )
		{
			$address = trim($address);
			if ( !empty($address) )
			{
				if($address_type != 'email')
				{
					$dir = new directory_service();
					$result = $dir->search_by_attribute('ds_username', $address, array('ds_email'));
					$dir_value = $dir->get_first_value('ds_email');
					if($address_type == 'username')
					{
						if(empty($dir_value))
						{
							trigger_error('Username does not exist in directory service: '.$address.'. setting address to ' . WEBMASTER_EMAIL_ADDRESS . ' instead.');
							$address = WEBMASTER_EMAIL_ADDRESS;
						}
						else
						{
							$address = $dir_value;
						}
					}
					else // mixed or other value
					{
						$address = (!empty($dir_value)) ? $dir_value : $address;
					}
					
				}
				
				$num_results = preg_match( '/^([-.]|\w)+@([-.]|\w)+\.([-.]|\w)+$/i', $address );
				if ($num_results <= 0)
				{
					trigger_error('The address ' . $address . ' is invalid - setting address to ' . WEBMASTER_EMAIL_ADDRESS . ' instead.');
					$pretty_address_array[] = WEBMASTER_EMAIL_ADDRESS;
				}
				else
				{
					$pretty_address_array[] = $address;
				}
			}
		}
		$pretty_addresses = implode(', ',$pretty_address_array);
		return $pretty_addresses;
	}
}

?>
