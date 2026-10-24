# Cheatsheet

`prefix` = `ctrl+b`: se pulsa, se suelta y luego la tecla. `alt` = Option izquierdo.

## herdr

**Pestañas**

| Acción | Atajo |
|---|---|
| Nueva | `cmd+t` · `prefix+c` |
| Siguiente / anterior | `ctrl+tab` / `ctrl+shift+tab` · `prefix+n` / `prefix+p` |
| Ir a la 1–9 | `alt+1..9` · `prefix+1..9` |
| Renombrar | `prefix+shift+t` |
| Cerrar | `prefix+shift+x` |

**Panes**

| Acción | Atajo |
|---|---|
| Dividir a la derecha / abajo | `cmd+d` / `cmd+shift+d` · `prefix+v` / `prefix+minus` |
| Mover el foco | `cmd+alt+←↓↑→` · `cmd+alt+h/j/k/l` · `prefix+h/j/k/l` |
| Zoom (ocupa toda la pestaña) | `cmd+shift+enter` · `prefix+z` |
| Limpiar pantalla | `cmd+k` · `prefix+ctrl+k` |
| Cerrar | `cmd+w` · `prefix+x` |
| Modo copia / scrollback en el editor | `prefix+[` / `prefix+e` |

**Workspaces y general**

| Acción | Atajo |
|---|---|
| Ir al 1–9 | `cmd+1..9` |
| Lista de workspaces | `prefix+w` |
| Goto: todos los agentes y terminales (`/` busca; `b` `w` `i` `d` filtran, `a` todo) | `cmd+g` · `prefix+g` |
| Nuevo / renombrar / cerrar workspace | `prefix+shift+n` / `prefix+shift+w` / `prefix+shift+d` |
| Barra lateral | `prefix+b` |
| Ver todos los atajos | `prefix+?` |
| Salir dejando todo corriendo | `prefix+q` |

## Ghostty

| Acción | Atajo |
|---|---|
| Recargar la configuración | Menú *Ghostty → Reload Configuration* |
| Letra más grande / pequeña / normal | `cmd++` / `cmd+-` / `cmd+0` |
| Escribir `@ # \| [ ] { } \ ~` | Option derecho |

## macOS

| Acción | Atajo |
|---|---|
| Ir al Space 1–6 | `ctrl+1..6` |
| Space anterior / siguiente | `ctrl+←` / `ctrl+→` |
| Mission Control / ventanas de la app | `ctrl+↑` / `ctrl+↓` |
| Bloquear la pantalla | `cmd+ctrl+q` |
| Archivos ocultos en el Finder | `cmd+shift+.` |
| Captura de zona / de ventana | `cmd+shift+4` / `cmd+shift+4` y `espacio` (van a `~/Pictures/Screenshots`) |

## zsh

**fzf**

| Atajo | Qué hace |
|---|---|
| `ctrl+r` | Busca en el historial con trozos sueltos (`dock comp up`) |
| `ctrl+t` | Busca un archivo y pega su ruta |
| `alt+c` | Busca una subcarpeta y entra |
| Escribir parte de un comando + `↑` / `↓` | Recorre los comandos anteriores que lo contienen |

**Historial y listados**

| Comando | Qué hace |
|---|---|
| `h` · `hs texto` · `hsi texto` | Historial · buscar · buscar sin distinguir mayúsculas |
| `l` · `la` · `ll` | `ls -lah` · `ls -lAh` · `ls -lh` |

**Propios**

| Comando | Qué hace |
|---|---|
| `mkd carpeta` | Crea la carpeta y entra |
| `cdf` · `o [ruta]` | Ir a la carpeta del Finder · abrir en el Finder |
| `downloads` · `desktop` · `projects` | `cd` a esas carpetas |
| `fs [ruta]` | Tamaño de archivos o carpetas |
| `digga dominio [tipo]` | Consulta DNS limpia (A por defecto) |
| `getcertnames dominio` | Nombres que cubre su certificado SSL |
| `cleanup` | Borra los `.DS_Store` hacia abajo |
| `emptytrash` | Vacía la papelera |
| `afk` | Apaga la pantalla (y bloquea) |
| `tunnel [destino]` | Túnel de ngrok con tu dominio fijo |
| `claude-work` · `claude-personal` | Claude Code con cada perfil |

## git

**oh-my-zsh** (`g` = `git`)

| Alias | Comando |
|---|---|
| `gst` · `g s` | Status · status corto |
| `ga` · `gaa` | Add · add de todo |
| `gc` · `gcmsg "msg"` | Commit con diff · commit con mensaje |
| `gsw rama` · `gswc rama` | Cambiar de rama · crearla y cambiar |
| `gco` · `gb` · `gd` | Checkout · branch · diff |
| `gl` · `gp` | Pull · push |
| `glog` | Log en una línea con gráfico |
| `grb` · `grbi` | Rebase · rebase interactivo |
| `gstp` · `gcp` | Stash pop · cherry-pick |

**Propios** (`git ...`)

| Alias | Qué hace |
|---|---|
| `amend` | Añade lo preparado al último commit, mismo mensaje |
| `dm` | Borra las ramas locales ya mergeadas (salvo main, master y staging) |
| `fb sha` · `ft sha` | Ramas · tags que contienen un commit |
| `fc texto` · `fm texto` | Commits que tocan ese texto en el código · en el mensaje |
| `aliases` | Lista los aliases |

**lazygit** (`cmd+shift+g` lo abre flotando sobre el repo del pane activo)

| Tecla | Qué hace |
|---|---|
| `?` · `q` | Atajos del panel actual · salir |
| `espacio` · `a` | Preparar o quitar el archivo · prepararlo todo |
| `Enter` y luego `espacio` | Entrar en el archivo y preparar solo esas líneas (`a` cambia entre fragmentos y líneas) |
| `c` · `A` | Commit · añadir al último commit |
| `p` · `P` | Pull · push |
| `s` · `d` | Guardar en stash · descartar cambios |
| `z` | Deshacer |

En el panel de commits:

| Tecla | Qué hace |
|---|---|
| `i` · `e` | Rebase interactivo · editar ese commit |
| `s` · `f` · `d` | Squash · fixup · drop |
| `ctrl+j` / `ctrl+k` | Mover el commit abajo / arriba |
| `C` · `V` | Copiar commit · pegarlo (cherry-pick) |

## mise

| Comando | Qué hace |
|---|---|
| (automático) | Cambia de Ruby y Node al entrar en cada carpeta, según `.ruby-version` o `.nvmrc` |
| `mise ls` | Versiones instaladas y cuál se usa |
| `mise install` | Instala lo que pide la carpeta actual |
| `mise use ruby@3.4` · `mise use -g node@lts` | Fija la versión en el proyecto · globalmente |

## Claude Code

| Acción | Atajo |
|---|---|
| Cambiar de modo de pantalla | `/tui fullscreen` · `/tui default` |
| Buscar en la conversación (fullscreen) | `ctrl+o` y luego `/` |
| Volcar la conversación al scrollback (fullscreen) | `ctrl+o` y luego `[` |
| Vaciar la vista sin perder la conversación | `/clear` y luego `/resume` |
