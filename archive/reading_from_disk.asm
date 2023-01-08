[org 0x7c00] 
mov [BOOT_DISK], dl                 

; setting up the stack

mov ax, 0                          
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

mov bx, 0x7e00

; reading the disk

mov ah, 2
mov al, 1 ; the number of sectors we want to read
mov ch, 0 ; the cylinder number
mov dh, 0 ; the head number
mov cl, 2 ; the sector number
mov dl, [BOOT_DISK]
int 0x13

; printing what is in the next sector

sector_print_loop:
	mov ah, 0x0e
	mov al, [bx]
	int 0x10
	inc bx
	cmp bx, 0x7f00
	jne sector_print_loop
	
jmp $
BOOT_DISK: db 0

; magic padding

times 510-($-$$) db 0              
dw 0xaa55

; filling the second sector ( the one that will be readed ) with 'A's

times 256 db "AB"