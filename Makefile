all: assemble_bootloader compile_kernel concat

CC = clang
ASM = nasm

concat:
	cat "bin/boot.bin" "bin/full_kernel.bin" "bin/zeroes.bin"  > "bin/OS.bin"

assemble_bootloader:
	nasm -f bin "src/boot.asm" -o "bin/boot.bin"

run_qemu:
	qemu-system-x86_64 -drive format=raw,file="bin/OS.bin",index=0,if=floppy,  -m 128M

compile_kernel:
	gcc -fno-pie -fno-stack-protector -ffreestanding -m32 -march=i386 -g -c "src/kernel.c" -o "obj/kernel.o"
	nasm -f elf "src/kernel_entry.asm" -o "obj/kernel_entry.o"
	ld -m elf_i386 -o "bin/full_kernel.bin" -Ttext 0x1000 "obj/kernel_entry.o" "obj/kernel.o" --oformat binary