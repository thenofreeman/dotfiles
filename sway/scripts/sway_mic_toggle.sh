#!/bin/bash

# Script to toggle microphone mute and send notification via notify-send

# --- Configuration ---
# Notification ID (should be unique)
NID=5656
# Icons (check if these exist in your icon theme, find alternatives if needed)
ICON_MUTED="microphone-sensitivity-muted" # Standard icon name
ICON_UNMUTED="audio-input-microphone"     # Standard icon name
# ---------------------

# 1. Toggle the mute status for the default audio source
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

# 2. Get the *new* mute status
# Checks if the output of wpctl includes the word "MUTED"
MUTE_STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo "MUTED" || echo "UNMUTED")

# 3. Set notification text and icon based on the new status
if [[ "$MUTE_STATUS" == "MUTED" ]]; then
    ICON=$ICON_MUTED
    TEXT="Microphone: Muted"
else
    ICON=$ICON_UNMUTED
    TEXT="Microphone: Unmuted"
fi

# 4. Send the notification
#    -u low: Low urgency (for short timeout via mako/dunst config)
#    -r $NID: Replace previous notification with this ID
#    -i $ICON: Set the icon
#    -h string:..: Hint for some daemons to treat this as a replaceable notification
notify-send -u low -r $NID -i "$ICON" "$TEXT" \
    -h string:x-canonical-private-synchronous:mic_mute_notif

exit 0
