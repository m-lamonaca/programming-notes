# Ftplib Module Cheat Sheet

## FTP CLASSES

```py
# restiuisce istanza classe FTP
ftplib.FTP(host="", user="", password="", acct="")
# se HOST fornito esegue connect(host)
# SE USER fornito esegue login(user, password, acct)

# sottoclasse FTP con TLS
ftplib.FTP_TLS(host="", user="", password="", acct="")
```

## EXCEPTIONS

```py
ftplib.error_reply  # unexpected error from server
ftplib.error_temp  # temporary error (response codes 400-499)
ftplib.error_perm  # permanent error (response codes 500-599)
ftplib.error_proto   # error not in ftp specs
ftplib.all_errors  # tuple of all exceptions
```

## FTP OBJECTS

```py
# method on text files: -lines
# method on binary files: -binary

# CONNECTION
FTP.connect(host="", port=0)  # used unce per instance
# DONT CALL if host was supplied at instance creation

FTP.getwelcome()  # return welcome message

FTP.login(user='anonymous', password='', acct='')
# called unce per instance after connection is established
# DEAFAULT PASSWORD: anonymous@
# DONT CALL if host was supplied at instance creation
FTP.sendcmd(cmd)  # send command string and return response
FTP.voidcmd(cmd)  # send command string and return nothing if successful
# FILE TRANSFER
FTP.abort()  # abort in progress file transfer (can fail)

FTTP.transfercmd(cmd, rest=None)  # returns socket for connection
# CMD avtive mode: send EPRT or PORT command and CMD and accept connection
# CMD passive mode: send EPSV or PASV and start transfer command

FTP.retrbinary(cmd, callback, blocksize=8192, rest=None) # retrieve file in binary mode
# CMD: appropriate RETR comkmand ('RETR filename')
# CALLBACK: func called on every block of data received

FTP.rertlines(cmd, callback=None)
# retrieve file or dir list in ASCII transfer mode
# CMD: appropriate RETR, LSIT (list and info of files), NLST ( list of file names)
# DEFAULT CALLBACK: sys.stdout

FTP.set_pasv(value)  # set passive mode if value is true, otherwise disable it
# passive mode on by deafultù

FTP.storbinary(cmd, fp, blocksize=8192, callback=None, rest=None)  # store file in binary mode
# CMD: appropriate STOR command ('STOR filename')
# FP: {file object in binary mode} read until EOF in blocks of blocksize
# CLABBACK: func called on each bloak after sending

FTP.storlines(cmd, fp, callback=None)  # store file in ASCII transfer mode
# CMD: appropriate STOR command ('STOR filename')
# FP: {file object} read until EOF
# CLABBACK: func called on each bloak after sending
```
