# Slate Package Manager

Slate uses its own package manager to install, remove, search and manage software.

## Commands

Install a package:
    slate install category/package

Remove a package:
    slate remove category/package

Search for a package:
    slate search package

List installed packages:
    slate list

## Package Names

Packages are identified by their category and package name.
For example, x11/dillo refers to the Dillo browser port.

## Installing Multiple Packages

Each package can be installed individually by specifying its full category and name.

Example:
    slate install lib/zlib
    slate install net/curl
    slate install x11/dillo

## Package Collections

The meta category contains package collections intended to install groups of related software.
These are useful for installing larger sets of software without manually specifying every package.

## Package Management Notes

- Use the complete category/package name when installing or removing software.
- Check that required libraries and build dependencies are installed.
- Keep track of manually installed software that is not managed by Slate.
- Review package changes before committing updates to the ports tree.
