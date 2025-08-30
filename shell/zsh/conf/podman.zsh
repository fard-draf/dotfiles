# ======= ALIAS PODMAN =======
alias d='podman'
alias pc='podman-compose'
alias pps='podman ps'
alias ppsa='podman ps -a'
alias pi='podman images'
alias prmi='podman rmi'
alias prm='podman rm'
alias pstop='podman stop $(podman ps -q)'      # Arrêter tous les conteneurs
alias pprune='podman system prune -a --volumes' # Nettoyer Podman
alias pstart='podman start'
alias prestart='podman restart'
alias plogs='podman logs'
alias pexec='podman exec -it'
alias pbuild='podman build'
alias ppull='podman pull'
alias ppush='podman push'


alias podman-al="show_aliases_from_file $DOTFILES/shell/zsh/conf/podman.zsh"

