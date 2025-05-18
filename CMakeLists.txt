cmake_minimum_required(VERSION 3.15)
project(BaseOS)

## Setup cross-compilation
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR i686)

ENABLE_LANGUAGE(ASM)

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_ASM_COMPILER clang)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_FLAGS "--target=i686-pc-none-elf -ffreestanding -fno-exceptions -fno-stack-protector -fno-rtti -fno-pie -Og")
set(CMAKE_C_FLAGS "--target=i686-pc-none-elf -ffreestanding -fno-stack-protector -fno-pie -Og")
set(CMAKE_ASM_FLAGS "--target=i686-pc-none-elf")
#Multiboot2 64-bit architecture support plan
#arm64-pc-none-elf, x86_64-pc-none-elf, riscv64-pc-none-elf -mno-red-zone

set(KERNEL_BIN ${CMAKE_PROJECT_NAME}.bin)
set(KERNEL_ISO ${CMAKE_PROJECT_NAME}.iso)

#Set the location for the linker file
set(LINKER "src/kernel/arch/x86/linker.ld")

#Config to generate BaseOS.bin
add_executable(${KERNEL_BIN} src/kernel/arch/x86/boot.s src/kernel/init/kernel.c)

#Set linker flags using LLD
set_target_properties(${KERNEL_BIN} PROPERTIES LINK_FLAGS "-v -fuse-ld=lld -Wl,-T,${CMAKE_SOURCE_DIR}/${LINKER} -fno-pie -ffreestanding -nostdlib -Wl,-z,notext -static")

#Use LD instead of LLD as the linker (can use the basic linker script)
#set_target_properties(${KERNEL_BIN} PROPERTIES LINK_FLAGS "-v -T ${CMAKE_SOURCE_DIR}/${LINKER} -ffreestanding -fno-pie -nostdlib -z notext")

target_include_directories(${KERNEL_BIN} PUBLIC include PRIVATE src)

#Copy BaseOS.bin output to /bin
add_custom_command(TARGET ${KERNEL_BIN} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_SOURCE_DIR}/bin
        COMMAND ${CMAKE_COMMAND} -E copy ${KERNEL_BIN} ${CMAKE_SOURCE_DIR}/bin/)

#Config to generate BaseOS.iso
add_custom_target(${KERNEL_ISO}
        DEPENDS ${KERNEL_BIN}
        COMMAND ${CMAKE_SOURCE_DIR}/generate-iso.sh ${KERNEL_BIN})

#Copy BaseOS.iso output to /bin
add_custom_command(TARGET ${KERNEL_ISO} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_SOURCE_DIR}/bin
        COMMAND ${CMAKE_COMMAND} -E copy ${KERNEL_ISO} ${CMAKE_SOURCE_DIR}/bin/)