[org 0x7c00]

mov ebp, 0
mov bp, 0x8000
mov esp, 0
mov sp, bp

push WORD 12345
call print_num
sub sp, 2
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

print_num:
	mov ax, [esp+2]
	push bp
	mov bp, sp
	mov bx, 10
	push WORD 0x0
	mov dx, 0

	printDigitToStackLoop:
		mov cx, ax
		div bx
		mul bx
		sub cx, ax
		add cx, 48
		push cx
		div bx
		cmp ax, 0
		jne printDigitToStackLoop

	printDigitOutOfStack:
		pop ax
		cmp al, 0x0
		je print_num_return
		mov ah, 0x0e
		int 0x10
		jmp printDigitOutOfStack

	print_num_return:
		mov sp, bp
		pop bp
		ret
	

end:
	jmp $
times 510-($-$$) db 0
db 0x55, 0xaa