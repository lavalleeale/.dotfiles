#! /usr/bin/env zsh
if [ $(tty) = /dev/tty1 ]; then
    exec Hyprland
fi
