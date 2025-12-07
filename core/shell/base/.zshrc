# ===================================================
#        FICHIER DE CONFIGURATION ZSH
# ===================================================
HOST_CONFIG_DIR="$HOME/.config/host_specific"

# Détermine le fichier d'environnement à charger en fonction du nom d'hôte.
case "$(hostname)" in
    'pve-dev')
        HOST_ENV_FILE="$HOST_CONFIG_DIR/pve-dev.env.sh"
        ;;
    'zaatar')
        HOST_ENV_FILE="$HOST_CONFIG_DIR/zaatar.env.sh"
        ;;
    'kamun')
        HOST_ENV_FILE="$HOST_CONFIG_DIR/kamun.env.sh"
        ;;
    'mgmt-ansible')
        HOST_ENV_FILE="$HOST_CONFIG_DIR/mgmt-ansible.env.sh"
        ;;
    'pepper')
        HOST_ENV_FILE="$HOST_CONFIG_DIR/pepper.env.sh"
        ;;
    *)
        HOST_ENV_FILE="$HOST_CONFIG_DIR/generic.env.sh"
        ;;
esac

# Source le fichier d'environnement s'il a été trouvé et est lisible.
if [ -f "$HOST_ENV_FILE" ]; then
    source "$HOST_ENV_FILE"
else
    echo "ERREUR : Fichier d'environnement '$HOST_ENV_FILE' introuvable." >&2
fi

# ======= OPTIMISATIONS DE PERFORMANCES =======
# Désactiver les mises à jour automatiques d'Oh My Zsh
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# ======= POWERLEVEL10K INSTANT PROMPT =======
# Doit rester près du début du fichier .zshrc
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# ======= CONFIGURATION OH MY ZSH =======
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Réduit le nombre de plugins au minimum essentiel
plugins=(git docker vscode npm node rust)

# ======= OPTIMISATION DE L'AUTOCOMPLÉTION =======
# Cache agressif des complétions
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -c '%Y' ~/.zcompdump 2>/dev/null | date +'%j')" ]; then
  compinit
else
  compinit -C
fi

# ======= CHARGEMENT OH MY ZSH =======
source $ZSH/oh-my-zsh.sh

# ======= CONFIGURATION SUPPLÉMENTAIRE =======
if [ -f /etc/zshrc ]; then
  source /etc/zshrc
fi

# ======= SCRIPTS MODULAIRES BASHRC.D =======
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      source "$rc"
    fi
  done
fi
unset rc

# ======= CONFIGURATION DE POWERLEVEL10K =======
# Pour personnaliser le prompt, lancer `p10k configure` ou éditer ~/.p10k.zsh
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ======= CHARGEMENT DES FICHIERS MODULAIRES =======

# Définir le chemin canonique en utilisant une fonction interne de Zsh (:A)
local main_zshrc_path="${ZDOTDIR:-$HOME}/.zshrc:A"

