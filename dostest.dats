#include "share/atspre_staload.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "libats/SATS/dynarray.sats"
staload _ = "libats/DATS/dynarray.dats"

#include "list.hats"
#include "system.hats"
#include "d_list_ent.hats"
#include "display.hats"
#include "geometry.hats"
#include "appstate.hats"

fn keep_running () : int =
  begin
    if (getchar () % 256) != 0x1b then
      1
    else
      0
  end

implement main () = let
  val (pf | cga) = getcga ()

  fun {a : vt@ype} make_nil (): rclist_vt (a, 0) = rclist_vt_nil ()

  fun make_zero_element (): struct_d_list_ent =
    let
      var dle: struct_d_list_ent
    in
      dle.color := 0;
      dle.at_x := 0;
      dle
    end

  fun random_list_of_n_elements {x : int | 0 <= x} (at : int) (n : int(x)) : rclist_vt (struct_d_list_ent, (x+1)) =
    if n <= 0 then
      let
        var dle: struct_d_list_ent
      in
        dle.color := 0 ;
        dle.at_x := 320 ;
        dle :: make_nil<struct_d_list_ent> ()
      end
    else
      let
        var dle: struct_d_list_ent
        val r = rand ()
        val rand_inc = (r / 4) % 13
        val rand_color = r % 4
        val new_higher_x = at + rand_inc
      in
        dle.color := rand_color ;
        dle.at_x := at ;
        dle :: (random_list_of_n_elements new_higher_x (n - 1))
      end
  
  fun loop_random_px (n: int) : void =
    if n > 0 then
      let
	      val new_kb = keep_running ()
        val first_at = rand () % 40
        val first_struct = make_zero_element ()
        val lst = (make_zero_element ()) :: (random_list_of_n_elements first_at 1)
        val y = rand () % 200
      in
        display_from_list_to_scan_line cga y lst ;
        consume_list lst ;
        loop_random_px (new_kb) ;
      end
    else
      ()
in
  loop_random_px 1 ;
  textmode (pf | cga) ;
  0 
end
