STASH_DIR="/tmp/.stash_rsync"

rsc() {
    local target="$1"

    if [ -z "$target" ]; then
        echo "Usage: ryk <file|dir>"
        return 1
    fi

    if [ ! -e "$target" ]; then
        echo "ryk: '$target' n'existe pas"
        return 1
    fi

    mkdir -p "$STASH_DIR"
    # on reset le stash à chaque yank
    rm -rf "$STASH_DIR"/*

    rsync -a "$target" "$STASH_DIR"/
}

rsp() {
    local dest="${1:-.}"

    if [ ! -d "$dest" ]; then
        echo "rpt: '$dest' n'est pas un dossier existant"
        return 1
    fi

    # on colle le CONTENU du stash dans le dossier dest (qui existe déjà)
    if rsync -a "$STASH_DIR"/ "$dest"/; then
        # si tu veux garder le stash, commente la ligne suivante
        rm -rf "$STASH_DIR"/*
    else
        echo "rpt: erreur de copie, stash conservé"
        return 1
    fi
}



rscl() {
    rm -rf "/tmp/.stash_rsync"/*
}
