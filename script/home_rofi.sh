#!/bin/sh

res=$(ls /mnt/Portable | rofi -dmenu -i -p Home:)

if [ "$res" != "" ]; then
    nautilus -w "/mnt/Portable/$res"
fi
