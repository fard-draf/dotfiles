# Copie dans le buffer 
rsc() {
    local target="$1"
    [ -z "$target" ] && echo "Usage: ryk <file|dir>" && return 1

    mkdir -p "/tmp/.stash_rsync"
    rm -rf "/tmp/.stash_rsync"/*

    rsync -a "$target" "/tmp/.stash_rsync/"
}

# Colle du buffer vers le dossier actuel et supprime le buffer
rsp() {
    local dest="$1"
    [ -z "$dest" ] && echo "Usage: rpt <destination>" && return 1

    # récupérer ce qu'il y a dans le stash (1 seul élément attendu)
    local src
    src="$(find "/tmp/.stash_rsync" -mindepth 1 -maxdepth 1)"
    if [ -z "$src" ]; then
        echo "rpt: stash vide"
        return 1
    fi

    if [ -d "$dest" ]; then
        # destination = dossier existant → on colle dedans
        if rsync -a "/tmp/.stash_rsync/" "$dest/"; then
            rm -rf "/tmp/.stash_rsync"/*
        else
            echo "Erreur lors du collage, stash conservé."
            return 1
        fi
    else
        # destination n'existe pas → on décide selon src
        if [ -d "$src" ]; then
            # src = dossier → on crée un dossier dest/ et on copie dedans
            if rsync -a "$src"/ "$dest"/; then
                rm -rf "/tmp/.stash_rsync"/*
            else
                echo "Erreur lors du collage, stash conservé."
                return 1
            fi
        else
            # src = fichier → on recopie sous le nom dest (comme cp src dest)
            if rsync -a "$src" "$dest"; then
                rm -rf "/tmp/.stash_rsync"/*
            else
                echo "Erreur lors du collage, stash conservé."
                return 1
            fi
        fi
    fi
}

rcl() {
    rm -rf "/tmp/.stash_rsync"/*
}
