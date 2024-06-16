# SMTPlib Module

```python
import smtplib

# SMTP instance that encapsulates a SMTP connection
# If the optional host and port parameters are given, the SMTP connect() method is called with those parameters during initialization.
s = smtplib.SMTP(host="host_smtp_address", port="smtp_service_port", **kwargs)

s = smtplib.SMTP_SSL(host="host_smtp_address", port="smtp_service_port", **kwargs)
# An SMTP_SSL instance behaves exactly the same as instances of SMTP.
# SMTP_SSL should be used for situations where SSL is required from the beginning of the connection
# and using starttls() is not appropriate.
# If host is not specified, the local host is used.
# If port is zero, the standard SMTP-over-SSL port (465) is used.

SMTP.connect(host='localhost', port=0)
#Connect to a host on a given port. The defaults are to connect to the local host at the standard SMTP port (25). If the hostname ends with a colon (':') followed by a number, that suffix will be stripped off and the number interpreted as the port number to use. This method is automatically invoked by the constructor if a host is specified during instantiation. Returns a 2-tuple of the response code and message sent by the server in its connection response.

SMTP.verify(address)  # Check the validity of an address on this server using SMTP VRFY

SMTP.login(user="full_user_mail", password="user_password")  # Log-in on an SMTP server that requires authentication

SMTP.SMTPHeloError  # The server didn't reply properly to the HELO greeting
SMTP.SMTPAuthenticationError  # The server didn't accept the username/password combination.
SMTP.SMTPNotSupportedError  # The AUTH command is not supported by the server.
SMTP.SMTPException  # No suitable authentication method was found.

SMTP.starttls(keyfile=None, certfile=None, **kwargs)  # Put the SMTP connection in TLS (Transport Layer Security) mode. All SMTP commands that follow will be encrypted
# from_addr & to_addrs are used to construct the message envelope used by the transport agents. sendmail does not modify the message headers in any way.
# msg may be a string containing characters in the ASCII range, or a byte string. A string is encoded to bytes using the ascii codec, and lone \r and \n characters are converted to \r\n characters. A byte string is not modified.
SMTP.sendmail(from_addr, to_addrs, msg, **kwargs)
# from_addr: {string} -- RFC 822 from-address string
# ro_addrs: {string, list of strings} -- list of RFC 822 to-address strings
# msg: {string} -- message string

# This is a convenience method for calling sendmail() with the message represented by an email.message.Message object.
SMTP.send_message(msg, from_addr=None, to_addrs=None, **kwargs)
# from_addr: {string} -- RFC 822 from-address string
# ro_addrs: {string, list of strings} -- list of RFC 822 to-address strings
# msg: {email.message.Message object} -- message string
SMTP.quit()  # Terminate the SMTP session and close the connection. Return the result of the SMTP QUIT command
```
