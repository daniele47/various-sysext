#!/usr/bin/bash

set -e

EXT_DIR="/var/lib/extensions/broadcom-bt-firmware"
DISABLE_BT_ETC_FILE="/etc/modprobe.d/broadcom-bt-firmware-disable-for-safety.conf"

sudo -v
echo "Deleting files and directories:"

# removing etc configuration file to disable bluetooth
sudo rm -f "/etc/modprobe.d/broadcom-bt-firmware-disable-for-safety.conf"
echo -e "- \e[1;34m$DISABLE_BT_ETC_FILE\e[m"

# deleting system extension
sudo rm -rf "$EXT_DIR"
echo -e "- \e[1;34m$EXT_DIR\e[m"

echo -e "\nREBOOT TO APPLY CHANGES!!!"
