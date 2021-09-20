# Bash Commands

**NOTE**: Square brackets (`[]`) denotes optional commands/flags/arguments. Uppercase denotes placeholders for arguments.

## Basic Commands

### Elevated Privileges and Users

[sudo vs su](https://unix.stackexchange.com/questions/35338/su-vs-sudo-s-vs-sudo-i-vs-sudo-bash/35342)

```bash
sudo su  # login as root (user must be sudoers, root password not required) DANGEROUS
sudo -s  # act as root and inherit current user environment (env as is now, along current dir and env vars) SAFE (can modify user environment)
sudo -i  # act as root and and use a clean environment (goes to user's home, runs .bashrc) SAFEST
sudo COMMAND  # run a command w\ root permissions
sudo -u USER COMMAND # run command as user

su  # become root (must know root password) DANGEROUS
su - USER  # change user and load it's home folder
su USER  # change user but don't load it's home folder
```

### Getting Info

```sh
man COMMAND  # show command manual
help COMMAND  # show command info
whatis COMMAND  # one-line command explanation
apropos COMMAND  # search related commands
which COMMAND  # locate a command
history  # list of used commands

id  # Print user and group information for the specified USER, or (when USER omitted) for the current user
```

### Moving & Showing Directory Contents

```sh
pwd  # print working (current) directory
ls [option]... [FILE]...   # list directory contents ("list storage")
cd rel_path  # change directory to path (rel_path must be inside current directory)
cd abs_path  # change directory to path
cd ..  # change directory to parent directory
cd ~  # go to /home
cd -  # go to previous directory
pushd PATH  # go from current directory to path
popd  # return to previous directory (before pushd)
```

### Creating, Reading, Copying, Moving, Modifying Files And Directories

```sh
touch FILE  # change FILE timestamp fi exists, create file otherwise
cat [FILE]  # concatenate files and print on standard output (FD 1)
cat >> FILE  # append following content ot file (Ctrl+D to stop)
file FILE  # discover file extension and format
stat FILE  # display file or file system status

tail  # output the last part of a file
tail [-nNUM]  # output the last NUM lines

more  # filter for paging through text one screenful at a time
less  # opposite of more (display big file in pages), navigate with arrow keys or space bar

cut  # remove sections from each line of files
cut -[d --delimiter=DELIM]  # use DELIM instead of TAB for field delimiter
cut [-f --fields=LIST]  # select only these fields

df  # report file system disk space usage

rm FILE  # remove file or directories
rm DIRECTORY -r  # remove directory an all its contents (recursive)
rmdir DIRECTORY  # remove directory only if is empty

mkdir DIRECTORY  # make directories

mv SOURCE DESTINATION  # move or rename files
mv SOURCE DIRECTORY  # move FILE to DIRECTORY

cp SOURCE DESTINATION  # copy SOURCE to DESTINATION
```

### Files Permissions & Ownership

![Linux Permissions](../.images/bash_files-permissions-and-ownership-basics-in-linux.png "files info and permissions")

```sh
chmod MODE FILE  # change file (or directory) permissions
chmod OCTAL-MODE FILE  # change file (or directory) permissions

chown [OPTION]... [OWNER][:[GROUP]] FILE...  # change file owner and group
chgrp [OPTION]... GROUP FILE...  # change group ownership
```

**File Permissions**:

- `r`: Read. Can see file content
- `w`: Write. Can modify file content
- `x`: Execute. Can execute file

**Directory Permissions**:

- `r`: Read. Can see dir contents
- `w`: CRUD. Can create, rename and delete files
- `x`: Search. Can access and navigate inside the dir. Necessary to operate on files

***Common* Octal Files Permissions**:

- `777`: (`rwxrwxrwx`) No restrictions on permissions. Anybody may do anything. Generally not a desirable setting.
- `755`: (`rwxr-xr-x`) The file's owner may read, write, and execute the file. All others may read and execute the file. This setting is common for programs that are used by all users.
- `700`: (`rwx------`) The file's owner may read, write, and execute the file. Nobody else has any rights. This setting is useful for programs that only the owner may use and must be kept private from others.
- `666`: (`rw-rw-rw-`) All users may read and write the file.
- `644`: (`rw-r--r--`) The owner may read and write a file, while all others may only read the file. A common setting for data files that everybody may read, but only the owner may change.
- `600`: (`rw-------`) The owner may read and write a file. All others have no rights. A common setting for data files that the owner wants to keep private.

***Common* Octal Directory Permissions**:

- `777`: (`rwxrwxrwx`) No restrictions on permissions. Anybody may list files, create new files in the directory and delete files in the directory. Generally not a good setting.
- `755`: (`rwxr-xr-x`) The directory owner has full access. All others may list the directory, but cannot create files nor delete them. This setting is common for directories that you wish to share with other users.
- `700`: (`rwx------`) The directory owner has full access. Nobody else has any rights. This setting is useful for directories that only the owner may use and must be kept private from others.

### Finding Files And Directories

```sh
find [path] [expression]   # search file in directory hierarchy
find [start-position] -type f -name FILENAME  # search for a file named "filename"
find [start-position] -type d -name DIRNAME  # search for a directory named "dirname"
find [path] -exec <command> {} \;  # execute command on found items (identified by {})

[ -f "path" ]  # test if a file exists
[ -d "path" ]  # test if a folder exists
```

### Other

```sh
tee  # copy standard input and write to standard output AND files simultaneously
tee [FILE]
command | sudo tee FILE  # operate on file w/o using shell as su

echo  # display a line of text
echo "string" > FILE  # write lin of text to file
echo "string" >> FILE  # append line of text to end of file (EOF)

wget URL  # download repositories to linux machine

curl  # download the contents of a URL
curl [-I --head]  # Fetch the headers only

ps [-ax]  # display processes
kill <PID>   # kill process w/ Process ID <PID>
killall PROCESS  # kill process by nane

grep  # search through a string using a REGEX
grep [-i]  # grep ignore case

source script.sh  # load script as a command
diff FILES  # compare files line by line

# sudo apt install shellcheck
shellcheck FILE  # shell linter

xargs [COMMAND]  # build and execute command lines from standard input
# xargs reads items form the standard input, delimited by blanks or newlines, and executes the COMMAND one or more times with the items as arguments
watch [OPTIONS] COMMAND  # execute a program periodically, showing output full-screen
watch -n SECONDS COMMAND  # execute command every SECONDS seconds (no less than 0.1 seconds)
```

## Data Wrangling

**Data wrangling** is the process of transforming and mapping data from one "raw" data form into another format with the intent of making it more appropriate and valuable for a variety of downstream purposes such as analytics.

```bash
sed  # stream editor for filtering and transforming text
sed -E "s/REGEX/replacement/"  # substitute text ONCE (-E uses modern REGEX)
sed -E "s/REGEX/replacement/g"  # substitute text multiple times (every match)

wc [FILE] # print newline, word and byte count for each file
wc [-m --chars] FILE  # print character count
wc [-c --bytes] FILE  # print bytes count
wc [-l --lines] FILE  # print lines count
wc [-w --words] FILE  # print word count

sort [FILE]  # sort lines of a text file

uniq [INPUT [OUTPUT]]  # report or omit repeated lines (from INPUT to OUTPUT)
uniq [-c --count]  # prefix lines w/ number of occurrences
uniq [-d --repeated]  # print only duplicare lines, one for each group
uniq [-D]  # print only duplicare lines

paste [FILE]  # merge lines of files
paste [-d --delimiters=LIST]  # use delimiters from LIST
paste [- --serial]  # paste one file at a time instead of in parallel

awk '{program}'  # pattern scanning and processing language
awk [-f --file PROGRAM_FILE]  # read program source from PROGRAM_FILE instead of from first argument

bc [-hlwsqv long-options] [FILE]  # arbitrary precision calculator language
bc [-l --mathlib] [FILE]  # use standard math library
```
