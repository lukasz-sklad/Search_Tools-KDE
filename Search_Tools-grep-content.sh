#!/usr/bin/env bash
TARGET_PATH="$1"

if [ -d "$TARGET_PATH" ]; then
    TARGET_DIR="$TARGET_PATH"
else
    TARGET_DIR=$(dirname "$TARGET_PATH")
fi

QUERY=$(kdialog --title "Szukaj tekstu w plikach" --inputbox "Wpisz szukaną frazę (tekst):")
if [ $? -ne 0 ] || [ -z "$QUERY" ]; then exit; fi

echo "Szukanie treści: '$QUERY' w katalogu: $TARGET_DIR"
echo "-----------------------------------------------------"

# Uruchomienie rg z kolorowaniem i pokazywaniem numeru linii
RESULTS=$(rg --color always --line-number --heading --column "$QUERY" "$TARGET_DIR" 2>&1)

if [ -z "$RESULTS" ]; then
    echo "Nie znaleziono frazy: '$QUERY'"
else
    echo "$RESULTS"
fi

echo "-----------------------------------------------------"
echo "Naciśnij dowolny klawisz, aby zamknąć..."
read -n 1
