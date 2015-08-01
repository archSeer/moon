# this one is important
SET(CMAKE_SYSTEM_NAME Windows)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

# specify the cross compiler
SET(CMAKE_C_COMPILER   /usr/bin/x86_64-mingw-w64-gcc)
SET(CMAKE_CXX_COMPILER /usr/bin/x86_64-mingw-w64-g++)

# where is the target environment
SET(CMAKE_FIND_ROOT_PATH  /usr/bin/x86_64-mingw-w64-gcc)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
