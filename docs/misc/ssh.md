# SSH

`ssh` is a program for logging into a remote machine and for executing commands on a remote machine. It is intended to provide secure encrypted communications between two untrusted hosts over an insecure network.

## Basics

```sh
ssh user@destination <command> # exec <command> in remote machine ($SHELL if omitted)
ssh user@destination -i <path/to/private-key>  # use key for auth
ssh user@destination -f  # exec ssh in the background
ssh user@destination -N  # do not send commands to the server (do not start $SHELL)
ssh user@destination -g  # allow remote hosts to connect to local forwarded ports
ssh user@destination -t  # force pseudo-tty emulation
```

> **Note**: use `~` while connected to use the "ssh console".

### Jump-Hosts

Connect to the final destination jumping through the specifies other destinations.

```sh
ssh -J user_1@destination_1,user_2@destination_2 user@final_destination
```

## Port Forwarding

![ssh-tunnels](https://iximiuz.com/ssh-tunnels/ssh-tunnels.png "SSH Tunnels Cheat Sheet By Ivan Velichko")

### Local Port Forwarding

Start listening on `local_address:local_port` and forward any traffic to `remote_address:remote_port`.

```sh
ssh -N -f -L local_address:local_port:remote_address:remote_port user@destination
ssh -N -f -L local_port:remote_address:remote_port user@destination  # local_address defaults to localhost
```

### Remote Port Forwarding

Start listening on `remote_address:remote_port` and forward any traffic to `local_address:local_port`.

```sh
ssh -N -f -R remote_address:remote_port:local_address:local_port user@destination
```
