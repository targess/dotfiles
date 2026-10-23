# Atajos a carpetas
alias downloads="cd ~/Downloads"
alias desktop="cd ~/Desktop"
alias projects="cd ~/Projects"

# Borra los .DS_Store del directorio actual hacia abajo
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Vacía la papelera, como hacerlo desde el Finder
alias emptytrash="osascript -e 'tell application \"Finder\" to empty trash'"

# Apaga la pantalla, que se bloquea si macOS pide contraseña al despertar
alias afk="pmset displaysleepnow"
