# Określenie systemu docelowego
set(CMAKE_SYSTEM_NAME Windows)

# Określenie kompilatora dla C i C++
set(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)
set(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)

# Określenie gdzie szukać bibliotek i programów
set(CMAKE_FIND_ROOT_PATH /usr/x86_64-w64-mingw32)

# Dostosowanie zachowania find_*
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)