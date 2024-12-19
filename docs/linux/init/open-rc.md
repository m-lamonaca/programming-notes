# [OpenRC](https://github.com/OpenRC/openrc/blob/master/user-guide.md)

**OpenRC** is a dependency-based init system for Unix-like systems that maintains compatibility with the system-provided init system, normally located in /sbin/init. OpenRC is Gentoo's native init system, although other init systems are available.

OpenRC will start necessary system services in the correct order at boot, manage them while the system is in use, and stop them at shutdown. It can manage daemons installed from the Gentoo repository, can optionally supervise the processes it launches, and has an the possibility to start processes in parallel - when possible - to shorten boot time.

## Runlevels & Services

OpenRC has a concept of **runlevels**. A runlevel is a collection of services that needs to be started. Instead of random numbers they are named, and users can create their own if needed.

The `rc-status` helper will print all currently active runlevels and the state of services in them:

```sh
Runlevel: default
  modules                     [  started  ]
  lvm                         [  started  ]
```

All runlevels are represented as folders in `/etc/runlevels/` with symlinks to the actual service scripts.

Calling `openrc` with an argument will switch to that runlevel; this will start and stop services as needed.

### Managing Runlevels

Managing runlevels is usually done through the `rc-update` helper, but could of course be done by hand if desired.

```sh
rc-update add <service> <runlevel>
rc-update del <service> <runlevel>
rc-update show <runlevel>
```

The default startup uses the runlevels `sysinit`, `boot`, and `default`, in that order. Shutdown uses the `shutdown` runlevel.

### Managing Services

Any service can, at any time, be started/stopped/restarted by executing with the `rc-service` helper  someservice start, rc-service someservice stop, etc.

```sh
rc-service <service> start
rc-service <service> stop
rc-service <service> restart
rc-service <service> status
rc-service <service> zap
```

Another, less preferred method, is to run the service script directly, e.g. /etc/init.d/service start, /etc/init.d/service stop, etc.

```sh
/etc/init.d/<service> start
/etc/init.d/<service> stop
/etc/init.d/<service> restart
/etc/init.d/<service> status
/etc/init.d/<service> zap
```

There is a special command `zap` that makes OpenRC 'forget' that a service is started. This is mostly useful to reset a crashed service to stopped state without invoking the (possibly broken) stop function of the service script.

Calling `openrc` without any arguments will try to reset all services so that the current runlevel is satisfied.
