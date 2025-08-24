#!/bin/bash

# Vérifier si 'gum' est installé
if ! command -v gum &> /dev/null; then
    kitty --hold echo "Le paquet 'gum' est nécessaire. Voir les instructions d'installation."
    exit 1
fi

# Boucle principale du script
while true; do
    # On nettoie l'écran et on affiche le statut en premier
    clear
    
    # MODIFICATION ICI : On retire le cadre et la couleur pour un affichage simple.
    echo "--- État Actuel de la Batterie (TLP) ---"
    sudo tlp-stat -s -b
    echo "------------------------------------------"
    echo

    # gum choose crée un menu sélectionnable avec les flèches
    choice=$(gum choose "Forcer charge complète" "Recalibrer batterie" "Définir les seuils" "Quitter" --height=4)

    # Si l'utilisateur appuie sur Echap, gum retourne une chaîne vide
    if [ -z "$choice" ]; then
        clear
        break
    fi

    case "$choice" in
        "Forcer charge complète")
            gum confirm "Lancer une charge complète pour BAT0 ?" && sudo tlp fullcharge BAT0
            ;;
        "Recalibrer batterie")
            gum confirm "Lancer le recalibrage pour BAT0 ?" && sudo tlp recalibrate BAT0
            ;;
        "Définir les seuils")
            start_charge=$(gum input --placeholder "Seuil de DÉBUT (ex: 70)" --prompt "│ ")
            if [ $? -ne 0 ]; then continue; fi
            
            stop_charge=$(gum input --placeholder "Seuil de FIN (ex: 80)" --prompt "│ ")
            if [ $? -ne 0 ]; then continue; fi

            if [ -n "$start_charge" ] && [ -n "$stop_charge" ]; then
                gum confirm "Régler les seuils à $start_charge% - $stop_charge% ?" && sudo tlp setcharge "$start_charge" "$stop_charge" BAT0
            fi
            ;;
        "Quitter")
            clear
            break
            ;;
    esac
    sleep 1
done
