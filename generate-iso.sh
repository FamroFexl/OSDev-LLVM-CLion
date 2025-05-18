#!/usr/bin/env sh
KERNEL_BIN=$1
KERNEL_NAME=${KERNEL_BIN%.*}
KERNEL_ISO=${KERNEL_NAME}.iso

echo $KERNEL_NAME

mkdir -p isodir/boot/grub
cp "${KERNEL_BIN}" isodir/boot/${KERNEL_BIN}
echo "set timeout=0
set default=0
menuentry "${KERNEL_NAME}" {
	multiboot /boot/${KERNEL_BIN}
}" > isodir/boot/grub/grub.cfg
grub-mkrescue -o ${KERNEL_ISO} isodir
rm -rf isodir
