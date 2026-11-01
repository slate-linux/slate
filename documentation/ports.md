# Creating and Maintaining Ports

Ports are shell scripts responsible for downloading, configuring, compiling and installing software.
Each port is stored in its own directory under /usr/ports.

## Creating a Port

1. Choose an appropriate category.
2. Create a directory for the package.
3. Create a port.sh file inside the package directory.
4. Add the download and extraction commands.
5. Configure and compile the source code.
6. Install the compiled software into the package staging directory.
7. Test the port by installing it through Slate.

Example directory:
    /usr/ports/utilities/example/port.sh

## Typical Port Script

A typical Autotools port looks like this:

    #!/bin/bash
    set -e

    cd /usr/ports/category/package

    curl -LO https://example.com/package-1.0.tar.xz
    tar -xf package-1.0.tar.xz
    cd package-1.0

    ./configure --prefix=/usr
    make -j"$(nproc)"
    make DESTDIR="$DESTDIR" install

The example is a template. Actual configuration options depend on the package being built.

## Build Staging

Ports should install files into the DESTDIR staging directory instead of directly into the running system.
This allows Slate to collect installed files and create a package without modifying the host filesystem.

For Make-based projects, this commonly means using:
    make DESTDIR="$DESTDIR" install

For Meson projects, this commonly means using:
    DESTDIR="$DESTDIR" ninja -C build install

Always check the build system documentation for the correct staging method.

## Maintaining Ports

- Prefer versioned source archives over unpinned development branches.
- Verify download URLs before updating a port.
- Check that archive filenames match the downloaded files.
- Check that extracted directory names match the port script.
- Keep configuration options minimal.
- Avoid unnecessary build dependencies.
- Test the port after changing its source version or build options.
- Check that installation places files inside DESTDIR.
- Remove temporary build files from the final package.

## Build Dependencies

Some packages require other libraries or development tools to compile.
Install these dependencies before building the port.
A library required to compile a package may also be required at runtime.
These two types of dependencies should be considered separately.

## Port Testing

After creating or updating a port:
1. Run the port through Slate.
2. Check the build output for errors.
3. Check that the expected files were installed.
4. Test the installed program.
5. Check that the package can be removed cleanly.
