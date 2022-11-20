#include <sys/types.h>
#include <sys/movedata.h>
#include <stdlib.h>
#include <dpmi.h>
#include <go32.h>

const int SF = 0x80;
const int ZF = 0x40;
const int PF = 0x04;
const int CF = 0x01;

int xgetchar() {
  __dpmi_regs regs;

  regs.x.ax = 0x0100;
  __dpmi_int (0x16, &regs);

  if (regs.x.flags & ZF) {
	  return 255;
  } else {
	  regs.x.ax = 0;
	  __dpmi_int(0x16, &regs);
	  return regs.x.ax;
  }
}
int xputs(const char *s) { return puts(s); }
void xtextmode(char *cga) {
   __dpmi_regs regs;

   regs.x.ax = 0x0003;
   __dpmi_int (0x10, &regs);
}
char *xgetcga() {
   __dpmi_regs regs;

   regs.x.ax = 0x0005;
   __dpmi_int (0x10, &regs);

   return 0xb8000;
}
void xpokeb(char *ptr, int into, int data) {
   _farpokeb(_dos_ds, (int)(ptr + into), (char)data);
}
int xrand() { return rand(); }
