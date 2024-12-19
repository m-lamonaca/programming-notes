# `/sys` Filesystem (`sysfs`)

## `sysfs` Directories

In addition to `/proc`, the kernel also exports information to another _virtual file system_ called `sysfs`. `sysfs` is used by programs such as [`udev`][udev] to access device and device driver information.

### `/sys/block`

This directory contains entries for each [**block device**][block-device] in the system. Symbolic links point to the physical device that the device maps to in the physical device tree.

For example, attributes for the _sda_ disks reside in the `/sys/block/sda` directory.

### `/sys/bus`

This directory contains subdirectories for each **physical bus** type supported in the kernel. Each bus type has two subdirectories: **devices** and **drivers**.  

The devices directory lists devices discovered on that type of bus. The drivers directory contains directories for each device driver registered with the bus type. Driver parameters can be viewed and manipulated.

### `/sys/class`

This directory contains every device class registered with the kernel. Device classes describe a functional type of device. Examples include input devices, network devices, and block devices.

### `/sys/devices`

This directory contains the global device hierarchy of _all devices_ on the system. This directory also contains a platform directory and a system directory. 

The platform directory contains peripheral devices specific to a particular platform such as device controllers. The system directory contains non-peripheral devices such as CPUs and APICs.

### `/sys/firmware`

This directory contains subdirectories with firmware objects and attributes.

### `/sys/module`

This directory contains subdirectories for each module that is loaded into the kernel.

### `/sys/power`

The system power state can be controlled from this directory. The disk attribute controls the method by which the system suspends to disk. The state attribute allows a process to enter a low power state.

<!-- links -->
[udev]: https://en.wikipedia.org/wiki/Udev
[block-device]: https://en.wikipedia.org/wiki/Device_file#Block_devices