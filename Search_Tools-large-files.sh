#!/usr/bin/env bash
TARGET_PATH="$1"

if [ -d "$TARGET_PATH" ]; then
    TARGET_DIR="$TARGET_PATH"
else
    TARGET_DIR=$(dirname "$TARGET_PATH")
fi

SIZE=$(kdialog --title "Szukaj dużych plików" --inputbox "Minimalny rozmiar (np. 100M, 1G, 500k):" "100M")
if [ $? -ne 0 ] || [ -z "$SIZE" ]; then exit; fi

echo "Szukanie plików większych niż $SIZE w: $TARGET_DIR"
echo "-----------------------------------------------------"

# Używamy fd, bo jest czytelniejszy niż find
RESULTS=$(fd --size +"$SIZE" --exec ls -lh --color=always {} "$TARGET_DIR" 2>/dev/null)

if [ -z "$RESULTS" ]; then
    echo "Nie znaleziono plików większych niż $SIZE"
else
    echo "$RESULTS"
fi

echo "-----------------------------------------------------"
echo "Naciśnij dowolny klawisz, aby zamknąć..."
read -n 1
