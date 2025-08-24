#!/bin/bash
#
# This script installs all necessary dependencies for the provided Sway configuration on a Fedora system.
# Version 3: Final, simplified version using official Fedora repositories.
#

# Stop the script if any command fails
set -e

echo "--- Starting installation of Sway dependencies ---"
echo

# --- Package List ---
# All packages are now available in the official Fedora repositories.
PACKAGES=(
    # Core Sway and graphical session packages
    sway
    waybar
    swaylock
    swayidle
    swaybg
    kanshi
    mako
    wofi
    wlogout
    wl-clipboard  # Provides wl-copy and wl-paste
    grim
    slurp
    cliphist
    brightnessctl
    pavucontrol

    # Application and terminal packages
    wezterm
    helix       # The 'hx' editor
    brave-browser
    network-manager-applet  # Provides nm-connection-editor
    bleman

    # Utility and dependency packages
    pactl       # For audio control
    acpi
    pamixer
    gum         # Now included directly
    tlp
    playerctl   # For media key support
    
    # Fonts
    fontawesome-fonts
    fira-code-fonts
)

echo "-> Installing all packages via DNF..."
echo "   List: ${PACKAGES[*]}"

sudo dnf install -y "${PACKAGES[@]}"

echo
echo "--- Installation complete! ---"
echo "All dependencies for your Sway environment have been installed."
