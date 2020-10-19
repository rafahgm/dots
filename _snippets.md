# Linux snippets

## bluetoothctl
- Scan for devices
  - `bluetoothctl scan on`
- List devices found
  - `bluetoothctl devices`
- List devices paired with
  - `bluetoothctl paired-devices`
- Connect device
  - `bluetoothctl connect MAC`
- Trust device
  - `bluetoothctl trust MAC`
  - The device will automatically connect in the future
- Disconnect device
  - `bluetoothctl disconnect MAC`

## cursors
- `sudo eopkg install deepin-icon-theme`
  - Change in lxappearance and gnome-tweaks
  -	`sudo nano /usr/share/icons/deepin/cursor.theme`
  -	`Name=deepin`
  -	(this might be enough for it to work, but if not try these things)
  -	`sudo cp -r /usr/share/icons/deepin ~/.local/share/icons ~/.icons`

# chromium
- dark mode
  - `--force-dark-mode --enable-features=WebUIDarkMode`

## dpi settings
- In general
  - In ~/.Xresources: `Xft.dpi: 110`
  - In ~/.xinitrc: `xrdb -merge ~/.Xresources`
  - If xrdb not installed, `sudo eopkg install xrdb`
- VS Code
  - In settings.json: `"window.zoomLevel": 0.75`
- Spotify
  - In /usr/share/spotify/spotify.desktop: `Exec=spotify %U --force-device-scale-factor=1.25`
- Discord
  - In Settings > Appearance > Zoom level: `110`

## du
- Sort directories by size
  - `du -hs * | sort -rh`
  - remove -s to see full list of everything ordered by size (may want to append `| less`)

## dunst
- Pause
  - `notify-send DUNST_COMMAND_PAUSE`
- Resume
  - `notify-send DUNST_COMMAND_RESUME`
- Replace notification
  - `notify-send ' ' -h string:x-canonical-private-synchronous:x -t 1000 -a "$vol+"`
  - use `-h string:x-canonical-private-synchronous:x`, the 'x' at the end can be anything

## ffmpeg
- Add image to audio
  - `ffmpeg -loop 1 -i image.jpg -i song.mp3 -c:a copy -c:v libx264 -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -shortest out.mp4`

## find
- Prune
  - `find . -type d \( -path dir1 -o -path dir2 -o -path dir3 \) -prune -o -name "*thing*"`

## flatpak
- Fix cursors
  - `flatpak --user override com.spotify.Client --filesystem=/home/$USER/.icons/:ro`

## fstab
- Auto-mount USB
  - In /etc/fstab, add: `/dev/disk/by-label/Portable /mnt/Portable auto nofail,nosuid,nodev,gid=1000,uid=1000,x-gvfs-show 0 0`

## lamp
- Apache usage: https://getsol.us/articles/software/httpd/en/
- Install
  - `sudo eopkg install php httpd mariadb-server`
- Create config directory
  - `mkdir -p /etc/httpd/conf.d/`
- Create php index file
  - `sudo touch /var/www/index.php`
- Enable php
  - `sudo touch /etc/httpd/conf.d/php.conf`
  - Write to php.conf:
    ```conf
    LoadModule proxy_module lib64/httpd/mod_proxy.so
    LoadModule proxy_fcgi_module lib64/httpd/mod_proxy_fcgi.so
    <FilesMatch \.php$>
    SetHandler "proxy:fcgi://127.0.0.1:9000"
    </FilesMatch>
    <IfModule dir_module>
    DirectoryIndex index.php index.html
    </IfModule>
    ```
- Load changes
  - `sudo systemctl restart httpd && sudo systemctl restart php-fpm`
- Enable vhosts
  - `sudo touch /etc/httpd/conf.d/vhosts.conf`
- Write to vhosts.php:
  ```conf
  <VirtualHost *:80>
    DocumentRoot "/var/www/forum"
    ServerName forum
  </VirtualHost>
  ```
- Write to /etc/hosts: `127.0.0.1   forum`
- Optional short open tags
  - Write to /etc/php/php.ini: `short_open_tag = On`
- Use `lampr` (from ~/.config/bashrc) to restart lamp

## nvidia
- Fans
  - `nvidia-xconfig -a --cool-bits=28 --allow-empty-initial-configuration`
  - Relog
- `sudo nvidia-settings`
- Enable force full composition to fix refresh rate

## qt
- "QT\_QPA\_PLATFORMTHEME not set"
  - In /etc/environment, add: `QT_QPA_PLATFORMTHEME=qt5ct`
  - Relog

## rsync
- Example
  - `rsync -aAXv --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude="swapfile" --exclude="lost+found" /source /destination`
  - `-a, --archive`
  - `-A, --ascls (preserve Access Control Lists)`
  - `-X, --xattrs (preserve extended attributes)`
  - `-v, --verbose`

## screen
- Resume
  - `screen -r`
- Detach
  - `ctrl A then D`

## sudo
- Run a sudo command without sudo password
  - In /etc/sudoers, add: `adam ALL=(ALL) NOPASSWD: /path/to/command`

## vscode
- Font Awesome 5
  - In settings.json: `"editor.fontFamily": "'Roboto Mono', 'Font Awesome 5 Brands', 'Font Awesome 5 Free', 'Font Awesome 5 Free Solid'"`

## x
- Xlib not found
  - `sudo eopkg install libx11-devel`
- XInput2 not found
  - `sudo eopkg install libxi-devel`

## xrandr
- New resolution
  - `sudo cvt 1920 1080 60`
  - `sudo xrandr --newmode "1920x1080_60.00" 173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync`
  - `sudo xrandr --addmode DP-2 1920x1080_60.00`
  - `xrandr --output DP-2 --mode 1920x1080_60.00`

## youtube-dl
- Best quality
  - `youtube-dl -f bestvideo+bestaudio "link to youtube video"`
- Download audio only
  - `youtube-dl -x --audio-format mp3 "link to youtube video"`