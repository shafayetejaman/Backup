
#!/usr/bin/env bash

# Find mounted USB drive label
MOUNT_BASE="/run/media/$USER"
DRIVE_LABEL=$(ls "$MOUNT_BASE" 2>/dev/null | head -n1)

if [[ -z "$DRIVE_LABEL" ]]; then
    echo "No USB drive mounted!"
    exit 1
fi

MOUNTPOINT="$MOUNT_BASE/$DRIVE_LABEL"

# Determine partition device (e.g., /dev/sdb1)
PARTDEV=$(lsblk -nrpo NAME,MOUNTPOINT | grep "$MOUNTPOINT" | awk '{print $1}')
if [[ -z "$PARTDEV" ]]; then
    echo "Could not find partition device."
    exit 2
fi

# Derive base device (e.g., /dev/sdb)
BASEDEV=$(echo "$PARTDEV" | sed 's/[0-9]*$//')

echo "Flushing writes to $PARTDEV..."
sync

echo "Unmounting $PARTDEV..."
udisksctl unmount -b "$PARTDEV" || { echo "Unmount failed"; exit 3; }

sleep 0.5

echo "Powering off $BASEDEV..."
udisksctl power-off -b "$BASEDEV" || { echo "Power‑off failed"; exit 4; }

echo "Drive safely removed!"
exit 0
