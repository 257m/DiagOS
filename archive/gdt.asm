[org 0x7c00]                        

mov [BOOT_DISK], dl

CODE_SEG equ code_descriptor - GDT_START
DATA_SEG equ data_descriptor - GDT_START

cli
lgdt [GDT_DESCRIPTOR]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp CODE_SEG:start_protected_mode

GDT_START:
	null_descriptor:
		dd 0 ; four null'd out bytes
		dd 0 ; four null'd out bytes
	code_descriptor:
		dw 0xFFFF
		dw 0
		db 0
		db 0b10011010
		db 0b11001111
		db 0
	data_descriptor:
		dw 0xFFFF
		dw 0
		db 0
		db 0b1000010
		db 0b11001111
		db 0
	GDT_END:

GDT_DESCRIPTOR:
	dw GDT_END - GDT_START - 1
	dd GDT_START

[bits 32]
start_protected_mode:
	; video_memory = 0xb8000
	mov al, 'A' ; character
	mov ah, 0x0f ; colour
	mov [0xb8000], ax
	jmp $

BOOT_DISK: db 0                                 
 
times 510-($-$$) db 0              
dw 0xaa55