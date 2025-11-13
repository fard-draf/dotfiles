# Copie dans le buffer 
ry() {
    local target="$1"
    if [ -z "$target" ]; then
        echo "Usage: ryank <file|dir>"
        return 1
    fi

    mkdir -p "/tmp/.stash_rsync"
    rsync -a "$target" "/tmp/.stash_rsync/"
}

# Colle du buffer vers le dossier actuel et supprime le buffer
rp() {
    local dest="$1"
    if [ -z "$dest" ]; then
        echo "Usage: rpaste <destination>"
        return 1
    fi

    if rsync -a "/tmp/.stash_rsync/" "$dest/"; then
        rm -rf "/tmp/.stash_rsync"/*
    else
        echo "Erreur dans rpaste, stash conservé."
        return 1
    fi
}

rpk() {
    local dest="$1"
    if [ -z "$dest" ]; then
        echo "Usage: rpaste <destination>"
        return 1
    fi

  rsync -a "/tmp/.stash_rsync/" "$dest/"
}

rcl() {
    rm -rf "/tmp/.stash_rsync"/*
}
