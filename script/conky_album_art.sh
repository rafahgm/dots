#!/bin/sh

#
#   Conky album art getter
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

    # get spotify state
    this_spotify_state="$(playerctl -l | grep spotify || echo 'closed')"

    # check is spotify is open
    if [ "$this_spotify_state" != 'closed' ]; then
        # get track id
        this_track_id="$(playerctl --player=spotify metadata mpris:trackid)"
        # check if track id has changed
        if [ "$current_track_id" != "$this_track_id" ]; then
            echo 'Song has changed'
            # get new album art
            download_album_art
            restart_conky
            # update the current track id
            current_track_id="$this_track_id"
        else
            # track id hasn't changed, do nothing
            echo 'Song is the same'
        fi
    else
        # else: spotify is closed
        # check if the state was changed
        if [ "$current_spotify_state" != "$this_spotify_state" ]; then
            echo 'Spotify changed to closed'
            # set the album art to nothing
            echo '' >~/Pictures/album_art
            restart_conky
            current_track_id=''
        else
            # else: spotify is still closed, do nothing
            echo 'Spotify is closed'
        fi
        # reset the track id, update current spotify state
    fi

    # update spotify state
    current_spotify_state="$this_spotify_state"

    # sleep 2 seconds every loop
    echo '--------------'
    sleep 2
done
