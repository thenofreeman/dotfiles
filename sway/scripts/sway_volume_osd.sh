#!/bin/bash

# Script to change volume and send notification

# Notification settings
NID=3434
ICON_MUTED="audio-volume-muted"
# Choose icons based on level - find suitable names using an icon browser or file manager
ICON_LOW="audio-volume-low"
ICON_MEDIUM="audio-volume-medium"
ICON_HIGH="audio-volume-high"

# Function to get volume level (0-100) and mute status
get_volume_info() {
    MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "yes" || echo "no")
    VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oP 'Volume: \K[0-9.]+' | awk '{ printf "%d\n", $1 * 100 }')
}

# Function to send notification
send_notification() {
    get_volume_info
    local icon=$ICON_LOW
    if [[ "$MUTED" == "yes" ]]; then
        icon=$ICON_MUTED
        notify-send -r $NID -i "$icon" "Volume Muted" -h int:value:0 -h string:x-canonical-private-synchronous:volume_notif
    else
        if [[ $VOLUME -ge 66 ]]; then
            icon=$ICON_HIGH
        elif [[ $VOLUME -ge 33 ]]; then
            icon=$ICON_MEDIUM
        fi
        # Use hints for progress bar if your daemon supports it (like dunst/mako)
        # notify-send -r $NID -i "$icon" "Volume: ${VOLUME}%" -h int:value:"$VOLUME" -h string:x-canonical-private-synchronous:volume_notif
        notify-send -u low -r $NID -i "$icon" "Volume: ${VOLUME}%" -h int:value:"$VOLUME" -h string:x-canonical-private-synchronous:volume_notif
    fi
}

# Handle arguments
case $1 in
    up)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 # Unmute first
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ # Increase volume
        send_notification
        ;;
    down)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 # Unmute first
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- # Decrease volume
        send_notification
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle # Toggle mute
        send_notification
        ;;
    *)
        echo "Usage: $0 up|down|mute"
        exit 1
        ;;
esac
