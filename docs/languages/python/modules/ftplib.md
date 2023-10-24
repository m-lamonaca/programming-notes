# Ftplib Module

## FTP CLASSES

```py linenums="1"
ftplib.FTP(host="", user="", password="", acct="")
# if HOST => connect(host)
# if USER => login(user, password, acct)


ftplib.FTP_TLS(host="", user="", password="", acct="")
```

## EXCEPTIONS

```py linenums="1"
ftplib.error_reply  # unexpected error from server
ftplib.error_temp  # temporary error (response codes 400-499)
ftplib.error_perm  # permanent error (response codes 500-599)
ftplib.error_proto  # error not in ftp specs
ftplib.all_errors  # tuple of all exceptions
```

## FTP OBJECTS

```py linenums="1"
# method on text files: -lines
# method on binary files: -binary

# CONNECTION
FTP.connect(host="", port=0)  # used once per instance
# DON'T CALL if host was supplied at instance creation

FTP.getwelcome()  # return welcome message

FTP.login(user='anonymous', password='', acct='')
# called once per instance after connection is established
# DEFAULT PASSWORD: anonymous@
# DON'T CALL if host was supplied at instance creation
FTP.sendcmd(cmd)  # send command string and return response
FTP.voidcmd(cmd)  # send command string and return nothing if successful
# FILE TRANSFER
FTP.abort()  # abort in progress file transfer (can fail)

FTTP.transfercmd(cmd, rest=None)  # returns socket for connection
# CMD active mode: send EPRT or PORT command and CMD and accept connection
# CMD passive mode: send EPSV or PASV and start transfer command

FTP.retrbinary(cmd, callback, blocksize=8192, rest=None) # retrieve file in binary mode
# CMD: appropriate RETR command ('RETR filename')
# CALLBACK: func called on every block of data received

FTP.rertlines(cmd, callback=None)
# retrieve file or dir list in ASCII transfer mode
# CMD: appropriate RETR, LSIT (list and info of files), NLST (list of file names)
# DEFAULT CALLBACK: sys.stdout

FTP.set_pasv(value)  # set passive mode if value is true, otherwise disable it
# passive mode on by default

FTP.storbinary(cmd, fp, blocksize=8192, callback=None, rest=None)  # store file in binary mode
# CMD: appropriate STOR command ('STOR filename')
# FP: {file object in binary mode} read until EOF in blocks of blocksize
# CALLBACK: func called on each block after sending

FTP.storlines(cmd, fp, callback=None)  # store file in ASCII transfer mode
# CMD: appropriate STOR command ('STOR filename')
# FP: {file object} read until EOF
# CALLBACK: func called on each block after sending
```
