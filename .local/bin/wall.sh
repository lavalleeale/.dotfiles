#! /usr/bin/env sh
wal  --iterative -qi ~/Pictures
killall hyprpaper
echo "preload = $(< "${HOME}/.cache/wal/wal")" > ~/.config/hypr/hyprpaper.conf
echo "wallpaper = eDP-1,$(< "${HOME}/.cache/wal/wal")" >> ~/.config/hypr/hyprpaper.conf
hyprpaper
