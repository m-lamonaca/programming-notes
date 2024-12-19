# Symlink, Hardlink, Reflink

Unix files consist of two parts: the *data part* and the *filename part*.  
The data part is associated with something called an **inode**. The inode carries the map of where the data is, the file permissions, etc. for the data.

```txt
                                           +------+ +------+
                         .---------------> | data | | data | etc
                        /                  +------+ +------+
+--------------------------------+
| permbits, etc | data addresses |
+--------------inode-------------+
```

The filename part carries a name and an associated inode number.

```txt
                                  +---------------------------+
                 .--------------> | permbits, etc | addresses |
                /                 +-----------inode-----------+
+--------------------+
| filename | inode # |
+--------------------+
```

## Hardlinks

More than one filename can reference the same inode number. These files are said to be *hard linked* together.

```txt
+--------------------+
| filename | inode # |
+--------------------+
                \                 +---------------------------+
                 >--------------> | permbits, etc | addresses |
                /                 +------------inode----------+
+---------------------+
| othername | inode # |
+---------------------+

```

## Symlinks (aka Softlinks)

**Symlinks** are a special file type whose data part carries a path to another file.  
Since it is a special file, the OS recognizes the data as a path, and redirects opens, reads, and writes so that, instead of accessing the data within the special file, they access the data in the file named by the data in the special file.

```txt
+--------------------+
| filename | inode # |
+--------------------+
              \
               \     +---------------------------+
                '--> | permbits, etc | addresses |
                     +-----------inode-----------+
                                     /
                                    /
                                   /
 .--------------------------------'
(     +--------------------------+
 '--> |"/path/to/some/other/file"| 
      +----------data------------+
                  /                     |
 .~ ~ ~ ~ ~ ~ ~ ~'                      |-- (redirected at open() time)
(     +--------------------+            |
 '~~> | filename | inode # |
      +--------------------+
                   \               +---------------------------+
                    '------------> | permbits, etc | addresses |
                                   +-----------inode-----------+
                                                /
                                               /
 .--------------------------------------------'
(     +------+  +------+ 
 '--> | data |  | data | etc.
      +------+  +------+ 
```

Now, the filename part of the file is stored in a special file of its own along with the filename parts of other files; this special file is called a directory.

## Reflink

A **Reflink** is a type of *shallow copy* of file data that shares the blocks but otherwise the files are independent and any change to the file will not affect the other. This builds on the underlying copy-on-write mechanism. A reflink will effectively create only a separate metadata pointing to the shared blocks which is typically much faster than a deep copy of all blocks.

```txt
+--------------------+
| filename | inode # |
+--------------------+
            \        +---------------------------+
             '-----> | permbits, etc | addresses |
                     +-----------inode-----------+
                                   \                +------+  +------+
                                    >-------------> | data |  | data | etc.
                                   /                +------+  +------+
                     +---------------------------+
             .-----> | permbits, etc | addresses |
            /        +-----------inode-----------+
+---------------------+
| othername | inode # |
+---------------------+
```

There are some constraints:

- cross-filesystem reflink is not possible, there’s nothing in common between so the block sharing can’t work
- reflink crossing two mount points of the same filesystem support depends on kernel version

## Directories

The directory, as a file, is just an array of filename parts of other files.

When a directory is built, it is initially populated with the filename parts of two special files: the `.` and `..` files.

The filename part for the `.` file is populated with the `inode` of the directory file in which the entry has been made: `.` is a hardlink to the file that implements the current directory.

The *filename part* for the `..` file is populated with the `inode` of the directory file that contains the filename part of the current directory file: `..` is a hardlink to the file that implements the immediate parent of the current directory.

The `ln` command knows how to build hardlinks and softlinks; the `mkdir` command knows how to build directories (the OS takes care of the above hardlinks).

There are restrictions on what can be hardlinked (both links must reside on the same filesystem, the source file must exist, etc.) that are not applicable to softlinks (source and target can be on separate file systems, source does not have to exist, etc.).
