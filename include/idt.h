#ifndef __IDT_H__
#define __IDT_H__

extern void _idt_load();
extern void idt_set_gate
(unsigned char num, unsigned long base, unsigned short sel, unsigned char flags);
extern void idt_install();

#endif // __IDT_H__