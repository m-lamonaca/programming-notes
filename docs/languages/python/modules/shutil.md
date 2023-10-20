# Shutil Module

High-level file operations

```python linenums="1"
# copy file src to fil dst, return dst in most efficient way
shutil.copyfile(src, dst)
# dst MUST be complete target name
# if dst already exists it will be overwritten

# copy file src to directory dst, return path to new file
shutil.copy(src, dst)

# Recursively copy entire dir-tree rooted at src to directory named dst
# return the destination directory
shutil.copytree(src, dst, dirs_exist_ok=False)
# DIRS_EXIST_OK: {bool} -- dictates whether to raise an exception in case dst
# or any missing parent directory already exists

# delete an entire directory tree
shutil.rmtree(path, ignore_errors=False, onerror=None)
# IGNORE_ERROR: {bool} -- if true errors (failed removals) will be ignored
# ON_ERROR: handler for removal errors (if ignore_errors=False or omitted)

# recursively move file or directory (src) to dst, return dst
shutil.move(src, dst)
# if the destination is an existing directory, then src is moved inside that directory.
# if the destination already exists but is not a directory,
# it may be overwritten depending on os.rename() semantics
# used to rename files

# change owner user and/or group of the given path
shutil.chown(path, user=None, group=None)
# user can be a system user name or a uid; the same applies to group.
#  At least one argument is required

# create archive file and return its name
shutil.make_archive(base_name, format, [root_dir, base_dir])
# BASE_NAME: {string} -- name of the archive, including path, excluding extension
# FROMAT: {zip, tar, gztar, bztar, xztar} -- archive format
# ROOT_DIR: {path} -- root directory of archive (location of archive)
# BASE_DIR: {path} -- directory where the archiviation starts

# unpack an archive
shutil.unpack_archive(filename, [extract_dir, format])
# FILENAME: full path of archive
# EXTRACT_DIR: {path} -- directory to unpack into
# FORMAT: {zip, tar, gztar, bztar, xztar} -- archive format

# return disk usage statistics as Namedtuple w/ attributes total, used, free
shutil.disk_usage(path)
```
