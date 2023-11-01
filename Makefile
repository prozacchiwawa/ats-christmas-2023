all: dostest.exe

dostest_dats.c: dostest.dats
	patscc -ccats dostest.dats

dostest.exe: dostest_dats.c
	i586-pc-msdosdjgpp-gcc -O3 -o ${@} -DATS_MEMALLOC_LIBC support.c dostest_dats.c /usr/lib/ats2-postiats-0.4.2/ccomp/atslib/lib/libatslib.a -I/usr/lib/ats2-postiats-0.4.2/ccomp/runtime -I/usr/lib/ats2-postiats-0.4.2

clean:
	rm -f dostest_dats.c dostest.exe
