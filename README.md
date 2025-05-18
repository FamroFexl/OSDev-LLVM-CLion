# OSDev in Jetbrain's CLion with an LLVM Toolchain
This project implements the [OSDev](https://wiki.osdev.org) [Bare Bones](https://wiki.osdev.org/Bare_Bones) project using an LLVM toolchain. It uses clang as the compiler and LLD as the linker.

## Changes
- The linker script had to be modified in order to support the LLD linker, such as replacing  `BLOCK()` statements with `ALIGN()` statements (`BLOCK()` is an alias of `ALIGN()` in the LD linker anyways, see https://sourceware.org/binutils/docs-2.37/ld.pdf#page=96) The starting address also had to be more explicitly defined. If you want to use the LD linker instead, it is commented out in `CMakeLists.txt` 

## Using
The toolchain file should be automatically specified by the IDEA configuration. If not, manually specify it by adding `-DCMAKE_TOOLCHAIN_FILE=toolchain.cmake` to `Settings -> Build, Execution and Deployment -> CMake -> CMake Options:`
