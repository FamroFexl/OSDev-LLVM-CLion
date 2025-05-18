# the name of the target operating system
set(CMAKE_SYSTEM_NAME Generic)

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

# which compilers to use for C and C++
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_AR llvm-ar)
set(CMAKE_LINKER ld.lld)
set(CMAKE_NM llvm-nm)
set(CMAKE_OBJDUMP llvm-objdump)
set(CMAKE_RANLIB llvm-ranlib)

# where is the target environment located
#set(CMAKE_FIND_ROOT_PATH TOOLS)

# adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
