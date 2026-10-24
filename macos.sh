#!/usr/bin/env bash
# Preferencias de macOS que no caben en un paquete Stow. Se puede ejecutar varias veces.
set -euo pipefail

# Ghostty: saca «Hide Others» de cmd+alt+h para que herdr lo use para ir al pane de la izquierda.
defaults write com.mitchellh.ghostty NSUserKeyEquivalents -dict-add "Hide Others" '@^~$h'

# Finder: extensiones siempre visibles, barras de ruta y de estado, carpetas primero y vista de lista
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Sin .DS_Store en unidades de red ni USB
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Dock: se oculta solo, sin retardo ni animación, y sin apps recientes
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock show-recents -bool false

# Spaces: mantienen su orden en vez de reordenarse según el uso
defaults write com.apple.dock mru-spaces -bool false

# Spaces: ctrl+1..6 salta al Space de ese número (ids 118-123 de los atajos del sistema)
keycodes=(18 19 20 21 23 22)
for i in 0 1 2 3 4 5; do
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add $((118 + i)) \
    "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>${keycodes[$i]}</integer><integer>262144</integer></array><key>type</key><string>standard</string></dict></dict>"
done
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u 2>/dev/null || true

# Teclado: repetición de teclas rápida y con poca espera (se aplica al volver a iniciar sesión)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Trackpad: tocar para hacer clic (se aplica al volver a iniciar sesión)
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Capturas en ~/Pictures/Screenshots y sin sombra en las de ventana
screenshots="$HOME/Pictures/Screenshots"
mkdir -p "$screenshots"
defaults write com.apple.screencapture location -string "$screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

# La carpeta de capturas, a mano en el Dock y ordenada por fecha
if ! defaults read com.apple.dock persistent-others 2>/dev/null | grep -q "file://$screenshots/"; then
  defaults write com.apple.dock persistent-others -array-add "<dict>
    <key>tile-data</key><dict>
      <key>file-data</key><dict>
        <key>_CFURLString</key><string>file://$screenshots/</string>
        <key>_CFURLStringType</key><integer>15</integer>
      </dict>
      <key>arrangement</key><integer>2</integer>
      <key>showas</key><integer>2</integer>
    </dict>
    <key>tile-type</key><string>directory-tile</string>
  </dict>"
fi

# Diálogos de guardar e imprimir desplegados, y guardar en el disco en vez de en iCloud
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# TextEdit: documentos nuevos en texto plano y UTF-8
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Chrome: sin el gesto de atrás y adelante al hacer scroll lateral
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false

# Time Machine: no ofrece cada disco nuevo como copia de seguridad
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Fotos: no se abre sola al conectar un dispositivo
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Pide la contraseña en cuanto se apaga la pantalla. Necesita tu contraseña de usuario
if ! sysadminctl -screenLock status 2>&1 | grep -q immediate; then
  sysadminctl -screenLock immediate -password -
fi

killall Finder Dock SystemUIServer 2>/dev/null || true
