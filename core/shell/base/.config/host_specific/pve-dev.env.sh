#=======================================================
#         VARIABLES D'ENVIRONNEMENT PERSONNELLES
#=======================================================
export DEV_PATH="$HOME/dev"
export DOTFILES="$DEV_PATH/warehouse/configs/dotfiles"
export KORRI="$DEV_PATH/warehouse/projects/professional/korrigan"

#=======================================================
#         VARIABLES DES OUTILS DE DÉVELOPPEMENT
#=======================================================

#=======================================================HELIX
export HELIX_RUNTIME=~/src/helix/runtime
#=======================================================TYPESCRIPT
export TYPESCRIPT_HOME="$DEV_PATH/tools/typescript"
#=======================================================CARGO+RUST
export CARGO_HOME="$DEV_PATH/tools/rust/cargo"
export RUSTUP_HOME="$DEV_PATH/tools/rust/rustup"
#=======================================================NODEJS
export NODEJS_HOME="$DEV_PATH/tools/nodejs"
#=======================================================PYTHON
export PYENV_ROOT="$DEV_PATH/tools/pyenv"
#=======================================================YARN
export YARN_HOME="$DEV_PATH/tools/yarn"
export YARN_GLOBAL_FOLDER="${YARN_HOME}/global"
export YARN_CACHE_FOLDER="${YARN_GLOBAL_FOLDER}/cache"
#=======================================================ZSH
export ZSH="$HOME/.oh-my-zsh"
#=======================================================PODMAN
export CONTAINERS_STORAGE_OPTS="--root $DEV_PATH/tools/podman/storage"
#=======================================================PREFERENCES
export EDITOR=/bin/hx
export VISUAL=/bin/hx
