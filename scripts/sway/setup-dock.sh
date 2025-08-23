
#!/bin/bash

# --- LA SOLUTION À LA CONDITION DE COURSE ---
# On attend 3 secondes pour être certain que tous les 
# moniteurs connectés au dock sont bien initialisés par le système.
sleep 3

# --- LA COMMANDE PARFAITE ---
# C'est votre commande, qui fonctionne à 100%.
swaymsg "output \"AOC 1601W MMEM1JA000545\" enable pos 0 856 res 1920x1080 transform 270; output \"Samsung Electric Company Odyssey G5 HK7X400599\" enable pos 1080 856 res 2560x1440@119.998Hz; output \"Samsung Electric Company LS32CG51x H9JX201723\" enable pos 3640 0 res 2560x1440 transform 90; output eDP-1 disable; workspace 1 output \"Samsung Electric Company Odyssey G5 HK7X400599\"; output * bg /usr/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill"
