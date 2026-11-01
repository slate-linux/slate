# Ports Directory Layout

Slate organizes its ports into categories under /usr/ports.
Each package has its own directory containing a port.sh build script.

## Categories

- dev: Compilers, build systems and development tools.
- lib: Shared libraries and supporting components.
- meta: Collections of related packages.
- misc: Miscellaneous applications and utilities.
- net: Networking software and network utilities.
- perl: Perl and Perl modules.
- system: Core system software and administration utilities.
- utilities: General command-line utilities.
- x11: X11 libraries, applications and desktop software.

## Example Structure

    /usr/ports/
    |-- dev/
    |   |-- gcc/
    |   |   |-- port.sh
    |   |-- cmake/
    |       |-- port.sh
    |-- lib/
    |   |-- zlib/
    |       |-- port.sh
    |-- net/
    |   |-- openssh/
    |       |-- port.sh
    |-- x11/
        |-- dillo/
            |-- port.sh

## Choosing a Category

Place software in the category that best describes its primary purpose.
Avoid creating new categories for individual packages when an existing category is suitable.
Libraries should generally be placed in lib, development tools in dev, and X11 software in x11.

## Package Directory Contents

A package directory normally contains its port.sh script and may contain supporting files.
Downloaded source archives and extracted build directories are temporary build files, not port definitions.
