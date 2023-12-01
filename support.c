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

char display_copy[16384] = { 0 };

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

   regs.x.ax = 0x0004;
   __dpmi_int (0x10, &regs);

   regs.x.ax = 0x0b00;
   regs.x.bx = 0x0100;
   __dpmi_int (0x10, &regs);

   return (char *)0xb8000;
}

int fill[] = {
  0,
  0x5555,
  0xaaaa,
  0xffff,
  0xbbbb,
  0x1111,
  0x2222,
  0x3333,
};

int lowmask[] = {
  0x0000,
  0x00c0,
  0x00f0,
  0x00fc,
  0x00ff,
  0xc0ff,
  0xf0ff,
  0xfcff,
  0xffff
};

#define UINT32_DISPLAY(AT) ((int *)(&display_copy[(AT)]))
#define UINT32_CGA(P,AT) (((int)(P)) + (AT))

void xwrite_color(char *cga, int y, int color, int upper_bound, int lower_bound) {
  if (y < 0 || y > 199 || color < 0 || color > 8 || upper_bound < 0 || lower_bound >= 320) {
    return;
  }
  int fill_value = fill[color % 8];

  if (upper_bound <= lower_bound) {
    return;
  }

  if (lower_bound < 0) {
    lower_bound = 0;
  }
  if (upper_bound >= 320) {
    upper_bound = 320;
  }

  int upper_byte = upper_bound >> 2;
  int lower_byte = lower_bound >> 2;
  int upper_bit = (15 - ((upper_bound << 1) % 16)) ^ 8;
  int lower_bit = (15 - ((lower_bound << 1) % 16)) ^ 8;
  int first_word = lower_byte & ~1;
  int last_word = upper_byte & ~1;
  int high_mask = lowmask[upper_bound % 8];
  int low_mask = ~lowmask[lower_bound % 8];
  int offset;

  if (y & 1) {
    offset = (y >> 1) * 80 + first_word + 8192;
    fill_value = ((fill_value | fill_value << 16) >> 2) & 0xffff;
  } else {
    offset = (y >> 1) * 80 + first_word;
  }

  if (first_word == last_word) {
    int the_mask = low_mask & high_mask;
    short *ptr = UINT32_DISPLAY(offset);
    int theword = (*ptr & ~the_mask) | (fill_value & the_mask);
    *ptr = theword;
    _farpokew(_dos_ds, UINT32_CGA(cga, offset), theword);
  } else {
    short *ptr = UINT32_DISPLAY(offset);
    int theword = (*ptr & ~low_mask) | (fill_value & low_mask);
    *ptr = theword;
    _farpokew(_dos_ds, UINT32_CGA(cga, offset), theword);

    ptr++; offset += 2; first_word += 2;
    while (first_word < last_word - 1) {
      *ptr = fill_value;
      _farpokew(_dos_ds, UINT32_CGA(cga, offset), fill_value);
      ptr++; offset += 2; first_word += 2;
    }

    theword = (*ptr & ~high_mask) | (fill_value & high_mask);
    *ptr = theword;
    _farpokew(_dos_ds, UINT32_CGA(cga, offset), theword);
  }
}

int xrand() { return rand(); }

static void *scanlines[201] = { 0 };

void preload_scanlines(void *ptr) {
  for (int i = 0; i < 200; i++) {
    scanlines[i] = ptr;
  }
}

void *get_line_ptr(int idx, void *ptr) {
  void *prev = scanlines[idx];
  scanlines[idx] = ptr;
  return prev;
}
