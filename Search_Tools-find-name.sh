#!/usr/bin/env bash
TARGET_PATH="$1"

if [ -d "$TARGET_PATH" ]; then
    TARGET_DIR="$TARGET_PATH"
else
    TARGET_DIR=$(dirname "$TARGET_PATH")
fi

PATTERN=$(kdialog --title "Szukaj pliku po nazwie" --inputbox "Wpisz nazwę pliku (np. *877324*):" "*")
if [ $? -ne 0 ] || [ -z "$PATTERN" ]; then exit; fi

echo "Wyniki wyszukiwania w: $TARGET_DIR"
echo "-----------------------------------------------------"

# Pobieramy wyniki do tablicy (używamy mapfile, żeby obsłużyć spacje w nazwach)
mapfile -t RESULTS < <(fd --color never "$PATTERN" "$TARGET_DIR")

if [ ${#RESULTS[@]} -eq 0 ]; then
    echo "Nie znaleziono żadnych plików."
    echo "-----------------------------------------------------"
    echo "Naciśnij dowolny klawisz, aby zamknąć..."
    read -n 1
    exit
fi

# Wyświetlamy znalezione pliki
for i in "${!RESULTS[@]}"; do
    printf "[%d] %s\n" "$((i+1))" "${RESULTS[$i]}"
done

echo "-----------------------------------------------------"

# Pytamy użytkownika o akcję
CHOICE=$(kdialog --title "Co chcesz zrobić ze znalezionymi plikami?" \
    --menu "Wybierz akcję:" \
    "close" "Zamknij" \
    "auto" "Auto-zmiana nazw (terg-1, terg-2...)" \
    "edit" "Edytuj nazwy ręcznie (nano/vidir)")

case $CHOICE in
    "auto")
        echo "Rozpoczynam automatyczną zmianę nazw..."
        count=1
        for file in "${RESULTS[@]}"; do
            ext="${file##*.}"
            dir=$(dirname "$file")
            new_name="$dir/terg-$count.$ext"
            
            # Sprawdzanie czy plik docelowy istnieje, żeby nie nadpisać
            while [ -f "$new_name" ]; do
                ((count++))
                new_name="$dir/terg-$count.$ext"
            done
            
            mv -v "$file" "$new_name"
            ((count++))
        done
        echo "-----------------------------------------------------"
        echo "Zakończono! Naciśnij dowolny klawisz..."
        read -n 1
        ;;
    "edit")
        echo "Otwieram edytor nazw (vidir + nano)..."
        echo "Wskazówka: Zmień tekst po prawej stronie od numerów i zapisz plik (Ctrl+O, Enter, Ctrl+X)."
        # Przekazujemy listę plików do vidir, wymuszając nano jako edytor
        printf "%s\n" "${RESULTS[@]}" | EDITOR=nano vidir -
        echo "-----------------------------------------------------"
        echo "Zmiany zostały zapisane (jeśli edytowałeś). Naciśnij dowolny klawisz..."
        read -n 1
        ;;
    *)
        exit
        ;;
esac
