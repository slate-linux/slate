# Slate Package Manager

Slate uses its own package manager to install, remove, search, and manage software.

## Commands

Install:

    slate install category/package

Remove:

    slate remove category/package

Search:

    slate search package

List installed packages:

    slate installed

## Package Names

Packages use category/package identifiers.

Example:

    slate install lib/zlib
    slate install net/curl
    slate install x11/dillo

## Meta Packages

The meta category contains collections of related packages.

## Repositories

Slate 0.6 introduces multiple repository support.

Repository configuration is stored in /etc/slate.conf/repos.

## Package Management Notes

- Use complete package identifiers.
- Check dependencies before installation.
- Review repository configuration.
- Test package removal.
