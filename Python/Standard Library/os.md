# OS Cheat Sheet

```python
os.curdir  # stringa identificante cartella corrente ("." per WIN)
os.pardir  # stringa identificante cartella genitore (".." per WIN)
os.sep     # carattere separatore in path (\\ per WIN, / per POSIX)
os.extsep  # carattere separatore estensione file (".")
os.pathsep # carattere separatore in ENVVAR PATH (";" per WIN, ":" per POSIX)
os.linesp  # stringa usata per separare linee (\r\n per WIN, \n per POSIX)

os.system("command")  # execute command in shell

os.remove(path)  # cancella il file indicato da path
os.rmdir(path)  # cancella cartella indicata da path

os.listdir(path)  # restituisce lista nomi dei contenuti cartella

os.path.exists(path)  # True se path si riferisce ad elemento esistente
os.path.split()  # divide path in (head, tail), head + tail == path
os.path.splitdrive(path)   # divide path in (drive, tail), drive + tail == path
os.path.splitext()  # divide path in (root, ext), root + ext == path
os.path.dirname(path)  # restituisce nome cartella (path head)

os.path.getatime(path)  # restituisce data ultimo accesso
os.path.getmtime(path)  # restituisce data ultima modifica

os.path.getsize(path)  # restituisce dimesione in bytes (OSError se file inaccessibile o inesistente)

os.path.isfile(path) # True se path è file esistente
os.path.isdir(path) # True se path è cartella esistente

os.path.join(path, *paths)  # concatena vari path
os.path.realpath(path) # Return the canonical path of the specified filename, eliminating symbolic links
os.path.relpath(path, start=os.curdir)  # restituisce path relativo (start opzionale, default os.curdir)
os.path.abspath(path)  # return a normalized absolutized version of the pathname path
# collapses redundant separators and up-level references so that A//B, A/B/, A/./B and A/foo/../B all become A/B

os.walk(top)
# Generate the file names in a directory tree by walking the tree either top-down or bottom-up.
# For each directory in the tree rooted at directory top (including), it yields a 3-tuple (dirpath, dirnames, filenames).
# dirpath is a string, the path to the directory.
# dirnames is a list of the names of the subdirectories in dirpath (excluding '.' and '..').
# filenames is a list of the names of the non-directory files in dirpath.
```

## Folder Operations

```python
os.getcwd()  # Return a string representing the current working directory
os.chdir(path)  # change the current working directory to path
os.mkdir(path, mode=0o777)  # Create a directory named path with numeric mode MODE.
os.makedirs(name, mode=0o777)  # Recursive directory creation
```

## Exceptions

```python
IsADirectoryError  # file operation requested on directory
NotADirectoryError # directory operation requested on file
```
