#! /usr/bin/env sh
wal --iterative --saturate 0.25 -qi ~/Pictures/wallpapers
pkill hyprpaper
pkill dunst
ln -fs $(<"${HOME}/.cache/wal/wal") ~/Pictures/wallpapers/current
dunst --startup_notification &
hyprpaper
