# Slate 0.6

## Release Direction

Slate 0.6 focuses on system infrastructure, boot improvements, repository management, and build system improvements.

## Custom Initramfs

- Project-maintained initramfs.
- Toybox integration.
- choose-root helper.
- slate-switch-root helper.
- Custom init entry point.

## Initialization System

- Shell-based initialization.
- rc.init.
- Numbered startup scripts.
- Boot logging.
- Script status reporting.
- Execution timing.
- Three virtual terminals using Toybox getty.

## Shutdown and Reboot

Slate-specific reboot and poweroff utilities have been introduced.

## Repository Infrastructure

- Multiple repository support.
- Git-based repository sources.
- Tag-based repository selection.
- Testing repository.
- Configuration under /etc/slate.conf/repos.

## Build System

- Compressed sysroot archive generation.
- archive.tar.xz output.
- Improved DESTDIR staging.

## Networking

- Structured network startup.
- Loopback initialization.
- Ethernet DHCP initialization.
- Wi-Fi infrastructure development.

## Additional Utilities

- Lightweight less-style pager implementation.

## 0.6 Testing Checklist

- [ ] Clean build succeeds.
- [ ] Sysroot archive is generated.
- [ ] Initramfs contains required files.
- [ ] Root selection works.
- [ ] switch-root works.
- [ ] Init scripts execute correctly.
- [ ] Boot logging works.
- [ ] Virtual terminals work.
- [ ] Reboot works.
- [ ] Poweroff works.
- [ ] Ethernet works.
- [ ] Wi-Fi works on supported hardware.
- [ ] Multiple repositories work.
- [ ] Package installation works.
- [ ] Package removal works.
- [ ] Documentation matches the implementation.
