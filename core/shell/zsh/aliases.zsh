# ======= ALIAS GÉNÉRAUX =======
alias l='ls -lah'
alias ll='ls -lah'
alias la='ls -A'
alias lt='ls -lahtr'              
alias lsd='ls -lah | grep "^d"'   
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
alias dev='cd $DEV_PATH/'
alias dev='cd $DEV_PATH'
alias week='cd $DEV_PATH/warehouse/playground/weekly'
alias korri='cd $DEV_PATH/warehouse/projects/professional/korrigan'
alias wh='cd $DEV_PATH/warehouse'

# ======= ALIAS SHELL =======
alias shell='cd $DOTFILES/shell'
alias zshrc='hx $DOTFILES/shell/base/.zshrc'    
alias reload='exec zsh' 
alias zshalias='hx $DOTFILES/shell/zsh/aliases.zsh'
 
# ======= ALIAS CONFIGURATION =======
alias conf='cd $DEV_PATH/warehouse/configs'
alias dotf='cd $DOTFILES'
alias hxconf='hx $DOTFILES/helix/config.toml'
alias zelconf='hx $DOTFILES/zellij/config.kdl'

# ======= ALIAS TREE =======
alias t0='tree 1'
alias t1='tree -L 1 -a -I ".git"'
alias t2='tree -L 2 -a -I ".git"'
alias t3='tree -a -L 3 -a -I ".git"'
alias t4='tree -a -C -L 4 -a -I ".git"'
alias t5='tree -a -C -L 5 -a -I ".git"'

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
alias showalias='cat $DOTFILES/shell/zsh/aliases.zsh'



