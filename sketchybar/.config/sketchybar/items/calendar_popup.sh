#!/bin/bash

# Show next 5 events with time
events=$(icalBuddy -n -ea -b "" -eep "location,url,notes" -ps "::" -nc eventsToday+ | head -n 10)

# Parse and format
formatted=""
i=1
echo "$events" | while IFS= read -r line; do
  time=$(echo "$line" | cut -d ':' -f1 | xargs)
  title=$(echo "$line" | cut -d ':' -f2- | xargs)
  formatted+="\n[$i] $time - $title"
  i=$((i + 1))
done

# Display popup (replacing label temporarily)
sketchybar --set calendar label="$formatted"
