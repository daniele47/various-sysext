#!/usr/bin/bash

set -e

EXT_DIR="/var/lib/extensions/broadcom-bt-firmware"

if [[ ! -e "$EXT_DIR" ]]; then
    echo "System extension is already uninstalled!"
    exit 1
fi

sudo rm -f "/etc/modprobe.d/broadcom-bt-firmware-disable-for-safety.conf"
sudo rm -rf "$EXT_DIR"
echo "System extension has been uninstalled!"
