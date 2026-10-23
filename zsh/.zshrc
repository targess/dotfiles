# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="cobalt2"
plugins=(
  git
  history
  history-substring-search
)
source $ZSH/oh-my-zsh.sh

# Permite escribir [ y ] sin comillas (por ejemplo, en tareas de rake)
unsetopt nomatch

# Fragmentos de shell que aportan otros paquetes (por ejemplo, claude)
for file in ~/.config/zsh/*.zsh(N); do
  source "$file"
done
unset file

# Node: nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# Cliente de Postgres (psql, pg_dump) sin el servidor
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Binarios instalados en el usuario, como claude
export PATH="$HOME/.local/bin:$PATH"

# mermaid-cli usa el Chrome instalado en lugar de descargar otro navegador
export PUPPETEER_EXECUTABLE_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# Ruby: rvm. Tiene que ser el último cambio del PATH
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

# Resaltado de sintaxis mientras escribes. Va al final, como pide el plugin
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
