#!/bin/sh

res=$(find /mnt/Portable/Bookmarks/ -type f | sed s,/mnt/Portable/Bookmarks/,, | rofi -dmenu -i -p Bookmarks:)

if [ "$res" != "" ]; then
    firefox $(cat /mnt/Portable/Bookmarks/"$res")
fi
