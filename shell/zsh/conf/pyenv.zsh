
# ===================================================
#        INITIALISATION DYNAMIQUE DE PYENV
# ===================================================
if command -v pyenv &>/dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
