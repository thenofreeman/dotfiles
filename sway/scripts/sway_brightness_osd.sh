#!/bin/bash

# Script to change brightness and send notification

# Notification settings
NID=4545
ICON="display-brightness" # Generic icon, find better ones if needed

# Function to get brightness percentage
get_brightness() {
    PERCENTAGE=$(brightnessctl -m | cut -d',' -f4)
}

# Function to send notification
send_notification() {
    get_brightness
    # Use hints for progress bar
    notify-send -u low -r $NID -i $ICON "Brightness: $PERCENTAGE" -h int:value:"${PERCENTAGE%\%}" -h string:x-canonical-private-synchronous:brightness_notif
}

# Handle arguments
case $1 in
    up)
        brightnessctl set 10%+
        send_notification
        ;;
    down)
        brightnessctl set 10%-
        send_notification
        ;;
    *)
        echo "Usage: $0 up|down"
        exit 1
        ;;
esac
