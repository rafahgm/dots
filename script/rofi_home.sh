#!/bin/sh


loc=$(test $(ls /mnt/Portable | wc -l) = "0" && echo "$HOME" || echo /mnt/Portable)
res=$(ls "$loc" | rofi -dmenu -i -p '  ')

if [ "$res" != "" ]; then
    nautilus -w "$loc/$res"
fi