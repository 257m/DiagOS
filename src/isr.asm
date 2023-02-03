global _isr0
global _isr1
global _isr2
global _isr3
global _isr4
global _isr5
global _isr6
global _isr7
global _isr8
global _isr9
global _isr10
global _isr11
global _isr12
global _isr13
global _isr14
global _isr15
global _isr16
global _isr17
global _isr18
global _isr19
global _isr20
global _isr21
global _isr22
global _isr23
global _isr24
global _isr25
global _isr26
global _isr27
global _isr28
global _isr29
global _isr30
global _isr31

_isr0: ; Division By Zero Exception
	cli
	push byte 0
	push byte 0
	jmp isr_common_stub

_isr1: ; Debug Exception
	cli
	push byte 0
	push byte 1
	jmp isr_common_stub

_isr2: ; Non Maskable Interrupt Exception
	cli
	push byte 0
	push byte 2
	jmp isr_common_stub

_isr3: ; Breakpoint Exception
	cli
	push byte 0
	push byte 3
	jmp isr_common_stub

_isr4: ; Into Detected Overflow Exception
	cli
	push byte 0
	push byte 4
	jmp isr_common_stub

_isr5: ; Out of Bounds Exception
	cli
	push byte 0
	push byte 5
	jmp isr_common_stub

_isr6: ; Invalid Opcode Exception
	cli
	push byte 0
	push byte 6
	jmp isr_common_stub

_isr7: ; No Coprocessor Exception
	cli
	push byte 0
	push byte 7
	jmp isr_common_stub

_isr8: ; Double Fault Exception
	cli
	; We don't push a dummy error code here because it pushes one already
	push byte 8
	jmp isr_common_stub

_isr9: ; Coprocessor Segment Overrun Exception
	cli
	push byte 0
	push byte 9
	jmp isr_common_stub

_isr10: ; Bad TSS Exception
	cli
	; We don't push a dummy error code here because it pushes one already
	push byte 10
	jmp isr_common_stub

_isr11: ; Segment Not Present Exception
	cli
	; We don't push a dummy error code here because it pushes one already
	push byte 11
	jmp isr_common_stub

_isr12: ; Stack Fault Exception
	cli
	; We don't push a dummy error code here because it pushes one already
	push byte 12
	jmp isr_common_stub

_isr13: ; General Protection Fault Exception
	cli
	; We don't push a dummy error code here because it pushes one already
	push byte 13
	jmp isr_common_stub

_isr14: ; Page Fault Exception
	cli
	; We don't push a dummy error code here because it pushes one already
	push byte 14
	jmp isr_common_stub

_isr15: ; Unknown Interrupt Exception
	cli
	push byte 0
	push byte 15
	jmp isr_common_stub

_isr16: ; Coprocessor Fault Exception
	cli
	push byte 0
	push byte 16
	jmp isr_common_stub

_isr17: ; Alignment Check Exception (486+)
	cli
	push byte 0
	push byte 17
	jmp isr_common_stub

_isr18: ; Machine Check Exception (Pentium/586+)
	cli
	push byte 0
	push byte 18
	jmp isr_common_stub

_isr19: ; Reserved Exception
	cli
	push byte 0
	push byte 19
	jmp isr_common_stub

_isr20: ; Reserved Exception
	cli
	push byte 0
	push byte 20
	jmp isr_common_stub

_isr21: ; Reserved Exception
	cli
	push byte 0
	push byte 21
	jmp isr_common_stub

_isr22: ; Reserved Exception
	cli
	push byte 0
	push byte 22
	jmp isr_common_stub

_isr23: ; Reserved Exception
	cli
	push byte 0
	push byte 23
	jmp isr_common_stub

_isr24: ; Reserved Exception
	cli
	push byte 0
	push byte 24
	jmp isr_common_stub

_isr25: ; Reserved Exception
	cli
	push byte 0
	push byte 25
	jmp isr_common_stub

_isr26: ; Reserved Exception
	cli
	push byte 0
	push byte 26
	jmp isr_common_stub

_isr27: ; Reserved Exception
	cli
	push byte 0
	push byte 27
	jmp isr_common_stub

_isr28: ; Reserved Exception
	cli
	push byte 0
	push byte 28
	jmp isr_common_stub

_isr29: ; Reserved Exception
	cli
	push byte 0
	push byte 29
	jmp isr_common_stub

_isr30: ; Reserved Exception
	cli
	push byte 0
	push byte 30
	jmp isr_common_stub

_isr31: ; Reserved Exception
	cli
	push byte 0
	push byte 31
	jmp isr_common_stub

extern _fault_handler

isr_common_stub:
	pusha
    push ds
    push es
    push fs
    push gs
    mov ax, 0x10   ; Load the Kernel Data Segment descriptor!
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov eax, esp   ; Push us the stack
    push eax
    mov eax, _fault_handler
    call eax       ; A special call, preserves the 'eip' register
    pop eax
    pop gs
    pop fs
    pop es
    pop ds
    popa
    add esp, 8     ; Cleans up the pushed error code and pushed ISR number
    iret           ; pops 5 things at once: CS, EIP, EFLAGS, SS, and ESP!	
