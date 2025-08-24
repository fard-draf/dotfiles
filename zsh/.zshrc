# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

#ESP
#source $HOME/export-esp.sh

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# ======= ALIAS GÉNÉRAUX =======
alias l='ls -lah'
alias ll='ls -lah'
alias la='ls -A'
alias lt='ls -lahtr'              # Trié par date, le plus récent en dernier
alias lsd='ls -lah | grep "^d"'   # Liste uniquement les répertoires
alias cl='clear'
alias h='history'
alias hg='history | grep'
alias md='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias dev='cd /mnt/sumac/dev'
alias wh='cd /mnt/sumac/dev/warehouse'
alias korri='cd /mnt/sumac/dev/warehouse/projects/professional/korrigan/'
alias zshrc='$EDITOR ~/.zshrc'    # Éditer rapidement votre .zshrc
alias reload='source ~/.zshrc'    # Recharger zsh
alias t1='tree -L 1 -a'
alias t2='tree -L 2 -a'
alias t3='tree -a -L 3'
alias t4='tree -a -C -L 4'
alias cloud='cd /home/fard/Documents/10_SYNC/10.2_VAULTS/10.2.1_SUMAC_CLOUD'
alias :q='exit'
alias dotfiles='/home/fard/dotfiles'

# ======= ALIAS SYSTÈME =======
alias update='sudo dnf update -y'
alias install='sudo dnf install -y'
alias remove='sudo dnf remove'
alias search='dnf search'
alias ports='netstat -tulanp'
alias process='ps aux | grep'
alias meminfo='free -m -l -t'
alias cpuinfo='lscpu'
alias diskspace='df -h'
alias wezterm='flatpak run org.wezfurlong.wezterm'

# ======= ALIAS VAULT ====
export VAULT_PATH="/home/fard/Documents/10_SYNC/10.2_VAULTS/10.2.1_SUMAC_CLOUD"

# ======= ALIAS GIT =======
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gd='git diff'
alias glog='git log --oneline --graph --decorate'
alias nah='git reset --hard && git clean -df'  # Annule tous les changements locaux
alias gundo='git reset HEAD~1'                 # Annule le dernier commit
alias gsync='git pull origin $(git rev-parse --abbrev-ref HEAD)' # Synchro avec remote

# ======= ALIAS DOCKER =======
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drmi='docker rmi'
alias drm='docker rm'
alias dstop='docker stop $(docker ps -q)'      # Arrêter tous les conteneurs
alias dprune='docker system prune -a --volumes' # Nettoyer Docker

# ======= ALIAS NODE.JS / NPM =======
alias n='npm'
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nr='npm run'
alias ns='npm start'
alias nt='npm test'
alias nrb='npm run build'
alias nrd='npm run dev'
alias nrw='npm run watch'
alias nrs='npm run serve'
alias nout='npm outdated'
alias nupd='npm update'

# ======= ALIAS YARN =======
alias y='yarn'
alias ya='yarn add'
alias yad='yarn add --dev'
alias yag='yarn global add'
alias yr='yarn run'
alias ys='yarn start'
alias yt='yarn test'
alias yb='yarn build'
alias yd='yarn dev'

# ======= ALIAS PNPM =======
alias p='pnpm'
alias pi='pnpm install'
alias pa='pnpm add'
alias pad='pnpm add -D'
alias pr='pnpm run'
alias ps='pnpm start'
alias pt='pnpm test'

# ======= ALIAS TYPESCRIPT =======
alias tsb='tsc --build'
alias tsw='tsc --watch'
alias tsc-check='tsc --noEmit'

# ======= ALIAS RUST =======
alias cb='cargo build'
alias cr='cargo run'
alias ct='cargo test'
alias cc='cargo check'
alias cbn='cargo build --release'
alias crn='cargo run --release'
alias cup='cargo update'
alias cafmt='cargo fmt'
alias caclippy='cargo clippy'

# ======= ALIAS SOLANA =======
alias sol='solana'
alias solb='solana balance'
alias solc='solana config'
alias sold='solana deploy'
alias solp='solana program'
alias sola='solana address'



# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export SSH_ASKPASS=""

# pnpm
export PNPM_HOME="/home/fard/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH=$HOME/.local/bin:$PATH


# Ajoutez à la fin de votre ~/.zshrc
export PATH="$HOME/bin:$PATH"

export LS_COLORS=""

alias ls='ls --color=never'
export LS_COLORS=""
#source $HOME/export-esp.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export EDITOR=hx
# ==================================================================================SECRETS
 if [[ -f "~/dotfiles/zsh/.secrets" ]]; then
  source "~/dotfiles/zsh/.secrets"
fi

