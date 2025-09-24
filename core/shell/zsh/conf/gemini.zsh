gmf() {
  gemini -m gemini-2.5-flash -p "$1"
}
gmp() {
  gemini -m gemini-2.5-pro -p "$1"
}

alias gclif="gemini -m gemini-2.5-flash"
alias gclip="gemini -m gemini-2.5-pro"
