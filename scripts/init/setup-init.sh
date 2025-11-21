#!/bin/bash
set -e

# -------------------------
# Variables
# -------------------------
DOTFILES_DIR="$HOME/dev/warehouse/configs/dotfiles"

# -------------------------
# Install required packages
# -------------------------
echo "[INFO] Installing packages..."
sudo apt update
sudo apt install -y curl git zsh stow tree

# -------------------------
# Install Oh My Zsh if not already installed
# -------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "[INFO] Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "[INFO] Oh My Zsh already installed."
fi

# -------------------------
# Install Powerlevel10k theme
# -------------------------
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
  echo "[INFO] Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
  echo "[INFO] Powerlevel10k already installed."
fi

# -------------------------
# Ensure zsh is default shell
# -------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "[INFO] Setting Zsh as default shell..."
  chsh -s "$(which zsh)"
fi

# -------------------------
# Prepare dotfiles repo
# -------------------------
echo "[INFO] Creating dotfiles directory..."
mkdir -p "$DOTFILES_DIR"

if [ ! -d "$DOTFILES_DIR/shell_config" ]; then
  echo "[INFO] Cloning shell_config repo..."
  git clone git@github.com:fard-draf/shell_config.git "$DOTFILES_DIR/shell_config"
else
  echo "[INFO] shell_config repo already exists, pulling latest changes..."
  git -C "$DOTFILES_DIR/shell_config" pull
fi

echo "[INFO] Setup complete! 🎉"
echo "➡️  Log out and log back in to start using zsh + p10k."

## Ajouter le stow -t ~ // 
