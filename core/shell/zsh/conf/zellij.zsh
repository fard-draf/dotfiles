# ======= ALIAS ZELLIJ ========
alias zsm='zellij -l welcome'
alias z.dev='zellij --layout /home/fard/dev/warehouse/configs/dotfiles/dev/zellij/.config/zellij/layouts/dev.kdl attach --create dev'
alias z.run='zellij --layout run attach --create run'
alias z.kbsp='zellij --layout kbsp attach --create kbsp'
alias z.dotf='zellij --layout dotf attach --create dotf'
alias z.mgmt='zellij --layout mgmt attach --create mgmt'
alias z.reset='rm -rf ~/.cache/zellij'

alias zka='zellij kill-all-sessions -y'
alias zkc='zellij kill-session'

zjc() {
    local s
    s=$(basename "$PWD")
    zellij attach --create "$s"
}


