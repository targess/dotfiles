#!/usr/bin/env bash
# Instalación idempotente: Homebrew, Brewfile y un paquete Stow por cada directorio de primer nivel.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
for prefix in /opt/homebrew /usr/local; do
  if [ -x "$prefix/bin/brew" ]; then
    eval "$("$prefix/bin/brew" shellenv)"
    break
  fi
done

# Si una app ya estaba instalada a mano, Homebrew no la pisa y falla: se avisa y se sigue
if ! brew bundle --file="$DOTFILES_DIR/Brewfile"; then
  echo "Aviso: algunas dependencias del Brewfile no se instalaron; revisa la salida de brew bundle." >&2
fi

# oh-my-zsh, sin que su instalador toque el .zshrc ni cambie de shell
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Aparta como <archivo>.bak cualquier archivo real con el que Stow chocaría (con fecha si ya existe).
backup_conflicts() {
  local pkg_dir="$1" src rel target backup
  while IFS= read -r src; do
    rel="${src#"$pkg_dir"/}"
    target="$HOME/$rel"
    if [ ! -e "$target" ] && [ ! -L "$target" ]; then
      continue
    fi
    if [ "$(realpath "$target" 2>/dev/null)" = "$(realpath "$src")" ]; then
      continue
    fi

    backup="$target.bak"
    [ -e "$backup" ] && backup="$target.$(date +%Y%m%d%H%M%S).bak"
    mv "$target" "$backup"
    echo "Backed up $target -> $backup"
  done < <(find "$pkg_dir" \( -type f -o -type l \) ! -name .DS_Store)
}

for pkg_dir in "$DOTFILES_DIR"/*/; do
  pkg_dir="${pkg_dir%/}"
  pkg="$(basename "$pkg_dir")"
  backup_conflicts "$pkg_dir"
  # --no-folding enlaza archivos y no directorios, para que las apps no escriban sus ficheros de ejecución en el repo.
  stow --no-folding --restow --dir="$DOTFILES_DIR" --target="$HOME" "$pkg"
  echo "Stowed $pkg"
done

# Identidad de git: se pide una vez y se guarda fuera del repo
if [ ! -e "$HOME/.config/git/user" ]; then
  read -rp "Nombre para git: " git_name
  read -rp "Email para git: " git_email
  mkdir -p "$HOME/.config/git"
  printf '[user]\n\tname = %s\n\temail = %s\n' "$git_name" "$git_email" > "$HOME/.config/git/user"
fi

"$DOTFILES_DIR/macos.sh"

# El script del hook de Claude lo gestiona herdr: se instala en cada perfil en vez de versionarlo.
for claude_dir in "$HOME/.claude-work" "$HOME/.claude-personal"; do
  CLAUDE_CONFIG_DIR="$claude_dir" herdr integration install claude
done
