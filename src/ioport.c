#include "../include/typedefs.h"

/* BYTE IO 8 BITS */

inline void outb(uint16_t port, uint8_t val)
{
    asm volatile ( "outb %0, %1" : : "a"(val), "Nd"(port) );
}

inline uint8_t inb(uint16_t port)
{
    uint8_t ret;
    asm volatile ("inb %1, %0" : "=a"(ret) : "Nd"(port) );
    return ret;
}

/* WORD IO 16 BITS */

inline void outw(uint16_t port, uint16_t val)
{
    asm volatile ("outw %w0, %1" : : "a" (val), "id" (port) );
}

inline uint16_t inw(uint16_t port)
{
   uint16_t ret;
   asm volatile ("inw %1, %0" : "=a" (ret) : "dN" (port));
   return ret;
}

/* LONG IO 32 BITS */

inline void outl(uint16_t port, uint32_t val){
	asm volatile ("outl %%eax, %%dx" :: "d" (port), "a" (val));
}

inline uint32_t inl(uint16_t port){
   uint32_t ret;
   asm volatile ("inl %1, %0" : "=a" (ret) : "dN" (port));
   return ret;
} 