
#!/bin/bash

# Script pour orchestrer le démarrage de la session graphique

# 1. Lancer Kanshi en arrière-plan pour qu'il gère les profils d'écrans
killall - SIGHUP kanshi &

# 2. Attendre quelques secondes. C'est CRUCIAL.
#    Cela laisse le temps à Kanshi de détecter les écrans, de communiquer
#    avec le système et d'appliquer le bon profil.
sleep 3

# 3. Maintenant que la scène est prête, on lance le script d'organisation
#    des workspaces.
~/.config/sway/scripts/organiser_workspaces.sh
