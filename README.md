# Search Tools KDE

Zestaw skryptów integrujących zaawansowane narzędzia wyszukiwania (`fd`, `ripgrep`) bezpośrednio z menu kontekstowym środowiska KDE Plasma. Pozwala na szybkie wyszukiwanie plików po nazwie, treści, rozmiarze oraz naprawę indeksowania Baloo.

## Funkcje
- **Szukaj plików po nazwie**: Szybkie znajdowanie plików z możliwością masowej zmiany nazw.
- **Szukaj tekstu w plikach**: Wykorzystuje błyskawiczny `ripgrep` do przeszukiwania zawartości.
- **Szukaj dużych plików**: Pozwala łatwo zlokalizować pliki przekraczające zadany rozmiar.
- **Napraw wyszukiwanie**: Wymusza indeksowanie wybranego folderu przez system Baloo.

## Instalacja

1. Upewnij się, że masz zainstalowane wymagane pakiety (szczegóły poniżej).
2. Uruchom skrypt instalacyjny:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

### Wymagane zależności
Aby skrypty działały poprawnie, zainstaluj:
- `fd-find` (polecenie `fd`)
- `ripgrep` (polecenie `rg`)
- `kdialog` (standard w KDE)
- **coreutils ✔** (narzędzia systemowe, np. zainstalowane przez Homebrew, APT)

---

## Ważne: Pakiet Coreutils

Projekt opiera się na standardowych poleceniach systemowych. Warto znać różnicę między dostępnymi implementacjami:

### 1. coreutils ✔
To pakiet od projektu GNU. Na systemach takich jak **Debian**, **SteamOS**, **macOS** po zainstalowaniu, to tutaj właśnie znajduje się polecenie **`vdir`**. Jest to najbardziej sprawdzona implementacja, na której bazują te skrypty.

### 2. uutils-coreutils
To nowoczesna re-implementacja `coreutils` napisana w języku **Rust**. Choć dąży do pełnej kompatybilności, w specyficznych zastosowaniach parametry mogą się różnić od klasycznego wydania GNU.

> [!TIP]
> **Ciekawostka o przedrostku "g":**
> Instalując narzędzia GNU przez Homebrew (szczegóły szczególnie istotne na macOS lub przy specyficznej konfiguracji na SteamOS), możesz zauważyć, że polecenia mają przedrostek **g** (np. `gcp`, `gmv`, `gvdir`). Homebrew robi to domyślnie, aby nie kolidować z natywnymi narzędziami systemu.

---

## Użytkowanie
Po instalacji, kliknij prawym przyciskiem myszy na dowolny folder w menedżerze plików Dolphin. W menu **"Narzędzia wyszukiwania"** znajdziesz wszystkie dostępne akcje.
