#!/bin/sh

#
#   Checks every 5 seconds for song change, updates the album art if the song has changed
#

# restarts conky in destkop mode
restart_conky() {
    killall conky
    conky -d -q
}

# downloads album art for the current song
download_album_art() {
    imgid=$(playerctl --player=spotify metadata mpris:artUrl | grep -o [^/]*$)
    wget -q "https://i.scdn.co/image/$imgid" -O ~/Pictures/album_art
}

current_track_id=''
current_spotify_state=''

while true; do

    this_spotify_state="$(playerctl -l | grep spotify || echo 'closed')"

    # check if spotify has changed state and the state is closed
    if [ "$current_spotify_state" != "$this_spotify_state" ] && [ "$this_spotify_state" == 'closed' ]; then
            echo 'Spotify changed to closed'
            echo '' >~/Pictures/album_art
            current_track_id=''
            restart_conky
    else
        # else: state is the same or spotify is open (or both)
        # check if spotify is open
        if [ "$this_spotify_state" != 'closed' ]; then
            echo 'Spotify is open'

            this_track_id="$(playerctl --player=spotify metadata mpris:trackid)"

            # check if song has changed
            if [ "$current_track_id" != "$this_track_id" ]; then
                echo 'Song has changed'
                # save new album art
                download_album_art
                restart_conky
                # update the current track id
                current_track_id="$this_track_id"
            else
                # else: state is the same, spotify is open, song is the same, do nothing
                echo 'Song is the same'
            fi

        else
            # else: state is the same, spotify is closed, do nothing
            echo 'Spotify is closed'
        fi
    fi

    # update current spotify state
    current_spotify_state="$this_spotify_state"
    echo '--------------'
    sleep 2
done
