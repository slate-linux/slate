# Testing and Releasing Slate

Slate releases should be tested before being distributed.
Testing should cover both the base system and optional software.

## Port Testing

- Build new ports from a clean source directory.
- Verify that downloads and source versions are correct.
- Check that installation uses the staging directory.
- Test the installed software.
- Test package removal.

## Installation Testing

- Test installation in a clean virtual machine.
- Test booting the installed system.
- Verify that root login works.
- Verify that normal user accounts work.
- Test networking.
- Install additional packages using Slate.
- Test shutdown and reboot.

## Upgrade Testing

Test upgrades from the previous release when an upgrade path is provided.
Check that existing configuration files and installed packages remain usable.

## Release Notes

Release notes should describe notable changes since the previous release.
Include new ports, updated packages, bug fixes, installer changes and known issues.
Avoid listing every minor internal change unless it affects users or maintainers.
