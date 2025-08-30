# ======= OPTIMISATION DU PATH =======
# Fonction pour éviter les doublons dans le PATH
function path_append() {
  if [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$PATH:$1"
  fi
}

function path_prepend() {
  if [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# ======= FONCTIONS UTILES =======
# Créer et cd dans un répertoire
mdcd() {
  mkdir -p "$1" && cd "$1"
}

# Backup d'un fichier
bup() {
  cp -a "$1" "${1}_$(date +%Y%m%d_%H%M%S).bup"
}

# Extraire n'importe quelle archive
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' ne peut pas être extrait via extract()" ;;
    esac
  else
    echo "'$1' n'est pas un fichier valide"
  fi
}

# Recherche de fichiers récursive
ff() { find . -type f -name "*$1*" -ls; }

# Recherche de texte récursive
ft() { find . -type f -exec grep -l -s "$1" {} \; | xargs grep -i --color "$1"; }

# Affiche les alias d'un fichier de configuration sourceable
function show_aliases_from_file() {
  if [[ -f "$1" ]]; then
    grep --color=never -E "^\s*alias" "$1"
  else
    echo "Fichier non trouvé : $1"
  fi
}

