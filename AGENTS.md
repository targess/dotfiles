# dotfiles

Configuración personal de macOS, gestionada con GNU Stow y un `Brewfile`. Instalación y alta de paquetes: ver `README.md`.

## Repo

- Un paquete Stow por herramienta. `install.sh` debe poder ejecutarse varias veces sin efectos nuevos.
- Los ajustes de macOS que no son archivos (`defaults write`) van en `macos.sh`.
- Comentarios en español dentro de los archivos.

## Seguridad

- Nunca secretos, tokens, claves, historiales ni logs.
- No borrar ni sobrescribir nada en `~` sin preguntar. Antes de pisar un archivo, copia `.bak`.

## Git

- Conventional Commits en inglés: imperativo, minúscula y sin punto final. El scope es el paquete (`feat(herdr): ...`).
- Push y repos en GitHub, siempre con OK explícito.
