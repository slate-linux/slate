#!/bin/sh
set -e

VER="${1#--ver=}"

[ -n "$VER" ] || {
    echo "Usage: $0 --ver=VERSION"
    exit 1
}

echo "Downloading Slate Linux $VER..."
curl -fL "https://github.com/slate-linux/slate/releases/download/$VER/rootfs.tar.xz" -o rootfs.tar.xz

echo "Extracting rootfs..."
mkdir -p sysroot
tar -xf rootfs.tar.xz -C sysroot

echo "Building ISO..."
./build-iso.sh
