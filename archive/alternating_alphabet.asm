mov ah, 0x0e
mov al, 'A'
alphabet_loop:
	int 0x10
	add al, 32
	int 0x10
	sub al, 32
	inc al
	cmp al, 'Z' + 1
	jne alphabet_loop
jmp $
times 510-($-$$) db 0
db 0x55, 0xaa