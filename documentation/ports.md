# Creating and Maintaining Ports

Ports describe how software is downloaded, configured, compiled, and installed.

## Creating a Port

1. Choose a category.
2. Create a package directory.
3. Create port.sh.
4. Add source download commands.
5. Extract the source.
6. Configure the build.
7. Compile the software.
8. Install into DESTDIR.
9. Test the package.

## Example Port

    #!/bin/sh
    set -e

    cd /usr/ports/category/package

    curl -LO https://example.org/package-1.0.tar.xz
    tar -xf package-1.0.tar.xz
    cd package-1.0

    ./configure --prefix=/usr
    make -j"$(nproc)"
    make DESTDIR="$DESTDIR" install

## Staging

Ports should install into DESTDIR rather than directly into the running system.

For Make:

    make DESTDIR="$DESTDIR" install

For Meson:

    DESTDIR="$DESTDIR" ninja -C build install

## Maintaining Ports

- Use versioned source archives.
- Verify download URLs.
- Check archive filenames.
- Keep patches small.
- Avoid unnecessary dependencies.
- Test installation and removal.
- Remove temporary build files.
- Verify that all installed files are staged.
