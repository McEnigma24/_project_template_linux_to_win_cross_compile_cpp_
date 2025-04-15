#!/bin/bash
# Pełny skrypt do budowania aplikacji SFML i kopiowania wszystkich wymaganych DLL

# Sprawdzenie, czy SFML istnieje
if [ ! -d "external/SFML-2.5.1" ]; then
    echo "Nie znaleziono SFML. Uruchamiam skrypt konfiguracyjny SFML..."
    chmod +x setup_sfml.sh
    ./setup_sfml.sh
    
    if [ $? -ne 0 ]; then
        echo "Błąd podczas konfigurowania SFML. Kończę."
        exit 1
    fi
fi

# Tworzenie katalogu build
mkdir -p build
cd build

# Kompilacja simple_sfml.cpp
echo "Kompilacja simple_sfml.cpp..."
x86_64-w64-mingw32-g++ -c ../_src/simple_sfml.cpp -I../external/SFML-2.5.1/include

if [ $? -ne 0 ]; then
    echo "Błąd podczas kompilacji simple_sfml.cpp"
    exit 1
fi

echo "Linkowanie z bibliotekami dynamicznymi (DLL)..."
x86_64-w64-mingw32-g++ simple_sfml.o -o sfml_app.exe \
    -L../external/SFML-2.5.1/lib \
    -lsfml-window-2 -lsfml-system-2 \
    -lopengl32 -lwinmm -lgdi32 \
    -static-libgcc -static-libstdc++

if [ $? -ne 0 ]; then
    echo "Błąd podczas linkowania aplikacji"
    exit 1
fi

# Przygotuj katalog z aplikacją i DLL-kami
echo "Przygotowywanie katalogu do dystrybucji..."
mkdir -p dist

# Kopiowanie pliku wykonywalnego
cp sfml_app.exe dist/

# Kopiowanie DLL-ek SFML
cp ../external/SFML-2.5.1/bin/sfml-window-2.dll dist/
cp ../external/SFML-2.5.1/bin/sfml-system-2.dll dist/

# Znajdź i skopiuj wymagane systemowe DLL-ki MinGW
echo "Kopiowanie systemowych DLL-ek..."
# Znajdź katalog z DLL-kami MinGW
MINGW_PATH=$(dirname $(which x86_64-w64-mingw32-g++))/../x86_64-w64-mingw32/bin

# Kopiuj niezbędne pliki DLL
cp "${MINGW_PATH}/libgcc_s_seh-1.dll" dist/ 2>/dev/null || \
cp /usr/x86_64-w64-mingw32/bin/libgcc_s_seh-1.dll dist/ 2>/dev/null || \
cp /usr/lib/gcc/x86_64-w64-mingw32/*/libgcc_s_seh-1.dll dist/ 2>/dev/null || \
echo "Nie znaleziono libgcc_s_seh-1.dll - będziesz musiał dostarczyć go ręcznie"

cp "${MINGW_PATH}/libstdc++-6.dll" dist/ 2>/dev/null || \
cp /usr/x86_64-w64-mingw32/bin/libstdc++-6.dll dist/ 2>/dev/null || \
cp /usr/lib/gcc/x86_64-w64-mingw32/*/libstdc++-6.dll dist/ 2>/dev/null || \
echo "Nie znaleziono libstdc++-6.dll - będziesz musiał dostarczyć go ręcznie"

cp "${MINGW_PATH}/libwinpthread-1.dll" dist/ 2>/dev/null || \
cp /usr/x86_64-w64-mingw32/bin/libwinpthread-1.dll dist/ 2>/dev/null || \
echo "Nie znaleziono libwinpthread-1.dll - będziesz musiał dostarczyć go ręcznie"

# Sprawdź, czy wszystkie wymagane DLL zostały skopiowane
echo "Zawartość katalogu dystrybucji:"
ls -la dist/

echo "Kompilacja zakończona pomyślnie!"
echo "Pliki do dystrybucji znajdują się w katalogu: $(pwd)/dist/"
echo "Aby uruchomić aplikację na Windows, skopiuj wszystkie pliki z katalogu dist na maszynę docelową."

cd ..
