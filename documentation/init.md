# Slate Init System

Slate uses a lightweight shell-based initialization system.

The main initialization script is /bin/rc.init.

## Startup Scripts

Startup scripts are stored in /etc/init.d/.

Example:

    /etc/init.d/
    ├── 01-filesystems
    ├── 02-network
    └── 03-hostname

Scripts execute sequentially in lexicographical order using /bin/sh.

Scripts ending in .sh or .rc are skipped by the documented implementation.

## Boot Logging

Startup output is recorded in /var/log/boot.log.

Each script receives a status:

- [ OK ] - Successful execution.
- [FAIL] - Failed execution.

Execution time is also recorded.

A failed startup script does not prevent subsequent scripts from executing.

## Virtual Terminals

Three virtual terminals are started using Toybox getty.

Terminals restart if getty exits.

## Writing Startup Scripts

- Use POSIX shell syntax.
- Give scripts executable permissions.
- Prefix filenames with numbers.
- Keep scripts focused on one task.
