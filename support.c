#include <sys/types.h>
#include <sys/movedata.h>
#include <dpmi.h>
#include <go32.h>

int xgetchar() { return getchar(); }
int xputs(const char *s) { return puts(s); }
void xtextmode(char *cga) {
   __dpmi_regs regs;

   regs.x.ax = 0x0003;        /* AH = 38h, AL = 00h  */
   __dpmi_int (0x10, &regs);  /* call DOS  */
}
char *xgetcga() {
   __dpmi_regs regs;

   regs.x.ax = 0x0004;        /* AH = 38h, AL = 00h  */
   __dpmi_int (0x10, &regs);  /* call DOS  */

   return 0xb8000;
}
void xpokeb(char *ptr, char data) {
   _farpokeb(_dos_ds, (int)ptr, data);
}
