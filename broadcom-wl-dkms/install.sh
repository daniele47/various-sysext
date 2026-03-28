#!/usr/bin/bash

set -e

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
EXT_NAME="broadcom-wl-dkms"
EXT_BASE_DIR="/var/lib/extensions"
EXT_DIR="$EXT_BASE_DIR/$EXT_NAME"
LOCAL_EXT_DIR="$SCRIPT_DIR/.sysext/$(uname -r)/$EXT_NAME"

### INSTALL OR UPDATE SYSTEM EXTENSION ###

if ! [[ -d "$LOCAL_EXT_DIR" ]]; then
    echo "sysext for current kernel was not built"
    exit 1
fi

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
