# Slate Linux

Slate is a lightweight Linux distribution built around musl, sinit, and a custom package manager. 

## Features

- musl libc
- Custom package manager
- Source-based ports collection
- Minimal default installation
- X11 support
- Lightweight software selection
- Cross-compilation support

## Package Management

Slate uses its own package manager to install and manage software.

### Commands

Install a package:
    slate install category/package

Remove a package:
    slate remove category/package

List installed packages:
    slate installed 
Update Slate Version
    slate update

## Configuration
The current version of slate is configured in /etc/slate.conf/ver
Versions such as 0.4, 0.4.1,0.5 are supported as well as 'testing'
## Ports

Slate uses a ports collection to build software from source.

Ports are stored under /usr/ports and organized into categories.

Each package has its own directory containing a port.sh script.

### Categories

- dev: Development tools
- lib: Libraries
- meta: Package collections
- misc: Miscellaneous software
- net: Networking software
- perl: Perl modules
- system: System utilities
- utilities: General utilities
- x11: X11 software

## System

Slate uses musl as its C library and sinit for system initialization.

The system is intentionally minimal. Software and services are provided without requiring everything to be installed or enabled by default.

### Services

Service scripts are located in /etc/init.d.

This directory contains both core system services and optional services.

Examples include:
- sdhcp
- filesystems
- seatd
- sshd

Services are managed through their individual scripts.
