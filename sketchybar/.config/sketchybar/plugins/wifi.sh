#!/bin/bash

SSID=$(wdutil info | awk -F': ' '/SSID:/ { print $2 }' | head -n 1)
RSSI=$(wdutil info | awk -F': ' '/RSSI:/ { print $2 }' | head -n 1)

# Convert RSSI to signal quality
if [[ "$RSSI" -ge -50 ]]; then
  SIGNAL="󰤨" # Excellent
elif [[ "$RSSI" -ge -60 ]]; then
  SIGNAL="󰤥" # Good
elif [[ "$RSSI" -ge -70 ]]; then
  SIGNAL="󰤢" # Fair
else
  SIGNAL="󰤟" # Poor
fi

sketchybar --set "$NAME" label="$SSID $SIGNAL"
