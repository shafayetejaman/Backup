
#!/usr/bin/env bash

MOUNT_BASE="/run/media/$USER"
DRIVE_LABEL=$(ls -1 "$MOUNT_BASE" 2>/dev/null | head -n1)

if [[ -z "$DRIVE_LABEL" ]]; then
    echo "No USB drive mounted!"
    exit 1
fi

MOUNTPOINT="$MOUNT_BASE/$DRIVE_LABEL"

# This handles spaces correctly
PARTDEV=$(findmnt --noheadings --output SOURCE --target "$MOUNTPOINT")

if [[ -z "$PARTDEV" ]]; then
    echo "Could not find partition device."
    exit 2
fi

# Strip digits from end to get the base device
BASEDEV=$(echo "$PARTDEV" | sed -E 's/[0-9]+$//')

echo "Flushing writes to $PARTDEV..."
sync

echo "Unmounting $PARTDEV..."
udisksctl unmount -b "$PARTDEV" || { echo "Unmount failed"; exit 3; }

sleep 0.5

echo "Powering off $BASEDEV..."
udisksctl power-off -b "$BASEDEV" || { echo "Power‑off failed"; exit 4; }

echo "Drive safely removed!"
