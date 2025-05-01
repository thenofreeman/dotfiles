#!/bin/bash

WAYBAR_CONFIG_DIR="$HOME/.config/waybar"
CONFIG_LINK="$WAYBAR_CONFIG_DIR/config"
CONFIG_SIMPLE="$WAYBAR_CONFIG_DIR/config-simple"
CONFIG_DETAILED="$WAYBAR_CONFIG_DIR/config-detailed"

# Check if the required config files exist
if [ ! -f "$CONFIG_SIMPLE" ] || [ ! -f "$CONFIG_DETAILED" ]; then
    echo "Error: Both config-simplified and config-detailed must exist in $WAYBAR_CONFIG_DIR"
    exit 1
fi

# Find out which config the link currently points to
current_target=$(readlink "$CONFIG_LINK")

if [ "$current_target" == "$CONFIG_SIMPLE" ]; then
    # Currently simple, switch to detailed
    new_target="$CONFIG_DETAILED"
    echo "Switching Waybar to Detailed mode"
else
    # Currently detailed (or link doesn't exist/points elsewhere), switch to simple
    new_target="$CONFIG_SIMPLE"
    echo "Switching Waybar to Simple mode"
fi

# Update the symbolic link atomically and forcefully
ln -sf "$new_target" "$CONFIG_LINK"

# Tell Waybar to reload its configuration
killall -SIGUSR2 waybar

exit 0
