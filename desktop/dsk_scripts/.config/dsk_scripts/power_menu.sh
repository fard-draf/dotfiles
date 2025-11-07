#!/bin/bash

# Le chemin vers ton nouveau fichier de style
STYLE_FILE="/home/fard/.config/wofi/profiles/power_menu_style.css"

# MODIFIÉ ICI : Ajout de --style $STYLE_FILE
SELECTION=$(wofi --dmenu -a center -p "Select an option: " --style "$STYLE_FILE" <<-EOF
󰌾 Lock
󰤄 Suspend
󰍃 Log out
 Reboot
 Reboot to UEFI
󰐥 Shutdown
󰜺 Cancel
󰍁 Dev OFF
󰍀 Dev ON
EOF
)

confirm_action() {
    local prompt_text="$1"
    CONFIRMATION=$(printf "No\nYes" | wofi --dmenu -a center -p "${prompt_text}?" --style "$STYLE_FILE")
    [[ "$CONFIRMATION" == "Yes" ]]
}
case "$SELECTION" in
    *"Lock"*)
        swaylock -f -c 000000
        ;;
    *"Suspend"*)
        if confirm_action "Suspend"; then
            systemctl suspend
        fi
        ;;
    *"Log out"*)
        if confirm_action "Log out"; then
            swaymsg exit
        fi
        ;;
    *"Reboot"*)
        if confirm_action "Reboot"; then
            systemctl reboot
        fi
        ;;
    *"Reboot to UEFI"*)
        if confirm_action "Reboot to UEFI"; then
            systemctl reboot --firmware-setup
        fi
        ;;
    *"Shutdown"*)
        if confirm_action "Shutdown"; then
            systemctl poweroff
        fi
        ;;
    *"Dev OFF"*)
        if confirm_action "Dev OFF"; then
            exec pdev-power off
        fi
        ;;
    *"Dev ON"*)
        if confirm_action "Dev ON"; then
            exec pdev-power on
        fi
        ;;
    # L'option "Cancel" ne fait rien, le script se termine
    *"Cancel"*)
        exit 0
        ;;
esac
