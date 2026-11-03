# Boot Process and Initramfs

Slate maintains its own initramfs.

## Components

- init: Early userspace entry point.
- toybox: Provides basic utilities.
- choose-root: Selects the root filesystem.
- slate-switch-root: Switches to the real root filesystem.

## Boot Process

1. The kernel loads the initramfs.
2. The init script creates required mount points.
3. devtmpfs, proc, and sysfs are mounted.
4. choose-root locates the real root filesystem.
5. The real root filesystem is prepared.
6. slate-switch-root transfers execution to the installed system.

## Initramfs Layout

    initramfs/
    ├── init
    └── bin/
        ├── toybox
        ├── choose-root
        └── slate-switch-root

## Troubleshooting

- Verify /init exists and is executable.
- Verify Toybox is present.
- Check root filesystem selection.
- Check kernel storage and filesystem drivers.
- Inspect early boot output.
