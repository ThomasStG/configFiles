#!/usr/bin/env bash

event=$(osascript <<EOF
tell application "Calendar"
  set calName to "Thomas - gmail"
  set theCalendar to calendar calName
  set nowDate to current date

  set futureEvents to {}
  repeat with e in (every event of theCalendar)
    if start date of e > nowDate then
      copy e to end of futureEvents
    end if
  end repeat

  if (count of futureEvents) = 0 then
    return "No Upcoming Events"
  end if

  set earliestEvent to item 1 of futureEvents
  repeat with i from 2 to count of futureEvents
    if start date of item i of futureEvents < start date of earliestEvent then
      set earliestEvent to item i of futureEvents
    end if
  end repeat


  set eventTime to start date of earliestEvent
  return eventSummary & " at " & eventTime
end tell
EOF
)

sketchybar --set calendar label="$event" icon="󰃮"
