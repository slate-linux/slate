# Installing Slate

## Preparation

- Back up important data.
- Identify the target disk.
- Determine whether the machine uses UEFI or BIOS.
- Ensure required drivers and filesystem utilities are available.

## Partitioning

Useful tools include parted and gdisk.

Inspect disks before making changes:

    lsblk

## Filesystems

Create the required filesystems and mount the target root filesystem.

## Bootloader

Install and configure a bootloader appropriate for the machine.

GRUB is one supported bootloader option being prepared for Slate.

## First Boot

Verify:

- The kernel loads.
- The initramfs starts.
- Root filesystem selection works.
- switch-root succeeds.
- Startup scripts execute.
- A login prompt appears.
- Networking works.
- Reboot and shutdown work.
