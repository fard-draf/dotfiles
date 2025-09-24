#!/bin/bash

LOG_FILE="$HOME/.cache/boot-times.log"

# Vérifier si 'gum' est installé
if ! command -v gum &> /dev/null; then
    foot --hold echo "Le paquet 'gum' est nécessaire."
    exit 1
fi

while true; do
    clear
    
    echo "--- Historique des temps de démarrage ---"
    
    if [ -f "$LOG_FILE" ] && [ -s "$LOG_FILE" ]; then
        cat "$LOG_FILE"
        echo
        
        # Calcul de la moyenne (extraction des secondes)

        avg=$(awk '{
            # Chercher le temps total (ex: "1min 23.456s" ou "45.678s")
            for(i=1; i<=NF; i++) {
                if($i ~ /min/) {
                    min = $i
                    gsub(/min/, "", min)
                    sec = $(i+1)
                    gsub(/s/, "", sec)
                    total += min*60 + sec
                    count++
                }
                else if($i ~ /^[0-9]+\.[0-9]+s$/) {
                    gsub(/s/, "", $i)
                    total += $i
                    count++
                }
            }
        } END {
            if(count>0) {
                avg_sec = total/count
                if(avg_sec >= 60)
                    printf "%dmin %.1fs", int(avg_sec/60), avg_sec%60
                else
                    printf "%.1fs", avg_sec
            }
        }' "$LOG_FILE")

echo "Moyenne: $avg"

        
    else
        echo "Aucun historique disponible."
    fi
    
    echo "------------------------------------------"
    echo
    
    choice=$(gum choose "Rafraîchir" "Réinitialiser l'historique" "Quitter" --height=3)
    
    [ -z "$choice" ] && break
    
    case "$choice" in
        "Réinitialiser l'historique")
            gum confirm "Effacer tout l'historique ?" && > "$LOG_FILE"
            ;;
        "Quitter")
            break
            ;;
    esac
done

clear
