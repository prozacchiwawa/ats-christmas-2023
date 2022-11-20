#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"
staload "libats/SATS/dynarray.sats"
staload _ = "libats/DATS/dynarray.dats"

extern fun getchar (): int = "xgetchar"
extern fun puts (s: string): size_t = "xputs"
extern fun getcga (): [l:agz] (char @ l | ptr l) = "xgetcga"
extern fun pokeb (p : ptr, into: int, w: int): void = "xpokeb"
extern fun rand (): int = "xrand"
extern fun textmode {l:agz} (pf: char @ l | p : ptr l): void = "xtextmode"

fn keep_running () : int =
  begin
    if (getchar () % 256) != 0x1b then
      1
    else
      0
  end

implement main () = let
  val (pf | cga) = getcga ()
  fun loop_random_px (n: int) : void =
    if n > 0 then
      let
        val into = rand () % (80 * 200)
        val chr = rand () % 256
	val new_kb = keep_running ()
      in 
        pokeb (cga, into, chr) ;
        loop_random_px (new_kb)
      end
    else
      ()
in
  loop_random_px 1 ;
  textmode (pf | cga) ;
  0 
end
