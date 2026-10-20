# Homebrew en el PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# OrbStack: añade sus comandos (docker, orb) y su autocompletado; no arranca la app
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
