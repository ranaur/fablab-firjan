#!/bin/bash

total_minutes=0
total_seconds=0

for dir in */; do
    # Remove trailing slash
    dir_name="${dir%/}"

    # Extract part after "- "
    time_part="${dir_name##*- }"

    # Match pattern like 12m34
    if [[ "$time_part" =~ ^([0-9]+)m([0-9]+)$ ]]; then
        minutes="${BASH_REMATCH[1]}"
        seconds="${BASH_REMATCH[2]}"

        # Add to totals
        total_minutes=$((total_minutes + 10#$minutes))
        total_seconds=$((total_seconds + 10#$seconds))
    fi
done

# Normalize seconds into minutes
extra_minutes=$((total_seconds / 60))
remaining_seconds=$((total_seconds % 60))

total_minutes=$((total_minutes + extra_minutes))
# Normalize minutes → hours
hours=$((total_minutes / 60))
remaining_minutes=$((total_minutes % 60))

echo "Total: ${hours}h${remaining_minutes}m${remaining_seconds}s"

#echo "Total: ${total_minutes}m${remaining_seconds}s"
