[org 0x7c00]
KERNEL_LOCATION equ 0x1000

mov [BOOT_DISK], dl

; setting up the stack

xor ax, ax                          
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

mov bx, KERNEL_LOCATION
mov dh, 20

; reading the disk

mov ah, 0x2
mov al, dh		; the number of sectors we want to read
mov ch, 0x0		; the cylinder number
mov dh, 0x0		; the head number
mov cl, 0x2		; the sector number
mov dl, [BOOT_DISK]
int 0x13

mov ah, 0x0
mov al, 0x3
int 0x10

CODE_SEG equ code_descriptor - GDT_START
DATA_SEG equ data_descriptor - GDT_START

cli
lgdt [GDT_DESCRIPTOR]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp CODE_SEG:start_protected_mode

jmp $

BOOT_DISK: db 0

GDT_START:
	null_descriptor:
		dd 0x0 ; four null'd out bytes
		dd 0x0 ; four null'd out bytes
	code_descriptor:
		dw 0xffff
		dw 0x0
		db 0x0
		db 0b10011010
		db 0b11001111
		db 0x0
	data_descriptor:
		dw 0xFFFF
		dw 0
		db 0
		db 0b10010010
		db 0b11001111
		db 0
GDT_END:

GDT_DESCRIPTOR:
	dw GDT_END - GDT_START - 1
	dd GDT_START

[bits 32]
start_protected_mode:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ebp, 0x90000
	mov esp, ebp

	jmp KERNEL_LOCATION
 
times 510-($-$$) db 0              
dw 0xaa55