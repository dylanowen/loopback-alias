# Loopback Alias

With many servers it becomes tedious to balance common ports. To get around this it's
possible to multiplex shared ports across different loopback aliases.

For example:
```
> lsof -Pni :3000
COMMAND   PID       USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
mdbook  48687      user    3u  IPv4 0xd00a418df44ab879      0t0  TCP 127.0.2.2:3000 (LISTEN)
mdbook  49000      user    3u  IPv4 0xd00a418e01e3f259      0t0  TCP 127.0.2.1:3000 (LISTEN)
```

The [mdbook](https://github.com/rust-lang/mdBook) command is bound to port 3000 listening on
different ip addresses.

We can take this processs further and then bind our new loopback aliases to entries in our
`/etc/hosts` file.

These scripts are designed to simplify this process on OSX.

## Setup
Create a `config.sh` file with your desired settings
```bash
#!/bin/bash

aliases=(
   "127.0.0.2 2.lan" \
   "127.0.0.3 3.lan" \
   "127.0.0.4" \
)
```

The format is `<ip_address>   <optional_host_name>`

Run `sudo ./setup.sh`

Everytime you update your `config.sh` file you can rerun the script to add/edit existing entries.

## How It Works

### `setup_aliases.sh`
OSX doesn't persist `ifconfig lo0 alias <ip_address>` settings across restart. We can get around this by creating a Launch Daemon [`com.dylowen.loopbackalias.plist`](com.dylowen.loopbackalias.plist) that calls [`loopback_alias.sh`](loopback_alias.sh) on startup.

### `setup_hosts.sh`
This reads your config file and creates an entry in your hosts file if it finds an optional host name. If
something goes wrong, a backup of your hosts file is created at `hosts.backup`

### `loopback_alias.sh`
This reads your `config.sh` file and runs `ifconfig lo0 alias <ip_address>` for each entry.

