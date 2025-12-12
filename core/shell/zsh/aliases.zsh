# ======= ALIAS GÉNÉRAUX =======
alias l='eza -lah --icons'
alias ll='eza -lah --icons'
alias la='eza -a --icons'
alias lt='eza -lah --sort=modified --reverse --icons'    # équivalent ls -lahtr
alias lsd='eza -lah --icons --only-dirs'

alias cl='clear'
alias h='history'
alias hg='history | grep'
alias md='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias :q='exit'
alias :rbn='sudo reboot now -y'

# ======= ALIAS NAVIGATION REPOSITORY =======
alias dwl='cd $HOME/Downloads'
alias dev='cd $DEV_PATH'
alias week='cd $DEV_PATH/warehouse/playground/weekly'
alias korri='cd $DEV_PATH/warehouse/projects/professional/korrigan'
alias lib='cd $DEV_PATH/warehouse/projects/libs'
alias wh='cd $DEV_PATH/warehouse'
alias embed='cd $DEV_PATH/warehouse/embedded'

# ======= ALIAS SHELL =======
alias shell='cd $DOTFILES/core/shell'
alias zshrc='hx $DOTFILES/core/shell/base/.zshrc'
alias reload='exec zsh'
alias zshalias='hx $DOTFILES/core/shell/zsh/aliases.zsh'

# ======= ALIAS CONFIGURATION =======
alias conf='cd $DEV_PATH/warehouse/configs'
alias dotf='cd $DOTFILES'
alias hxconf='hx $DOTFILES/dev/helix/config.toml'
alias zelconf='hx $DOTFILES/dev/zellij/config.kdl'

# ======= ALIAS TREE (version eza) =======
alias t0='eza -a --icons --tree -L 1'
alias t1='eza -a --icons --tree -L 1 --ignore-glob=".git"'
alias t2='eza -a --icons --tree -L 2 --ignore-glob=".git"'
alias t3='eza -a --icons --tree -L 3 --ignore-glob=".git"'
alias t4='eza -a --icons --tree -L 4 --ignore-glob=".git"'
alias t5='eza -a --icons --tree -L 5 --ignore-glob=".git"'

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

# ======= ALIAS HELPER =======
alias showalias='cat $DOTFILES/core/shell/zsh/aliases.zsh'
