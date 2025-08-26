#!/bin/bash

event=$(icalBuddy -n -ea -b "" -eep "location,url" -ps "| " -nc eventsToday+ | head -n 1)

if [ -z "$event" ]; then
  label="No events today"
else
  label=$(echo "$event" | cut -d '|' -f2 | xargs)
fi

sketchybar --set calendar label="$label"
