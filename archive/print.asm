[org 0x7c00]
mov bx, string
mov ah, 0x0e

print:
	mov al, [bx]
	cmp al, 0
	je end
	int 0x10
	inc bx
	jmp print 

string:
	db "hello, world", 0
end:
	jmp $
times 510-($-$$) db 0
db 0x55, 0xaa