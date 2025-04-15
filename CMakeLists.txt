cmake_minimum_required(VERSION 3.10)
project(win_app)

# Określenie standardu C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(windows-toolchain.cmake)

# Pliki źródłowe
set(SOURCE_FILES _src/main.cpp)

# Tworzenie pliku wykonywalnego
add_executable(win_app ${SOURCE_FILES})

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static-libgcc -static-libstdc++")
    
# Odkomentuj poniższą linię, jeśli chcesz aplikację bez konsoli
# set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -mwindows")
