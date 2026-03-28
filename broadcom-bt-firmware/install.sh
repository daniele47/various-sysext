#!/usr/bin/bash

set -e

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
EXT_NAME="broadcom-bt-firmware"
EXT_BASE_DIR="/var/lib/extensions"
EXT_DIR="$EXT_BASE_DIR/$EXT_NAME"
LOCAL_EXT_DIR="$SCRIPT_DIR/$EXT_NAME"

if [[ -e "$EXT_DIR" ]]; then
    echo "System extension is already installed!"
    exit 1
fi

sudo mkdir -p "$EXT_BASE_DIR"
sudo cp -r "$LOCAL_EXT_DIR" "$EXT_BASE_DIR"

echo "Extension installed! Merge system extensions or reboot to make it available!"
