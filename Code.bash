#!/bin/bash

PLEX_PATH="/usr/lib/plexmediaserver"

update_plex() {
    sudo service plexmediaserver stop

    wget -qO plex.deb "https://plex.tv/downloads/latest/1?channel=16&build=linux-aarch64&distro=debian"

    sudo dpkg -i plex.deb

    sudo service plexmediaserver start

    rm plex.deb
}

update_plex