# 1. Charger les fichiers de configuration Zsh (tous les fichiers presents dans le dossier)
for config_file in "$DOTFILES/core/shell/zsh/"**/*.zsh; do
  # On utilise aussi ":A" ici pour la comparaison
  if [[ -f "$config_file" ]] && [[ "$config_file:A" != "$main_zshrc_path" ]]; then
    source "$config_file"
  fi
done
unset main_zshrc_path

# Créer les répertoires nécessaires
mkdir -p $DOTFILES/core/shell/zsh \
         $DOTFILES/core/shell/common \
         $DOTFILES/core/shell/env 
         
# Chargement des paths
if [[ -f $DOTFILES/core/shell/env/paths.env ]]; then
  source $DOTFILES/core/shell/env/paths.env
fi
# ================================================================
# SECTION FINALE : COMMANDES INTERACTIVES ET NON-INTERACTIVES
# ================================================================

# --- Commandes exécutées uniquement dans un terminal interactif ---
if [ -t 0 ]; then
  # 1. Changer le répertoire de démarrage
  if [[ -d "$DEV_ENV/warehouse" ]]; then
    cd "$DEV_ENV/warehouse"
  fi

  # 2. Corriger le caractère d'effacement du terminal
  stty erase '^?'
fi

# --- Commandes pouvant être exécutées dans tous les contextes ---

# Gestion des secrets
if [[ -f "$DOTFILES/core/shell/common/.secrets" ]]; then
  source "$DOTFILES/core/shell/common/.secrets"
fi

# Gestion de l'agent SSH
SYSTEMD_AGENT_SOCK="/run/user/$(id -u)/ssh-agent.socket"
if [[ -S "$SYSTEMD_AGENT_SOCK" ]]; then
  export SSH_AUTH_SOCK="$SYSTEMD_AGENT_SOCK"
fi

export NVM_DIR="$HOME/dev/tools/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ==================================================================
# PROMPT STARSHIP
# ==================================================================
if [ -t 1 ]; then
  eval "$(starship init zsh)"
fi

# ==================================================================
# LANCEMENT GRAPHIQUE
# ==================================================================

if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec uwsm start sway
fi

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
# shellcheck disable=SC2034,SC2153,SC2086,SC2155

# Above line is because shellcheck doesn't support zsh, per
# https://github.com/koalaman/shellcheck/wiki/SC1071, and the ignore: param in
# ludeeus/action-shellcheck only supports _directories_, not _files_. So
# instead, we manually add any error the shellcheck step finds in the file to
# the above line ...

# Source this in your ~/.zshrc
autoload -U add-zsh-hook

zmodload zsh/datetime 2>/dev/null

# If zsh-autosuggestions is installed, configure it to use Atuin's search. If
# you'd like to override this, then add your config after the $(atuin init zsh)
# in your .zshrc
_zsh_autosuggest_strategy_atuin() {
    # silence errors, since we don't want to spam the terminal prompt while typing.
    suggestion=$(ATUIN_QUERY="$1" atuin search --cmd-only --limit 1 --search-mode prefix 2>/dev/null)
}

if [ -n "${ZSH_AUTOSUGGEST_STRATEGY:-}" ]; then
    ZSH_AUTOSUGGEST_STRATEGY=("atuin" "${ZSH_AUTOSUGGEST_STRATEGY[@]}")
else
    ZSH_AUTOSUGGEST_STRATEGY=("atuin")
fi

export ATUIN_SESSION=$(atuin uuid)
ATUIN_HISTORY_ID=""

_atuin_preexec() {
    local id
    id=$(atuin history start -- "$1")
    export ATUIN_HISTORY_ID="$id"
    __atuin_preexec_time=${EPOCHREALTIME-}
}

_atuin_precmd() {
    local EXIT="$?" __atuin_precmd_time=${EPOCHREALTIME-}

    [[ -z "${ATUIN_HISTORY_ID:-}" ]] && return

    local duration=""
    if [[ -n $__atuin_preexec_time && -n $__atuin_precmd_time ]]; then
        printf -v duration %.0f $(((__atuin_precmd_time - __atuin_preexec_time) * 1000000000))
    fi

    (ATUIN_LOG=error atuin history end --exit $EXIT ${duration:+--duration=$duration} -- $ATUIN_HISTORY_ID &) >/dev/null 2>&1
    export ATUIN_HISTORY_ID=""
}

_atuin_search() {
    emulate -L zsh
    zle -I

    # swap stderr and stdout, so that the tui stuff works
    # TODO: not this
    local output
    # shellcheck disable=SC2048
    output=$(ATUIN_SHELL=zsh ATUIN_LOG=error ATUIN_QUERY=$BUFFER atuin search $* -i 3>&1 1>&2 2>&3)

    zle reset-prompt
    # re-enable bracketed paste
    # shellcheck disable=SC2154
    echo -n ${zle_bracketed_paste[1]} >/dev/tty

    if [[ -n $output ]]; then
        RBUFFER=""
        LBUFFER=$output

        if [[ $LBUFFER == __atuin_accept__:* ]]
        then
            LBUFFER=${LBUFFER#__atuin_accept__:}
            zle accept-line
        fi
    fi
}
_atuin_search_vicmd() {
    _atuin_search --keymap-mode=vim-normal
}
_atuin_search_viins() {
    _atuin_search --keymap-mode=vim-insert
}

_atuin_up_search() {
    # Only trigger if the buffer is a single line
    if [[ ! $BUFFER == *$'\n'* ]]; then
        _atuin_search --shell-up-key-binding "$@"
    else
        zle up-line
    fi
}
_atuin_up_search_vicmd() {
    _atuin_up_search --keymap-mode=vim-normal
}
_atuin_up_search_viins() {
    _atuin_up_search --keymap-mode=vim-insert
}

add-zsh-hook preexec _atuin_preexec
add-zsh-hook precmd _atuin_precmd

zle -N atuin-search _atuin_search
zle -N atuin-search-vicmd _atuin_search_vicmd
zle -N atuin-search-viins _atuin_search_viins
zle -N atuin-up-search _atuin_up_search
zle -N atuin-up-search-vicmd _atuin_up_search_vicmd
zle -N atuin-up-search-viins _atuin_up_search_viins

# These are compatibility widget names for "atuin <= 17.2.1" users.
zle -N _atuin_search_widget _atuin_search
zle -N _atuin_up_search_widget _atuin_up_search

bindkey -M emacs '^r' atuin-search
bindkey -M viins '^r' atuin-search-viins
bindkey -M vicmd '/' atuin-search
bindkey -M emacs '^[[A' atuin-up-search
bindkey -M vicmd '^[[A' atuin-up-search-vicmd
bindkey -M viins '^[[A' atuin-up-search-viins
bindkey -M emacs '^[OA' atuin-up-search
bindkey -M vicmd '^[OA' atuin-up-search-vicmd
bindkey -M viins '^[OA' atuin-up-search-viins
bindkey -M vicmd 'k' atuin-up-search-vicmd
