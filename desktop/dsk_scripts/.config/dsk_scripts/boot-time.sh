#!/bin/bash

LOG_FILE="$HOME/.cache/boot-times.log"

# Logger le temps actuel au démarrage (à exécuter une fois)
if [ "$1" == "--log" ]; then
    BOOT_TIME=$(systemd-analyze | grep 'Startup finished' | sed 's/.*= //' | sed 's/ *$//')
    echo "$(date '+%Y-%m-%d %H:%M') - $BOOT_TIME" >> "$LOG_FILE"
    exit 0
fi

# Afficher tooltip
if [ "$1" == "--tooltip" ]; then
    echo "10 derniers démarrages:"
    tail -n 10 "$LOG_FILE"
    exit 0
fi

# Afficher le temps actuel
systemd-analyze | grep 'Startup finished' | sed 's/.*= //' | sed 's/ *$//'
