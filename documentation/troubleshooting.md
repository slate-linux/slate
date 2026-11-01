# Troubleshooting Slate

This document covers basic troubleshooting steps for Slate installations.

## Package Installation Fails

- Verify that the package name and category are correct.
- Check that the required dependencies are installed.
- Check that the package source can be downloaded.
- Review the build output for the first reported error.

## Program Does Not Start

- Verify that the executable exists.
- Check that the executable has permission to run.
- Check whether required shared libraries are installed.
- Inspect the program output for missing files or configuration.

## Missing Shared Libraries

Use ldd to inspect the shared library dependencies of a dynamically linked executable.
For example:
    ldd /usr/bin/program

Make sure the required libraries are installed in locations searched by the dynamic linker.

## Hardware Problems

Check whether the required kernel driver and firmware are available.
Useful commands include:
    lspci
    lsusb
    dmesg

## Network Problems

Check the network interface state and assigned addresses:
    ip link
    ip addr
    ip route

Check that the required network interface and DHCP tools are installed and configured.
