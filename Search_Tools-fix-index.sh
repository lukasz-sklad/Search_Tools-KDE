#!/usr/bin/env bash
TARGET_PATH="$1"

if [ -d "$TARGET_PATH" ]; then
    TARGET_DIR="$TARGET_PATH"
else
    TARGET_DIR=$(dirname "$TARGET_PATH")
fi

echo "Naprawa indeksowania dla: $TARGET_DIR"
echo "-----------------------------------------------------"

echo "[1/2] Wymuszam indeksowanie plików w tym folderze..."
balooctl6 index "$TARGET_DIR"

echo "[2/2] Pobieram aktualny status..."
# Używamy timeout, żeby status nie zawiesił konsoli na wieki
timeout 10s balooctl6 status || echo "Błąd: Nie udało się pobrać statusu (Baloo może być zajęte)."

echo "-----------------------------------------------------"
echo "FOLDER POWINIEN BYĆ JUŻ W KOLEJCE DO INDEKSOWANIA."
echo ""
echo "Jeśli chcesz wymusić pełne sprawdzenie całego systemu"
echo "(może to potrwać długo przy Twoich 2.8 mln plików!),"
echo "możesz to zrobić ręcznie komendą: balooctl6 check"
echo "-----------------------------------------------------"
echo "Naciśnij dowolny klawisz, aby zamknąć..."
read -n 1
