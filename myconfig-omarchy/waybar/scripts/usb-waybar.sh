
#!/bin/bash

# Directory where USB drives mount
MOUNT_BASE="/run/media/$USER"

# Get first USB drive mounted (change head -n1 to list all if you want multiple)
get_usb_drive() {
    ls "$MOUNT_BASE" 2>/dev/null | head -n1
}

# Show icon in Waybar
show_icon() {
    DRIVE=$(get_usb_drive)
    if [ -n "$DRIVE" ]; then
        echo " "
    else
        echo ""
    fi
}


# Output for Waybar
show_icon
