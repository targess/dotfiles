# Crea una carpeta y entra en ella
function mkd() {
  mkdir -p "$@" && cd "$_"
}

# Entra en la carpeta abierta en el Finder
function cdf() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

# Tamaño de archivos o carpetas; sin argumentos, todo lo del directorio actual
function fs() {
  if [[ -n "$@" ]]; then
    du -sh -- "$@"
  else
    du -sh .[^.]* ./*
  fi
}

# dig con solo la respuesta, en formato legible. Tipo opcional: digga dominio MX (por defecto, A)
function digga() {
  dig +nocmd "$1" "${2:-A}" +multiline +noall +answer
}

# Nombres (CN y SAN) que cubre el certificado SSL de un dominio
function getcertnames() {
  if [ -z "$1" ]; then
    echo "Falta el dominio." >&2
    return 1
  fi

  local domain="$1" tmp cert
  tmp=$(echo -e "GET / HTTP/1.0\nEOT" | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1)
  if [[ "$tmp" != *"-----BEGIN CERTIFICATE-----"* ]]; then
    echo "No se encontró el certificado." >&2
    return 1
  fi

  cert=$(echo "$tmp" | openssl x509 -text -certopt "no_aux,no_header,no_issuer,no_pubkey,no_serial,no_sigdump,no_signame,no_validity,no_version")
  echo "Common Name:"
  echo "$cert" | grep "Subject:" | sed -e "s/^.*CN *= *//"
  echo ""
  echo "Subject Alternative Names:"
  echo "$cert" | grep -A 1 "Subject Alternative Name:" | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
}

# Abre en el Finder la carpeta actual o la ruta indicada
function o() {
  open "${@:-.}"
}
