# Slate System Overview

Slate is a lightweight Linux distribution built around a minimal base system and a package-managed software collection.
The base installation is intended to provide the essential tools needed to boot, configure and administer the system.
Additional software can be installed as needed.

## Design Goals

- Keep the default installation minimal.
- Avoid enabling unnecessary background services.
- Provide a package manager and ports tree for installing additional software.
- Prefer simple tools and straightforward configuration.
- Keep the system usable without requiring a large desktop environment.

## Software Selection

Slate provides a collection of system utilities, libraries, networking tools, development software and X11 applications.
Users can install the components they need instead of receiving every component in the default installation.

## C Library

Slate uses musl as its C library.
Software intended for Slate should be built and tested against the target musl environment.
Software written specifically for glibc may require patches or compatibility changes.

## Init and Services

Slate uses sinit for system initialization.
Optional service scripts are stored in /etc/init.d.
Services are not all enabled by default. Users can invoke the service scripts they need.
Consult the individual script for its supported commands and behavior.

## Desktop Software

X11 software is provided through the x11 ports category.
Window managers, terminal emulators and graphical applications can be installed separately.
A graphical environment is not required for the base system.
