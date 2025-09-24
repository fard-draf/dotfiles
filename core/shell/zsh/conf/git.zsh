
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
alias gnah='git reset --hard && git clean -df'  # Annule tous les changements locaux
alias gundo='git reset HEAD~1'                 # Annule le dernier commit
alias gsync='git pull origin $(git rev-parse --abbrev-ref HEAD)' # Synchro avec remote

alias git-al="show_aliases_from_file $DOTFILES/shell/zsh/conf/git.zsh"
