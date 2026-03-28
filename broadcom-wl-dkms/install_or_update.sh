#!/usr/bin/bash

set -e

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
BUILD_DIR="$SCRIPT_DIR/.build"
SYSEXT_DIR="$SCRIPT_DIR/.sysext"
KERNEL_VERSION=$(uname -r)
EXT_NAME="broadcom-wl-dkms"
EXT_BASE_DIR="/var/lib/extensions"
EXT_DIR="$EXT_BASE_DIR/$EXT_NAME"
LOCAL_EXT_DIR="$SYSEXT_DIR"

### BUILD SYSEXT DIRECTORY ###

# install deps
sudo pacman -Syu --noconfirm --needed base-devel make                                   # make/gcc/... to build
sudo pacman -Syu --noconfirm --needed linux-headers linux-zen-headers linux-lts-headers # convers most linux headers required to build

# cleanup build dir if already exists
rm -rf "$BUILD_DIR" "$SYSEXT_DIR"

# copy all into build dir
mkdir -p "$BUILD_DIR" "$SYSEXT_DIR"
cp -r "$SCRIPT_DIR/broadcom-wl-dkms" "$BUILD_DIR"

# move into correct dir
! cd "$BUILD_DIR/broadcom-wl-dkms/usr/src/broadcom-wl-6.30.223.271" && echo 'failed to enter correct dir' && exit 1
make -C "/lib/modules/$(uname -r)/build" "M=$(pwd)" modules

# bundle the necessary files into a sysext
mkdir -p "$SYSEXT_DIR/usr/lib/modules/$KERNEL_VERSION/extra"
cp "$BUILD_DIR/broadcom-wl-dkms/usr/src/broadcom-wl-6.30.223.271/wl.ko" "$SYSEXT_DIR/usr/lib/modules/$KERNEL_VERSION/extra"
cp -r "$BUILD_DIR/broadcom-wl-dkms/usr/lib/modprobe.d" "$SYSEXT_DIR/usr/lib/"
cp -r "$BUILD_DIR/broadcom-wl-dkms/usr/share" "$SYSEXT_DIR/usr/share"

### INSTALL OR UPDATE SYSTEM EXTENSION ###

updated=false
if [[ -e "$EXT_DIR" ]]; then
    updated=true
    sudo rm -rf "$EXT_DIR"
fi

sudo mkdir -p "$EXT_BASE_DIR"
sudo cp -r "$LOCAL_EXT_DIR" "$EXT_BASE_DIR"

if "$updated"; then
    echo "Extension updated! Merge system extensions or reboot to make it available!"
else
    echo "Extension installed! Merge system extensions or reboot to make it available!"
fi
