# Ports Directory Layout

Ports are organized into categories under /usr/ports.

Each package normally contains a port.sh build script.

## Categories

- dev: Compilers and development tools.
- lib: Libraries.
- meta: Package collections.
- misc: Miscellaneous software.
- net: Networking software.
- perl: Perl and Perl modules.
- system: Core system software.
- utils: General utilities.
- x11: X11 software and desktop applications.

## Example

    /usr/ports/
    ├── dev/
    │   └── cmake/
    │       └── port.sh
    ├── lib/
    │   └── zlib/
    │       └── port.sh
    └── x11/
        └── dillo/
            └── port.sh

## Counting Ports

    find . -type f -name port.sh | wc -l

Ports are grouped by their primary purpose.
