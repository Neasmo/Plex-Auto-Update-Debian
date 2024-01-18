#!/bin/bash

PLEX_PATH="/usr/lib/plexmediaserver"

update_plex() {
    sudo service plexmediaserver stop
    wget -qO plex.deb "https://plex.tv/downloads/latest/1?channel=16&build=linux-aarch64&distro=debian"
    sudo dpkg -i plex.deb
    sudo service plexmediaserver start
    rm plex.deb
}

check_updates_periodically() {
    while true; do
        echo "Vérification des mises à jour..."
        latest_version=$(curl -sSL "https://plex.tv/downloads/latest/1?channel=16&build=linux-aarch64&distro=debian" | grep -oP 'PlexMediaServer-.*?_aarch64.deb' | sed 's/PlexMediaServer-//; s/_aarch64.deb//')
        current_version=$(dpkg -l plexmediaserver | awk '/plexmediaserver/ {print $3}')

        if [ "$latest_version" != "$current_version" ]; then
            echo "Mise à jour disponible (actuelle: $current_version, dernière: $latest_version)"
            update_plex
        else
            echo "Pas de mise à jour disponible. Vérification dans 24 heures..."
        fi

        sleep 86400
    done
}

check_updates_periodically
