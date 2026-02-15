#!/bin/bash

# Unicode blocks for vertical battery (bottom to top)
LEVELS=( "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" )

# Approximate left-side padding (~10 px)
LEFT_PADDING=" "  # adjust spaces to match your font

while true; do
    BAT_PATH="/sys/class/power_supply/BAT0"

    if [ -d "$BAT_PATH" ]; then
        CAPACITY=$(cat "$BAT_PATH/capacity")

        # Determine which block to show (8 levels)
        INDEX=$((CAPACITY * 8 / 100 - 1))
        (( INDEX < 0 )) && INDEX=0

        BAT="${LEVELS[$INDEX]} $CAPACITY%"
    else
        BAT="BAT: N/A"
    fi

    DATE=$(date "+%Y-%m-%d %-I:%M %p")

    # Set status bar with left-side padding
    xprop -root -set WM_NAME "$LEFT_PADDING$BAT | $DATE$LEFT_PADDING"

    sleep 1
done
