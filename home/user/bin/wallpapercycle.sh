#!/bin/bash

wallpapers_dir=~/Pictures/Wallpapers
wallpapers=("$wallpapers_dir"/*)
index_file="$wallpapers_dir/.last_index"

# Check if the index file exists, create it if not
if [[ ! -f $index_file ]]; then
    echo 0 > $index_file
fi

last_index=$(< "$index_file")
next_index=$(( (last_index + 1) % ${#wallpapers[@]} ))
echo $next_index > "$index_file"

selected_wallpaper="${wallpapers[$next_index]}"

hyprctl hyprpaper preload "$selected_wallpaper"
hyprctl hyprpaper wallpaper ",$selected_wallpaper"
sleep 1
hyprctl hyprpaper unload unused
