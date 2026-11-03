# Slate System Overview

Slate is a lightweight Linux distribution built around a minimal base system, musl libc, a custom package manager, and a categorized ports collection.

## Design Goals

- Keep the default installation minimal.
- Avoid unnecessary background services.
- Prefer simple tools and straightforward configuration.
- Provide a package manager and ports tree.
- Support command-line and graphical environments.
- Minimize unnecessary dependencies.

## Core Components

### C Library
Slate uses musl as its C library. Software should be built against the Slate target environment.

### Package Management
Slate uses its own package manager and ports collection.

### Initialization
Slate uses a custom shell-based initialization system and a project-maintained initramfs.

### Desktop
X11 software is provided through the x11 ports category. Graphical components are optional.

## Filesystem

System configuration is generally stored under /etc. Executables are installed under /bin and /usr/bin, with libraries under /lib and /usr/lib.

## Architecture

Slate targets x86_64-linux-musl.
