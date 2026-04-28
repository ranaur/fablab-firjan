#!/bin/bash

total_minutes=0
total_seconds=0

for file in *; do
    #echo -n "$file : "
    # Remove trailing slash if dir
    file_name="${file%/}"

    # Remove trailing slash if dir
    extension="${file_name##*.[a-zA-Z]}"
    file_name="${file_name%%.[a-zA-Z]*}"

    # Extract part after "- "
    time_part="${file_name##*- }"

    # Match pattern like 12m34
    if [[ "$time_part" =~ ^([0-9]+)m([0-9]+)$ ]]; then
        minutes="${BASH_REMATCH[1]}"
        seconds="${BASH_REMATCH[2]}"

        #echo Adding ... $minutes:$seconds
        # Add to totals
        total_minutes=$((total_minutes + 10#$minutes))
        total_seconds=$((total_seconds + 10#$seconds))
    else
        :
        #echo Skipping ... $time_part
    fi
done

# Normalize seconds into minutes
extra_minutes=$((total_seconds / 60))
remaining_seconds=$((total_seconds % 60))

total_minutes=$((total_minutes + extra_minutes))
# Normalize minutes → hours
hours=$((total_minutes / 60))
remaining_minutes=$((total_minutes % 60))

if [ "$1" == --mv-dir ] ; then
    curr_dir="$(pwd)"
    curr_dir_name="$(basename "$curr_dir")"
    time_part="${curr_dir_name##*- }"
    if [[ "$time_part" =~ ^([0-9]+)m([0-9]+)$ ]]; then
        curr_dir_prefix="${curr_dir_name% - *}"
    else
        curr_dir_prefix="$curr_dir_name"
    fi

    NEWDIR="$curr_dir_prefix - ${total_minutes}m${remaining_seconds}"
    #pushd . > /dev/null
    cd ..
    mv "$curr_dir_name" "$NEWDIR" 
    #if [ $? == 0 ] ; then
    #    cd "$NEWDIR"
    #else
    #    cd "$curr_dir_name"
    #fi
    echo change to parent directory!
else
    echo "Total: ${total_minutes}m${remaining_seconds}s"
    echo "Total: ${hours}h${remaining_minutes}m${remaining_seconds}s"
fi

#echo "Total: ${total_minutes}m${remaining_seconds}s"
