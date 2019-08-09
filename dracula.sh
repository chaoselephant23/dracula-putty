#!/bin/bash

if [ "$1" = "" ]; then
    echo At least one Putty Session must be passed in as an argument!
    exit
fi

script_dir=$(pwd)
temp_file=$(mktemp -p "$script_dir" XXXXXXXXXXX.reg)
for s in $*; do
    cat "$script_dir/dracula.reg" | sed "s/Dracula/$s/g" > "$temp_file"
    temp_filename=$(basename "$temp_file")
    reg import $temp_filename > /dev/null
    if [ $? -eq 1 ]; then
        echo Failed to dracula PuTTY session    $s
    else
        echo Successfully dracula PuTTY session $s
    fi
done
rm -f "$temp_file"
