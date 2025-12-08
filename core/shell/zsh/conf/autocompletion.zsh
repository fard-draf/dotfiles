# options simples mais efficaces
setopt auto_menu          # après quelques caractères, menu
setopt menu_complete      # Tab fait défiler les choix
setopt complete_in_word   # complète au milieu du mot
setopt auto_list          # liste quand plusieurs choix
setopt list_types         # suffixes /, * etc.

# un peu de souplesse sur la recherche
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Za-z}' \
  'r:|[._-]=* r:|=*'

# Utiliser les mêmes couleurs que `ls` pour garder la cohérence visuelle
if [[ -n "${LS_COLORS:-}" ]]; then
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
else
  zstyle ':completion:*' list-colors "di=34:fi=0:ex=31"
fi
