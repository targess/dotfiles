# Obliga a elegir perfil: claude-work o claude-personal
function claude() {
  if [[ -z "$CLAUDE_CONFIG_DIR" ]]; then
    # herdr restaura las sesiones con `claude --resume <id>` a secas: deduce el perfil por la conversación
    local id="" prev="" arg dir
    for arg in "$@"; do
      [[ "$prev" == (--resume|-r) ]] && { id="$arg"; break; }
      prev="$arg"
    done
    if [[ -n "$id" ]]; then
      for dir in ~/.claude-work ~/.claude-personal; do
        local -a hits=($dir/projects/*/$id.jsonl(N))
        if (( $#hits )); then
          CLAUDE_CONFIG_DIR=$dir command claude "$@"
          return
        fi
      done
    fi
    echo "Usa 'claude-work' o 'claude-personal' en lugar de 'claude' a secas." >&2
    return 1
  fi
  command claude "$@"
}

alias claude-work='CLAUDE_CONFIG_DIR=~/.claude-work claude'
alias claude-personal='CLAUDE_CONFIG_DIR=~/.claude-personal claude'
