# Troubleshooting Slate

## Boot Problems

- Check kernel and initramfs configuration.
- Verify /init exists.
- Verify Toybox and helper binaries exist.
- Check root filesystem selection.
- Inspect kernel messages.

## Init Problems

- Inspect /var/log/boot.log.
- Check startup script permissions.
- Verify interpreter paths.
- Run failing scripts manually.

## Package Problems

- Verify package identifiers.
- Check dependencies.
- Check repository configuration.
- Review build output.
- Verify DESTDIR staging.

## Program Problems

Check executable permissions and shared libraries.

    ldd /usr/bin/program

## Network Problems

    ip link
    ip addr
    ip route
    dmesg

## Hardware Problems

    lspci
    lsusb
    dmesg
