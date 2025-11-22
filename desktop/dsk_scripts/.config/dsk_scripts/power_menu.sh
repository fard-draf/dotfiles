#!/bin/bash

STYLE_FILE="/home/fard/.config/wofi/profiles/power_menu_style.css"

main_menu() {
cat <<EOF
 Lock 󰌾
 Suspend 󰤄
 Log out 󰍃
 Reboot  
 Shutdown 󰐥
 Servers 󰈞
 Cancel 󰜺
EOF
}

servers_menu() {
cat <<EOF
󰍁 Dev
󰍀 PBS
󰜺 Cancel
EOF
}

dev_menu() {
cat <<EOF
󰍀 Dev ON
󰍁 Dev OFF
󰜺 Cancel
EOF
}

pbs_menu() {
cat <<EOF
󰍀 PBS ON
󰍁 PBS OFF
󰜺 Cancel
EOF
}

wofi_menu() {
    wofi --dmenu -a center -p "$1" --width 220 --height 300 --style "$STYLE_FILE"
}

SELECTION=$(wofi_menu "Select an option:" <<<"$(main_menu)")

confirm_action() {
    local prompt_text="$1"
    CONFIRMATION=$(printf "No\nYes" | wofi_menu "${prompt_text}?")
    [[ "$CONFIRMATION" == "Yes" ]]
}

case "$SELECTION" in
    *"Lock"*)
        swaylock -f -c 000000
        ;;

    *"Suspend"*)
        confirm_action "Suspend" && systemctl suspend
        ;;

    *"Log out"*)
        confirm_action "Log out" && swaymsg exit
        ;;

    *"Reboot"*)
        confirm_action "Reboot" && systemctl reboot
        ;;

    *"Shutdown"*)
        confirm_action "Shutdown" && systemctl poweroff
        ;;

    *"Servers"*)
        SERVER_SEL=$(wofi_menu "Servers:" <<<"$(servers_menu)")
        case "$SERVER_SEL" in

            *"Dev"*)
                DEV_SEL=$(wofi_menu "Dev:" <<<"$(dev_menu)")
                case "$DEV_SEL" in
                    *"Dev ON"*)
                        confirm_action "Dev ON" && exec pdev-power on
                        ;;
                    *"Dev OFF"*)
                        confirm_action "Dev OFF" && exec pdev-power off
                        ;;
                esac
                ;;

            *"PBS"*)
                PBS_SEL=$(wofi_menu "PBS:" <<<"$(pbs_menu)")
                case "$PBS_SEL" in
                    *"PBS ON"*)
                        confirm_action "PBS ON" && exec pbs-power on
                        ;;
                    *"PBS OFF"*)
                        confirm_action "PBS OFF" && exec pbs-power off
                        ;;
                esac
                ;;
        esac
        ;;

    *"Cancel"*)
        exit 0
        ;;
esac

