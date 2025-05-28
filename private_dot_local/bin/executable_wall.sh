#! /usr/bin/env bash
if [ -z "$1" ]; then
    wal --saturate 0.25 -qi ~/Pictures/wallpapers
else
    echo "~/Pictures/wallpapers/$1"
    wal --saturate 0.25 -qi ~/Pictures/wallpapers/$1
fi
pkill hyprpaper
pkill dunst
ln -fs $(<"${HOME}/.cache/wal/wal") ~/Pictures/wallpapers/current
dunst --startup_notification &
hyprpaper
