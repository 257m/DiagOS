[org 0x7c00]

mov ah, 0x0e
mov bx, Greeting
print_Greeting:
	mov al, [bx]
	cmp al, 0
	je ask_for_input
	int 0x10
	inc bx
	jmp print_Greeting

ask_for_input:
	mov bx, buffer+13

input_loop:
	mov ah, 0
	int 0x16
	cmp al, 0x0A
	je print_buffer
	cmp al, 0x0D
	je print_buffer
	mov ah, 0x0e
	int 0x10
	mov [bx], al
	inc bx
	cmp bx, buffer+28
	jne input_loop

print_buffer:
	mov ah, 0x0e
	mov bx, buffer
	mov al, 0x0A
	int 0x10
	mov al, 0x0D
	int 0x10
print_loop:
	mov al, [bx]
	cmp al, 0
	je end
	int 0x10
	inc bx
	jmp print_loop

Greeting:
	db "What's your name? ", 0

buffer:
	db "Hello there, "
	times 16 db 0

end:
	jmp $
times 510-($-$$) db 0
db 0x55, 0xaa