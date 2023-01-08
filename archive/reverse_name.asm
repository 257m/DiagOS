[org 0x7c00]

mov ebp, 0
mov bp, 0x8000
mov esp, 0
mov sp, bp

push Greeting
call print
add sp, 2

ask_for_input:
	mov [name_pointer], sp
input_loop:
	mov ah, 0
	int 0x16
	cmp al, 0x0A
	je print_buffer
	cmp al, 0x0D
	je print_buffer
	mov ah, 0x0e
	int 0x10
	sub sp, 1
	mov [esp], al
	jne input_loop
print_buffer:
	mov ah, 0x0e
	mov bx, buffer
	mov al, 0x0A
	int 0x10
	mov al, 0x0D
	int 0x10
	push buffer
	call print
	add sp, 2
	push WORD sp
	call print
	add sp, 2
	mov sp, [name_pointer]
	jmp end
	
print:
	mov bx, [esp+2]
	mov ah, 0x0e
	print_loop:
		mov al, [bx]
		cmp al, 0
		je print_return
		int 0x10
		inc bx
		jmp print_loop
	print_return:
		ret

Greeting:
	db "This program will give the the reverse of your name", 0x0A, 0x0D, "What's your name? ", 0

buffer:
	db "The reverse of your name is ", 0

name_pointer:
	times 2 db 0

end:
	jmp $
times 510-($-$$) db 0
db 0x55, 0xaa