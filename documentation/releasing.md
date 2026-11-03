# Testing and Releasing Slate

## Build Testing

- Build from a clean working tree.
- Verify the target compiler.
- Check sysroot contents.
- Inspect generated archives.
- Verify initramfs contents.

## Boot Testing

- Test a fresh virtual machine.
- Verify root filesystem selection.
- Verify switch-root.
- Check startup script ordering.
- Test virtual terminals.
- Test boot logging.

## System Testing

- Test filesystem mounting.
- Test hostname configuration.
- Test Ethernet and DHCP.
- Test Wi-Fi where supported.
- Test reboot and shutdown.

## Package Testing

- Build ports from clean source directories.
- Test installation.
- Test removal.
- Test repository configuration.
- Test multiple repositories.

## Release Notes

Document major changes, new functionality, bug fixes, and known issues.

Do not describe unfinished features as completed.
