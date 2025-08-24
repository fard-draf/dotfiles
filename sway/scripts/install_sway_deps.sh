#!/bin/bash
#
# This script installs all necessary dependencies for the provided Sway configuration on a Fedora system.
# Version 5: Final, definitive version using official repositories for almost everything.
#

# Stop the script if any command fails
set -e

echo "--- Starting installation of Sway dependencies ---"
echo

# --- Enabling the necessary COPR repository for Wezterm ---
echo "-> Enabling COPR repository for 'wezterm'..."
# Wezterm is not in the official Fedora repos, so this is required.
sudo dnf copr enable -y wezfurlong/wezterm-nightly
echo "   COPR for wezterm enabled."
echo

# --- Main Package List ---
# All packages except wezterm are in the official Fedora repos.
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
    wl-clipboard
    grim
    slurp
    cliphist      # Available in official repos
    brightnessctl
    pavucontrol

    # Application and terminal packages
    wezterm       # Available via the COPR enabled above
    helix
    brave-browser
    network-manager-applet
    blueman

    # Utility and dependency packages
    pactl
    acpi
    pamixer
    gum           # Available in official repos
    tlp
    playerctl
    
    # Fonts
    fontawesome-fonts
    fira-code-fonts
)

echo "-> Installing all packages via DNF..."
echo "   This may take a few moments."

sudo dnf install -y "${PACKAGES[@]}"

echo
echo "--- Installation complete! ---"
echo "All dependencies for your Sway environment have been installed."
