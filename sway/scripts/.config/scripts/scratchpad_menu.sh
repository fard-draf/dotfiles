#!/bin/bash

declare -A window_map
wofi_input=$(mktemp)
trap 'rm -f "$wofi_input"' EXIT

# ## NOUVEAUTÉ N°1 : On initialise un compteur de lignes. ##
line_count=0

while IFS='|' read -r con_id app_id name; do
    display_name="${name}"
    window_map["$display_name"]=$con_id
    printf "%s\0icon\x1f%s\n" "$display_name" "$app_id" >> "$wofi_input"

    # ## NOUVEAUTÉ N°2 : On incrémente le compteur pour chaque fenêtre. ##
    ((line_count++))

done < <(swaymsg -t get_tree | jq -r '.. | select(.name? == "__i3_scratch") | .floating_nodes | .[] | "\(.id)|\(.app_id // "application-x-executable")|\(.name)"')

if ! [ -s "$wofi_input" ]; then
    exit 0
fi

# ## NOUVEAUTÉ N°3 : On ajoute un garde-fou. ##
# Pour éviter une fenêtre trop grande, on la limite à 15 lignes max.
if (( line_count > 15 )); then
    lines_to_show=15
else
    lines_to_show=$line_count
fi

# ## NOUVEAUTÉ N°4 : On utilise notre variable pour le nombre de lignes. ##
# La valeur de --lines est maintenant dynamique.
chosen_name=$(cat "$wofi_input" | wofi --dmenu --location center --width 50% --lines "$lines_to_show" --prompt "Scratchpad")

if [ -z "$chosen_name" ]; then
    exit 0
fi

chosen_id=${window_map["$chosen_name"]}
swaymsg "[con_id=$chosen_id]" scratchpad show
