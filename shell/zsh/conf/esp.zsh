# ======= CONFIGURATION ESP-IDF & RUST =======
# Charge la configuration de l'environnement générée par espup.
# Ce script contient toutes les variables (IDF_PATH, etc.) nécessaires.
if [ -f "/mnt/repo/dev/tools/esp-idf/export-esp.sh" ]; then
    source "/mnt/repo/dev/tools/esp-idf/export-esp.sh"
fi
