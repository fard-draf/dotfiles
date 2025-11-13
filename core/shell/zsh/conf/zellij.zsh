# ======= ALIAS ZELLIJ ========
alias z.dev='zellij --layout dev'
alias z.run='zellij --layout run'
alias z.kbsp='zellij --layout kbsp attach --create korri-dev'
alias zka='zellij kill-all-sessions -y'
alias swayconf='zellij --layout sway_conf'

zjc() {
    local s
    s=$(basename "$PWD")
    zellij attach --create "$s"
}


