#!/usr/bin/env bash
set -euo pipefail

# Détecter la distribution
install_pkg() {
    if command -v apt-get >/dev/null; then
        sudo apt-get update
        sudo apt-get install -y "$@"
    elif command -v dnf >/dev/null; then
        sudo dnf install -y "$@"
    elif command -v pacman >/dev/null; then
        sudo pacman -Sy --noconfirm "$@"
    elif command -v zypper >/dev/null; then
        sudo zypper install -y "$@"
    else
        echo "⚠️ Gestionnaire de paquets non supporté. Installe $* manuellement."
        exit 1
    fi
}

# 1. Installer zsh
if ! command -v zsh >/dev/null; then
    echo "➡️ Installation de zsh..."
    install_pkg zsh
else
    echo "✅ zsh déjà installé."
fi

# 2. Installer oh-my-zsh (si absent)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "➡️ Installation de oh-my-zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "✅ oh-my-zsh déjà installé."
fi

# 3. Installer powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "➡️ Installation de powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
else
    echo "✅ powerlevel10k déjà installé."
fi

# Modifier .zshrc pour utiliser powerlevel10k comme thème
if ! grep -q 'ZSH_THEME="powerlevel10k/powerlevel10k"' "$HOME/.zshrc"; then
    echo "➡️ Configuration du thème powerlevel10k dans .zshrc"
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc" || \
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$HOME/.zshrc"
fi

# 4. Définir zsh comme shell par défaut
if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "➡️ Définition de zsh comme shell par défaut..."
    chsh -s "$(command -v zsh)"
else
    echo "✅ zsh est déjà le shell par défaut."
fi

echo "🎉 Installation terminée. Redémarre ta session ou exécute 'exec zsh'."
