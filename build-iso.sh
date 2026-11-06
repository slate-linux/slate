#!/bin/bash
set -e

BASE="/home/login/distro"

SYSROOT="$BASE/sysroot"
INITRAMFS="$BASE/initramfs"
INITRD="$BASE/slate-initramfs"
IMG="$BASE/slate.img"

EXTRA_MB=2

LOOP=""
MNT=""
sudo cp -r ports/ sysroot/usr/
cleanup() {
    set +e

    if [ -n "$MNT" ] && mountpoint -q "$MNT"; then
        sudo umount "$MNT"
    fi

    if [ -n "$LOOP" ]; then
        sudo losetup -d "$LOOP" 2>/dev/null || true
    fi

    if [ -n "$MNT" ]; then
        rmdir "$MNT" 2>/dev/null || true
    fi
}

trap cleanup EXIT INT TERM

if [ ! -d "$SYSROOT" ]; then
    echo "ERROR: missing sysroot: $SYSROOT"
    exit 1
fi

if [ ! -d "$INITRAMFS" ]; then
    echo "ERROR: missing initramfs: $INITRAMFS"
    exit 1
fi


cd ~/distro/initramfs && find . -print0 | cpio --null -o -H newc | gzip -9 > ../slate-initramfs && cd .. && sudo cp slate-initramfs sysroot/boot/slate-initramfs


sudo mkdir -p "$SYSROOT/boot"

sudo cp -f \
    "$INITRD" \
    "$SYSROOT/boot/slate-initramfs"




SYSROOT_MB=$(sudo du -sx --block-size=1M "$SYSROOT" | awk '{print $1}')

IMAGE_MB=$((SYSROOT_MB + EXTRA_MB + 32))




sudo rm -f "$IMG"




truncate -s "${IMAGE_MB}M" "$IMG"


sudo parted -s "$IMG" mklabel gpt


sudo parted -s "$IMG" mkpart bios_grub 1MiB 3MiB
sudo parted -s "$IMG" set 1 bios_grub on




sudo parted -s "$IMG" mkpart root ext4 3MiB 100%




LOOP=$(sudo losetup --find --show --partscan "$IMG")


sleep 1




sudo mkfs.ext4 \
    -F \
    -L SLATE-ROOT \
    "${LOOP}p2"




MNT=$(mktemp -d)


sudo mount "${LOOP}p2" "$MNT"


# Copy sysroot


sudo tar -cpf - \
    -C "$SYSROOT" \
    --exclude=./dev \
    --exclude=./proc \
    --exclude=./sys \
    --exclude=./run \
    --exclude=./tmp \
    --exclude=./mnt \
    --exclude=./media \
    --exclude=./lost+found \
    . |
    sudo tar -xpf - -C "$MNT"




sudo mkdir -p \
    "$MNT/dev" \
    "$MNT/proc" \
    "$MNT/sys" \
    "$MNT/run" \
    "$MNT/tmp" \
    "$MNT/mnt" \
    "$MNT/media"

sudo chmod 1777 "$MNT/tmp"




sudo grub-install \
    --target=i386-pc \
    --boot-directory="$MNT/boot" \
    "$LOOP"




sudo mkdir -p "$MNT/boot/grub"

sudo tee "$MNT/boot/grub/grub.cfg" >/dev/null <<EOF
set timeout=3
set default=0

menuentry "Slate Linux" {
    linux /boot/slate-kernel rw loglevel=3 quiet 
    initrd /boot/slate-initramfs
}
EOF




if [ ! -f "$SYSROOT/boot/slate-kernel" ]; then
    echo "ERROR: missing kernel:"
    echo "       $SYSROOT/boot/slate-kernel"
    exit 1
fi



sync




sudo umount "$MNT"

sudo losetup -d "$LOOP"
LOOP=""

rmdir "$MNT"
MNT=""



echo "Image:"
ls -lh "$IMG"

echo
echo "Partitions:"
sudo fdisk -l "$IMG"
touch sysroot/usr/local/.installed
sudo tar -cf - sysroot/ | xz -9e -T0 > archive.tar.xz
rm sysroot/usr/local/.installed
