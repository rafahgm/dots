#!/bin/sh

#
#   Checks every 5 seconds for song change, updates the album art if the song has changed
#

current_track_id=''

while true; do
    this_track_id="$(playerctl --player=spotify metadata mpris:trackid)"

    if [ "$current_track_id" != "$this_track_id" ]; then
        echo "Song has changed: $this_track_id"
        imgid=$(playerctl --player=spotify metadata mpris:artUrl | grep -o [^/]*$)
        echo "Image: $imgid"
        wget -q "https://i.scdn.co/image/$imgid" -O ~/Pictures/album_art
        current_track_id="$this_track_id"
        killall conky
        conky -d
        echo 'Conky restarted'
    else
        echo "Song is the same: $this_track_id"
    fi

	sleep 2
done