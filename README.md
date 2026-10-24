# dotfiles

Configuración de macOS con [GNU Stow](https://www.gnu.org/software/stow/) y Homebrew.

## Qué hay

| Paquete | Configura |
|---|---|
| `ghostty` | Terminal: abre herdr, fuente y atajos que deja pasar a herdr |
| `herdr` | Multiplexor: atajos con `cmd`, tema y avisos |
| `claude` | Perfiles `claude-work` y `claude-personal`, la statusline y el wrapper de `claude` para zsh |
| `zsh` | oh-my-zsh, PATH, alias y funciones (fragmentos en `~/.config/zsh/`) |
| `git` | Configuración global, aliases y gitignore global |
| `editorconfig` | Reglas de formato por defecto para todos los proyectos |
| `ngrok` | `tunnel [destino]`: túnel con tu dominio fijo de ngrok |

- `Brewfile`: lo que se instala con Homebrew.
- `macos.sh`: ajustes de macOS que no son archivos (`defaults write`).
- `install.sh`: lo instala todo, `macos.sh` incluido; se puede ejecutar varias veces.

## Instalar

```sh
git clone https://github.com/targess/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

Si un archivo de `~` choca con el repo, se aparta como `<archivo>.bak`. La primera vez pide tu nombre y email para git y los guarda en `~/.config/git/user`, fuera del repo.

## Pasos manuales

- **Cerrar sesión** tras el primer `install.sh`, para que se apliquen el teclado y el trackpad.
- **Ghostty**: darle permiso en *Privacidad y seguridad → Gestión de apps*, para que Homebrew pueda actualizar apps.
- **ngrok**: `ngrok config add-authtoken <token>` y crear `~/.config/zsh/local.zsh` (no se versiona):
  ```sh
  export NGROK_DOMAIN="tu-dominio.ngrok-free.app"
  export NGROK_UPSTREAM="host:puerto"   # destino de `tunnel` sin argumentos
  ```
  Uso: `tunnel` abre el túnel hacia `NGROK_UPSTREAM`; `tunnel localhost:3000` usa el mismo dominio hacia otro destino.
- **rvm y nvm**: con sus instaladores, usando sus opciones para no tocar los archivos de shell; si no, añaden líneas al `.zshrc`, que es un enlace al repo.
- **Spaces**: asignar cada app a su escritorio (clic derecho en el Dock → *Opciones → Asignar a*).

## Añadir un paquete

Cada directorio replica la ruta desde `~`:

```sh
mkdir -p ~/dotfiles/git
mv ~/.gitconfig ~/dotfiles/git/
~/dotfiles/install.sh
```
