# Building Software for Slate

Slate uses musl as its C library.

## Cross Compilation

The target compiler is x86_64-linux-musl-gcc.

Example:

    x86_64-linux-musl-gcc --sysroot=/path/to/sysroot source.c -o program

## Sysroot

The sysroot contains target headers, libraries, and system files.

Ensure the sysroot contains all required dependencies.

## Build Systems

Build systems may require:

- CC
- CXX
- AR
- RANLIB
- PKG_CONFIG
- PKG_CONFIG_SYSROOT_DIR

## Build Failures

Common problems include missing dependencies, incorrect host settings, and assumptions about glibc.

## Testing

Test compiled software inside a running Slate installation whenever possible.
