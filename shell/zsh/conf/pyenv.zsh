
# ===================================================
#        INITIALISATION DYNAMIQUE DE PYENV
# ===================================================
# Ces commandes doivent s'exécuter après la définition
# de PYENV_ROOT et la mise à jour du PATH.

if command -v pyenv &>/dev/null; then
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi
