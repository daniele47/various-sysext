#!/usr/bin/bash

set -e

EXT_DIR="/var/lib/extensions/broadcom-wl-dkms/"

if [[ ! -e "$EXT_DIR" ]]; then
    echo "System extension is already uninstalled!"
    exit 1
fi

sudo rm -rf "$EXT_DIR"
echo "System extension has been uninstalled!"
