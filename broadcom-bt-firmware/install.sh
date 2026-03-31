#!/usr/bin/bash

set -e

SCRIPT_PATH="$(realpath "${BASH_SOURCE[0]}")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"
EXT_NAME="broadcom-bt-firmware"
EXT_BASE_DIR="/var/lib/extensions"
EXT_DIR="$EXT_BASE_DIR/$EXT_NAME"
LOCAL_EXT_DIR="$SCRIPT_DIR/$EXT_NAME"
DISABLE_BT_ETC_FILE="/etc/modprobe.d/broadcom-bt-firmware-disable-for-safety.conf"

sudo -v
echo "Creating files and directories:"

# create etc file to disable bluetooth module (these bluetooth firmware are unsafe)
echo 'blacklist btusb' | sudo tee "$DISABLE_BT_ETC_FILE" >/dev/null
echo -e "- \e[1;34m$DISABLE_BT_ETC_FILE\e[m (to disable unsafe bluetooth)"

# copy sysext dir into place, after deleting anything that might already exist in its place
sudo rm -rf "$EXT_DIR"
sudo mkdir -p "$EXT_BASE_DIR"
sudo cp -r "$LOCAL_EXT_DIR" "$EXT_BASE_DIR"
echo -e "- \e[1;34m$EXT_DIR\e[m (to install system extension)"

echo -e "\nREBOOT TO APPLY CHANGES!!!"
