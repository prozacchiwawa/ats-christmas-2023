#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "libats/SATS/dynarray.sats"
staload _ = "libats/DATS/dynarray.dats"

extern fun getchar (): char = "xgetchar"
extern fun puts (s: string): size_t = "xputs"
extern fun getcga (): [l:agz] (char @ l | ptr l) = "xgetcga"
extern fun pokeb (p : ptr, w: char): void = "xpokeb"
extern fun textmode {l:agz} (pf: char @ l | p : ptr l): void = "xtextmode"

implement main () = let
  val (pf | cga) = getcga ()
  val ch = getchar ()
in
  pokeb(cga, ch);
  let
    val _ = getchar ()
  in
    textmode (pf | cga) ;
    0 
  end
end
