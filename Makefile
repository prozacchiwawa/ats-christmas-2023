all: dostest.exe

scene.hats: makegeometry.py tree.obj
	python makegeometry.py tree.obj > scene.hats

dostest_dats.c: dostest.dats scene.hats
	patscc -ccats dostest.dats

dostest.exe: dostest_dats.c
	i586-pc-msdosdjgpp-gcc -O3 -o ${@} -DATS_MEMALLOC_LIBC support.c dostest_dats.c /usr/local/lib/ats2-postiats-0.4.2/ccomp/atslib/lib/libatslib.a -I/usr/local/lib/ats2-postiats-0.4.2/ccomp/runtime -I/usr/local/lib/ats2-postiats-0.4.2

clean:
	rm -f scene.hats dostest_dats.c dostest.exe
