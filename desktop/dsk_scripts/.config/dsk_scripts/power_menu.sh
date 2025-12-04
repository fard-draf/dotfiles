#!/bin/bash

STYLE_FILE="/home/fard/.config/wofi/profiles/power_menu_style.css"

main_menu() {
cat <<EOF
lock 󰌾
suspend 󰤄
log out 󰍃
reboot  
shutdown 󰐥
servers 󰈞
EOF
}

servers_menu() {
cat <<EOF
dev
pbs
EOF
}

dev_menu() {
cat <<EOF
 on
 off
EOF
}

pbs_menu() {
cat <<EOF
 on
 off
EOF
}

wofi_menu() {
    # wofi -S drun -p "$1" --width 110 --height 500 --style "$STYLE_FILE"
    wofi --dmenu -a center -p "$2" --width 110 --lines 7 --style "$STYLE_FILE"
}

SELECTION=$(wofi_menu "select an option:" <<<"$(main_menu)")

confirm_action() {
    local prompt_text="$1"
    CONFIRMATION=$(printf "no\nyes" | wofi_menu "${prompt_text}?")
    [[ "$CONFIRMATION" == "yes" ]]
}

case "$SELECTION" in
    *"lock"*)
        swaylock -f -c 000000
        ;;

    *"suspend"*)
        confirm_action "suspend" && systemctl suspend
        ;;

    *"log out"*)
        confirm_action "log out" && swaymsg exit
        ;;

    *"reboot"*)
        confirm_action "reboot" && systemctl reboot
        ;;

    *"shutdown"*)
        confirm_action "shutdown" && systemctl poweroff
        ;;

    *"servers"*)
        SERVER_SEL=$(wofi_menu "servers:" <<<"$(servers_menu)")
        case "$SERVER_SEL" in

            *"dev"*)
                DEV_SEL=$(wofi_menu "dev:" <<<"$(dev_menu)")
                case "$DEV_SEL" in
                    *"dev on"*)
                        exec pdev-power on
                        ;;
                    *"dev off"*)
                        exec pdev-power off
                        ;;
                esac
                ;;

            *"pbs"*)
                PBS_SEL=$(wofi_menu "pbs:" <<<"$(pbs_menu)")
                case "$PBS_SEL" in
                    *"pbs on"*)
                        exec pbs-power on
                        ;;
                    *"pbs off"*)
                        exec pbs-power off
                        ;;
                esac
                ;;
        esac
        ;;

    *"cancel"*)
        exit 0
        ;;
esac

