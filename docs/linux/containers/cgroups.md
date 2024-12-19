# Linux Control Groups v2 ([`cgroups`][cgroups-v2-kernel-docs])

<!-- WIP Notes -->
- allow to implement metering and limiting on the resources used by processes

- each subsystem has a hierarchy: separate hierarchies for CPU, memory, block I/O, ...
- hierarchies are independent (the trees for memory, cpu can be different)
- each process is *in* a "node" in each hierarchy
- each hierarchy starts with 1 node (the root)
- each node is a group of processes sharing the same resources

---

`cgroups` are a mechanism to *organize processes hierarchically* and *distribute system resources* along the hierarchy in a controlled and configurable manner.

`cgroups` are largely composed of two parts: the *core* and the *controllers*.

The **cgroup core** is primarily responsible for hierarchically organizing processes.   
A **cgroup controller** is usually responsible for distributing a specific type of system resource along the hierarchy although there are utility controllers which serve purposes other than resource distribution. 

cgroups form a tree structure and every process in the system belongs to *one and only one* cgroup. All threads of a process belong to the same cgroup.

On creation, all processes are put in the cgroup that the parent process belongs to at the time. A process can be migrated to another cgroup. Migration of a process doesn't affect already existing descendant processes.

Following certain structural constraints, controllers may be enabled or disabled selectively on a cgroup.  
All controller behaviors are hierarchical - if a controller is enabled on a cgroup, it affects all
processes which belong to the cgroups consisting the inclusive sub-hierarchy of the cgroup.  
When a controller is enabled on a nested cgroup, it always restricts the resource distribution further. The
restrictions set closer to the root in the hierarchy can not be overridden from further away.

## Mounting

Unlike v1, cgroups v2 has a single hierarchy that can be mounted with:

```sh
mount -t cgroup2 none <mount-point>
```

> **Note**: The cgroup filesystem has the magic number `0x63677270` ("cgrp")

All controllers which support v2 and are not bound to a v1 hierarchy are automatically bound to the v2 hierarchy and show up at the root.  
Controllers which are not in active use in the v2 hierarchy can be bound to other hierarchies.  
This allows mixing v2 hierarchy with the legacy v1 multiple hierarchies in a fully backward compatible way.

[cgroups-v2-kernel-docs]: https://www.kernel.org/doc/Documentation/cgroup-v2.txt "cgroups kernel docs"
