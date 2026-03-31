#!/usr/bin/bash

set -e

CLEANUP_FILES=(
    /var/lib/extensions/broadcom-bt-firmware
    /etc/modprobe.d/broadcom-bt-firmware-disable-for-safety.conf
)

# filter for existing files
for f in "${CLEANUP_FILES[@]}"; do
    if [[ -e "$f" ]]; then to_clean+=("$f"); fi
done

if [[ "${#to_clean[@]}" -eq 0 ]]; then 
    # early exit if nothing to cleanup
    echo "Nothing to cleanup left!"
else
    # remove files left to cleanup
    sudo -v
    echo "Deleting files and directories:"
    for f in "${to_clean[@]}"; do
        echo -e "- \e[1;34m$f\e[m"
        sudo rm -rf "$f"
    done
    echo -e "\nREBOOT TO APPLY CHANGES!!!"
fi
