#!/bin/sh
set -e

# Check for updates
if [ "$1" = "--check" ]; then
    echo "Checking for Slate updates"

    CURRENT=$(cat /etc/slate.conf/ver)
    VERSION=$(git ls-remote --tags --sort='version:refname' \
        https://github.com/surprisedcat32/slate.git |
        grep -v '\^{}' | tail -n 1 | sed 's|.*refs/tags/||')

    echo "Current version: $CURRENT"
    echo "Latest version: $VERSION"

    if [ "$CURRENT" = "$VERSION" ]; then
        echo "Slate is up to date"
    else
        echo "Update available: $VERSION"
    fi

    exit 0
fi

cd /tmp

[ "$(id -u)" = 0 ] || {
    echo "Please run as root."
    exit 1
}

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT
cd "$TMPDIR"

echo "Downloading update files"

VERSION=$(git ls-remote --tags --sort='version:refname' \
    https://github.com/surprisedcat32/slate.git |
    grep -v '\^{}' | tail -n 1 | sed 's|.*refs/tags/||')

git clone --branch "$VERSION" https://github.com/surprisedcat32/slate.git
cd slate

# Initramfs update
echo "Generating initramfs"
cd initramfs && find . -print0 | cpio --null -o -H newc | gzip -9 > ../slate-initramfs && cd .. && cp slate-initramfs /boot/slate-initramfs

# package manager update
echo "Updating Package Manager"
cp slate /usr/bin/slate

# init update
echo "Updating Init System"
cd init
cp rc.* /usr/bin/
cp init.d/* /etc/init.d/

# update slates version
echo "Updating Version Information"
echo "$VERSION" > /etc/slate.conf/ver
