/* Defines an IDT entry */
struct idt_entry
{
    unsigned short base_lo;
    unsigned short sel;        /* Our kernel segment goes here! */
    unsigned char always0;     /* This will ALWAYS be set to 0! */
    unsigned char flags;       /* Set using the above table! */
    unsigned short base_hi;
} __attribute__((packed));

// Note: the base is just another name for the 32 bit offset

/*
Basically an IDT entry has four parts on is a 32 bit pointer to the Interrupt Servive 
Routine which is split up into two parts base_lo and base_hi next you have a 1 bit 
selector which describes a code segment (in our case the code segment). The selector 
for the code segment (which is the first entry of our GDT) is 8. This value is 
calculated by setting the lowest two bits of the selector to the privilege level of 
our code segment (which is zero), the third to zero (it would be one if we were using 
a local descriptor table, but we are not) and the rest to the index of our code 
segment descriptor in the GDT. As it is the first entry, this index is one. So we end 
up with the 16 bit binary number. You also have a byte that is completely unused and 
will always be 0 and finally a byte for flags. The first four bits represent what type 
of IDT gate we are defining, in this case we are defining a 32 bit interrupt, so these 
bits should be 1 1 1 0, or 0xe.
– The fifth bit should be zero
– The next two bits contain the descriptor privilege level, and should also be zero
– The final bit contains 1 if the interrupt is “present”, so it should be 1.
*/

struct idt_ptr
{
    unsigned short limit;
    unsigned int base;
} __attribute__((packed));

struct idt_entry idt [256]; // declare 256 idt entries
struct idt_ptr _idtp;

extern void _idt_load();

void idt_set_gate
(unsigned num, unsigned long base, unsigned short sel,unsigned char flags)
{
	idt[num].base_lo = base & 0x0000FFFF;
	idt[num].base_hi = (base & 0xFFFF0000) >> 16;
	idt[num].sel = sel;
	idt[num].flags = flags;
	idt[num].always0 = 0x0;
}

void idt_install()
{
	/* Sets the special IDT pointer up */
    idtp.limit = (sizeof (struct idt_entry) * 256) - 1;
    idtp.base = &idt;

    /* Clear out the entire IDT, initializing it to zeros */
    memset(&idt, 0, sizeof(struct idt_entry) * 256);

    /* Add any new ISRs to the IDT here using idt_set_gate */

    /* Points the processor's internal register to the new IDT */
    idt_load();
}