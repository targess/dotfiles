# Túnel con tu dominio fijo de ngrok hacia el destino indicado, o hacia NGROK_UPSTREAM.
# NGROK_DOMAIN y NGROK_UPSTREAM se definen en ~/.config/zsh/local.zsh, que no se versiona
function tunnel() {
  if [[ -z "$NGROK_DOMAIN" ]]; then
    echo "Falta NGROK_DOMAIN en ~/.config/zsh/local.zsh" >&2
    return 1
  fi

  ngrok http "${1:-$NGROK_UPSTREAM}" --url "https://$NGROK_DOMAIN"
}
