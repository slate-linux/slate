# Building Software for Slate

Software for Slate should be compiled against the Slate target environment.
Slate uses musl, so builds targeting glibc should not be assumed to work without modification.

## Cross Compilation

The Slate toolchain uses the x86_64-linux-musl target compiler.
Use the target compiler when building software for the Slate sysroot.

Example:
    x86_64-linux-musl-gcc --sysroot=/path/to/sysroot source.c -o program

## Sysroot

The sysroot provides the target headers, libraries and system files used during compilation.
Make sure the sysroot contains the dependencies required by the program being built.

## Build Failures

Build failures can be caused by missing dependencies, incompatible build options or assumptions about glibc.
Check compiler output before changing source code.
When patching software, keep patches small and document why they are required.

## Testing

Whenever possible, test compiled software inside a running Slate installation.
A successful compilation does not guarantee that the program will run correctly.
