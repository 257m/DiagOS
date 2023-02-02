#include "../include/typedefs.h"

void putstr(char* string)
{
	char* vga = (char*)0xb8000;
	unsigned int i = 0;
	while (string[i] != '\0') {
		switch (string[i]) {
			case '\n':
				vga += 0xA0;
				i++;
				continue;
			case '\r':
				vga -= ((long unsigned int)vga + 0x10) % 80;
				i++;
				continue;
			case '\b':
				if (vga > (char*)0xb8002)
					vga -= 0x2;
				i++;
				continue;
			default:
				break;
		}
		*vga = string[i];
		vga += 0x2;
		i++;
	}
}

extern void main() 
{
	char message [] = 
	"  _____  _              ____   _____ \r\n"
	" |  __ \\(_)            / __ \\ / ____|\r\n"
	" | |  | |_  __ _  __ _| |  | | (___  \r\n"
	" | |  | | |/ _` |/ _` | |  | |\\___ \\ \r\n"
	" | |__| | | (_| | (_| | |__| |____) |\r\n"
	" |_____/|_|\\__,_|\\__, |\\____/|_____/ \r\n"
	"                  __/ |              \r\n"
	"                 |___/               \r\n"
	"Welcome to the kernel it has nothing inside it right now\r\n";
    putstr(message);
	while (1);
    return;
}