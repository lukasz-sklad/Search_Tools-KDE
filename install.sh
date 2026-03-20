#!/usr/bin/env bash

# Ustalenie katalogów
INSTALL_BIN="$HOME/.local/bin"
INSTALL_MENU="$HOME/.local/share/kio/servicemenus"
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Instalacja Narzędzi Wyszukiwania ..."

# Tworzenie katalogów jeśli nie istnieją
mkdir -p "$INSTALL_BIN"
mkdir -p "$INSTALL_MENU"

# Kopiowanie skryptów
echo "Kopiowanie skryptów do $INSTALL_BIN ..."
cp "$SOURCE_DIR/Search_Tools-find-name.sh" "$INSTALL_BIN/"
cp "$SOURCE_DIR/Search_Tools-grep-content.sh" "$INSTALL_BIN/"
cp "$SOURCE_DIR/Search_Tools-large-files.sh" "$INSTALL_BIN/"
cp "$SOURCE_DIR/Search_Tools-fix-index.sh" "$INSTALL_BIN/"

# Nadawanie uprawnień wykonywania
chmod +x "$INSTALL_BIN/Search_Tools-find-name.sh"
chmod +x "$INSTALL_BIN/Search_Tools-grep-content.sh"
chmod +x "$INSTALL_BIN/Search_Tools-large-files.sh"
chmod +x "$INSTALL_BIN/Search_Tools-fix-index.sh"

# Przygotowanie i kopiowanie menu kontekstowego
echo "Konfiguracja menu kontekstowego..."
MENU_FILE="$SOURCE_DIR/Search-Tools_servicemenu.desktop"
TARGET_MENU="$INSTALL_MENU/Search-Tools_servicemenu.desktop"

cp "$MENU_FILE" "$TARGET_MENU"

# Podmiana ścieżki w pliku .desktop na właściwą ścieżkę instalacji
sed -i "s|PLACEHOLDER_PATH|$INSTALL_BIN|g" "$TARGET_MENU"

echo "Odświeżanie konfiguracji KDE..."
if command -v kbuildsycoca5 &> /dev/null; then
    kbuildsycoca5 > /dev/null 2>&1
elif command -v kbuildsycoca6 &> /dev/null; then
    kbuildsycoca6 > /dev/null 2>&1
fi

echo "-----------------------------------------------------"
echo "Zakończono sukcesem!"
echo "Narzędzia są dostępne w menu kontekstowym (Prawy Przycisk Myszy na folderze) jako 'Narzędzia wyszukiwania'."
echo "-----------------------------------------------------"
