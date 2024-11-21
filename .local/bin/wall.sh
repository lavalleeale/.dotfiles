#! /usr/bin/env sh
wal --iterative -qi ~/Pictures/wallpapers
pkill hyprpaper
ln -fs $(<"${HOME}/.cache/wal/wal") ~/Pictures/wallpapers/current
hyprpaper
