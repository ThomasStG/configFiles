#!/usr/bin/env bash

count=$(osascript -e '
tell application "System Events"
  tell application process "Dock"
    try
      set badgeValue to value of attribute "AXStatusLabel" of UI element "Discord" of list 1
      return badgeValue
    on error
      return "0"
    end try
  end tell
end tell'
)

count=$(echo "$count" | grep -Eo '[0-9]+' | head -n1)

if [[ "$count" =~ ^[0-9]+$ ]]; then
  sketchybar --set discord_unread label="$count" icon=""
else
  sketchybar --set discord_unread label="0" icon=""
fi
