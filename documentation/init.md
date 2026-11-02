# Slate Init System

Slate uses a lightweight shell-based initialization system. The `/bin/rc.init` script is responsible for executing startup scripts and launching virtual terminals.

## Startup Scripts

Startup scripts are stored in `/etc/init.d/` and executed sequentially in lexicographical filename order.

Example:

\`\`\`
/etc/init.d/
├── 01-filesystems
├── 02-network
└── 03-hostname
\`\`\`

Scripts are executed using `/bin/sh`. Files ending in `.sh` or `.rc` are skipped.

Prefix scripts with numbers to control their execution order.

## Boot Logging

The init system records startup output in `/var/log/boot.log`.

Each startup script receives a status:

- `[ OK ]` - Script completed successfully.
- `[FAIL]` - Script returned a nonzero exit status.

Execution time is also recorded for each script.

Failed startup scripts do not prevent subsequent scripts from executing.

## Virtual Terminals

After initialization, the screen is cleared and three virtual terminals are started using Toybox getty.

The terminals automatically restart if getty exits.

## Init Configuration

The main initialization script is located at `/bin/rc.init`.

Startup scripts should be placed in `/etc/init.d/` and should use POSIX shell syntax.
