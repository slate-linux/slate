#!/bin/bash
set -e

BASE="$(cd "$(dirname "$0")" && pwd)"
REPO="$(cd "$BASE/.." && pwd)"

SYSROOT="$BASE/sysroot"
INITRAMFS="$REPO/initramfs"
INITRD="$SYSROOT/boot/slate-initramfs"
IMG="$BASE/slate.img"

LOOP=""
MNT=""

cleanup() {
    set +e

    if [ -n "$MNT" ] && mountpoint -q "$MNT"; then
        sudo umount "$MNT"
    fi

    [ -z "$LOOP" ] || sudo losetup -d "$LOOP"
    [ -z "$MNT" ] || rmdir "$MNT" 2>/dev/null
}

trap cleanup EXIT INT TERM

[ -d "$SYSROOT" ] || { echo "Missing sysroot"; exit 1; }
[ -d "$INITRAMFS" ] || { echo "Missing initramfs"; exit 1; }
[ -f "$SYSROOT/boot/slate-kernel" ] || { echo "Missing kernel"; exit 1; }

echo "Installing init system..."

sudo mkdir -p "$SYSROOT/etc/init.d" "$SYSROOT/usr/bin" "$SYSROOT/boot"

sudo cp "$REPO"/init/rc.init "$REPO"/init/rc.reboot "$REPO"/init/rc.shutdown "$SYSROOT/usr/bin/"
sudo cp "$REPO"/init/init.d/* "$SYSROOT/etc/init.d/"

sudo chmod 755 "$SYSROOT"/usr/bin/rc.* "$SYSROOT"/etc/init.d/*
sudo ln -sf /bin/rc.init "$SYSROOT/etc/rc"

echo "Building initramfs..."

if command -v zstd >/dev/null 2>&1; then
    (cd "$INITRAMFS" && find . -print0 | cpio --null -o -H newc 2>/dev/null |
        zstd -19 -T0 -q -f -o "$INITRD")
else
    (cd "$INITRAMFS" && find . -print0 | cpio --null -o -H newc 2>/dev/null |
        gzip -9 > "$INITRD")
fi

echo "Calculating image size..."

SYSROOT_MB=$(sudo du -sm \
    --exclude="$SYSROOT/sysroot" \
    --exclude="$SYSROOT/home/login/distro" \
    "$SYSROOT" | awk '{print $1}')

IMAGE_MB=$((SYSROOT_MB + SYSROOT_MB * 8 / 100 + 32))

echo "Sysroot: ${SYSROOT_MB} MB"
echo "Image:   ${IMAGE_MB} MB"

echo "Creating image..."

sudo rm -f "$IMG"
truncate -s "${IMAGE_MB}M" "$IMG"

sudo parted -s "$IMG" mklabel gpt
sudo parted -s "$IMG" mkpart bios_grub 1MiB 3MiB
sudo parted -s "$IMG" set 1 bios_grub on
sudo parted -s "$IMG" mkpart root ext4 3MiB 100%

LOOP=$(sudo losetup --find --show --partscan "$IMG")
sudo udevadm settle

echo "Formatting filesystem..."

sudo mkfs.ext4 -F -m 0 -L SLATE-ROOT "${LOOP}p2"

MNT=$(mktemp -d)
sudo mount "${LOOP}p2" "$MNT"

echo "Copying sysroot..."

sudo tar -cpf - -C "$SYSROOT" \
    --exclude=./dev \
    --exclude=./proc \
    --exclude=./sys \
    --exclude=./run \
    --exclude=./tmp \
    --exclude=./mnt \
    --exclude=./media \
    --exclude=./lost+found \
    --exclude=./sysroot \
    --exclude=./home/login/distro \
    . | sudo tar -xpf - -C "$MNT"

sudo mkdir -p "$MNT/dev" "$MNT/proc" "$MNT/sys" \
    "$MNT/run" "$MNT/tmp" "$MNT/mnt" "$MNT/media"

sudo chmod 1777 "$MNT/tmp"

echo "Installing GRUB..."

sudo grub-install \
    --target=i386-pc \
    --boot-directory="$MNT/boot" \
    "$LOOP"

sudo mkdir -p "$MNT/boot/grub"

sudo tee "$MNT/boot/grub/grub.cfg" >/dev/null <<EOF
set timeout=1
set default=0

menuentry "Slate Linux" {
    linux /boot/slate-kernel rw loglevel=3 quiet
    initrd /boot/slate-initramfs
}
EOF

echo "Finalizing image..."

sync
sudo umount "$MNT"
MNT=""

sudo losetup -d "$LOOP"
LOOP=""

echo "Creating rootfs archive..."

sudo touch "$SYSROOT/usr/local/.installed"

sudo tar -c -C "$SYSROOT" \
    --exclude=./sysroot \
    --exclude=./home/login/distro \
    . | xz -9e -T0 > "$BASE/archive.tar.xz"

sudo rm -f "$SYSROOT/usr/local/.installed"

echo
echo "Build complete!"
echo
ls -lh "$IMG" "$BASE/archive.tar.xz"

echo
sudo fdisk -l "$IMG"
