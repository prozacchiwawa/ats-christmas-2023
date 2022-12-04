#include <sys/types.h>
#include <sys/movedata.h>
#include <stdio.h>
#include <stdlib.h>
#include <dpmi.h>
#include <go32.h>

const int SF = 0x80;
const int ZF = 0x40;
const int PF = 0x04;
const int CF = 0x01;

char display_copy[16000] = { 0 };

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

   return (char *)0xb8000;
}

int fill[] = {
  0,
  0x55555555,
  0xaaaaaaaa,
  0xffffffff
};

#define UINT32_DISPLAY(AT) ((int *)(&display_copy[(AT)]))
#define UINT32_CGA(P,AT) (((int)(P)) + (AT))

void xwrite_color(char *cga, int y, int color, int upper_bound, int lower_bound) {
  int fill_value = fill[color % 4];
  if (upper_bound <= lower_bound) {
    return;
  }

  int upper_byte = upper_bound >> 2;
  int lower_byte = lower_bound >> 2;
  int upper_bit = (upper_bound << 1) % 32;
  int lower_bit = (lower_bound << 1) % 32;
  int first_word = (lower_byte + 3) & ~3;
  int last_word = (upper_byte + 3) & ~3;
  int high_mask = (1 << upper_bit) - 1;
  int low_mask = ~((1 << lower_bit) - 1);
  int offset = y * 80 + first_word;

  if (first_word == last_word) {
    int the_mask = low_mask & high_mask;
    int *ptr = UINT32_DISPLAY(offset);
    int theword = (*ptr & ~the_mask) | fill_value & the_mask;
    *ptr = theword;
    _farpokel(_dos_ds, UINT32_CGA(cga, offset), theword);
  } else {
    int *ptr = UINT32_DISPLAY(offset);
    int theword = (*ptr & ~low_mask) | fill_value & low_mask;
    *ptr = theword;
    _farpokel(_dos_ds, UINT32_CGA(cga, offset), theword);

    while (first_word < last_word - 4) {
      ptr++; offset += 4; first_word += 4;
      *ptr = fill_value;
      _farpokel(_dos_ds, UINT32_CGA(cga, offset), theword);
    }

    theword = (*ptr & ~high_mask) | fill_value & high_mask;
    *ptr = theword;
    _farpokel(_dos_ds, UINT32_CGA(cga, offset), theword);
  }
}

int xrand() { return rand(); }
