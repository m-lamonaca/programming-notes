# fs (FIle System) Module

Async versions can access file at the same time which can lead to conflicts in operations, errors can be handled in callback.
Sync versions cannot interfere with each other, errors cause exceptions, handle in try-catch.

## Files

### Creating & Deleting Files

```js
fs.writeFile(file, data, encoding="utf8", mode=0o666, (err) => {});  // create a file (async)
fs.writeFileSync(file, data, encoding="utf8", mode=0o666);  // create a file (sync)

// remove file
fs.unlink(path, callback);  // delete a file (async)
fs.unlinkSync(path);  // delete a file (sync)

// remove file or directory
fs.rm(path, force=false, recursive=false, (err) => {});
fs.rmSync(path, force=false, recursive=false);

// rename a file, if oldPath is a directory an error will be rised
fs.rename(oldPath, newPath, (err) => {});
fs.renameSync(oldPath, newPath);
```

### Writing & Reading a File

```js
// append contents to a file
fs.appendFile(file, data, encoding="utf8", mode=0o666, (err) => {});
fs.appendFileSync(file, data, encoding="utf8", mode=0o666);

// write contents into a file
fs.write(fd, string, position, encoding="utf8", (err) => {});
fs.writeSync(fd, string, position, encoding="utf8");  // returns num of bytes written

// read file contents
fs.readFile(path, (err, data) => {});
fs.readFileSync(path);  // returns contents of the file
```

### Managing Links

```js
// make a new name for a file
fs.link(existingPath, newPath, (err) => {});
fs.linkSync(existingPath, newPath);

// make a new name for a file (symlink)
fs.symlink(target, path, (err) => {});
fs.symlink(target, path);
```

### Managing Permissions

## Directories & `fs.Dir`

### Creating & Deleting Directories

```js
// create a directory
fs.mkdir(path, mode=0o777, (err) => {});
fs.mkdirSync(path, mode=0o777);

// remove a directory
fs.rmdir(path, recursive=false, (err) => {});
fs.rmdirSync(path, recursive=false;
```

### Reading Directory Contents

```js
// read directory contents
fs.readdir(path, (err, files) => {});  // files is string[]
fs.readdir(path, { withFileTypes: true }, (err, files) => {});  // files is Dirent[]
fs.readdirSync(path);  // returns string[] of files/directories
fs.readdirSync(path, { withFileTypes: true });  // returns Dirent[] of files/directories
```

### `fs.Dir`

```js
// construct an fs.Dir object from an existing path
fs.opendir(path, (err, dir) => {});
fs.opendirSync(path);  // return a fs.Dir object
```

## fs.Stats

### Obtaining

```js
fs.stat(path, {bigint: true}, (err, stats) => {});
fs.statSync(path, {bigint: true});  // returns fs.Stats

fs.lstat(path, {bigint: true}, (err, stats) => {});
fs.lstatSync(path, {bigint: true});  // returns fs.Stats

fs.fstat(path, {bigint: true}, (err, stats) => {});
fs.fstatSync(path, {bigint: true});  // returns fs.Stats
```
