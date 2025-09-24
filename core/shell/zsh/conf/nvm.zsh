# ===================================================
#        INITIALISATION DYNAMIQUE DE NVM (lazy)
# ===================================================
export NVM_DIR="$HOME/dev/tools/nodejs/nvm"

nvm_lazy_load() {
  unset -f node npm npx nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

for cmd in node npm npx nvm; do
  eval "
  $cmd() {
    nvm_lazy_load
    command $cmd \"\$@\"
  }
  "
done
