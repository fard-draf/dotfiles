# Configuration Yarn Berry pour l'environnement de développement

# Alias Yarn Berry
alias yi='yarn install'
alias ya='yarn add'
alias yad='yarn add -D'
alias yr='yarn remove'
alias yu='yarn up'
alias ydlx='yarn dlx'
alias yw='yarn workspace'
alias yws='yarn workspaces'
alias yt='yarn test'
alias yb='yarn build'
alias yd='yarn dev'
alias ys='yarn start'

# Fonction pour afficher les infos Yarn
yarn-info() {
    echo "=== Configuration Yarn Berry ==="
    echo "Version: $(yarn --version)"
    echo "YARN_HOME: $YARN_HOME"
    echo "Cache: $(yarn config get cacheFolder)"
    echo "Global: $(yarn config get globalFolder)"
    echo "NodeLinker: $(yarn config get nodeLinker)"
    echo "================================"
}

yarn-al() {
    
    echo "alias yi='yarn install'"
    echo "alias ya='yarn add'"
    echo "alias yad='yarn add -D'"
    echo "alias yr='yarn remove'"
    echo "alias yu='yarn up'"
    echo "alias ydlx='yarn dlx'"
    echo "alias yw='yarn workspace'"
    echo "alias yws='yarn workspaces'"
    echo "alias yt='yarn test'"
    echo "alias yb='yarn build'"
    echo "alias yd='yarn dev'"
    echo "alias ys='yarn start'"
}
