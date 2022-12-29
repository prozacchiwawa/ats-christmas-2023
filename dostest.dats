#include "share/atspre_staload.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "libats/SATS/dynarray.sats"
staload _ = "libats/DATS/dynarray.dats"

#include "list.hats"
#include "system.hats"
#include "d_list_ent.hats"
#include "arraytry.hats"
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

fn make_zero_element (): struct_d_list_ent = let
  val dle = d_list_ent (0, 0, 320, 100000)
in
  dle
end

fun random_element (color : int) : struct_d_list_ent = let
  val depth = rand () % 1000
  val start_x = rand () % 20
  val end_x = 100 + rand () % 20
in
  d_list_ent (color, start_x, end_x, depth)
end

fn {a : vt@ype} make_nil (): rclist_vt (a, 0) = rclist_vt_nil ()

fn make_display_list_1 (r : int) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) =
let
  val empty_list = (make_zero_element ()) :: NIL
  val e1 = d_list_ent (1, 30, 100, 10) ;
  val e2 = d_list_ent (2, 50 + r, 120, 7) ;
  val lst = insert_into (empty_list, e1)
  val lst2 = insert_into (lst, e2)
in
  consume_list lst ;
  consume_list empty_list ;
  lst2
end

fn run_cga () = let
  val (pf | cga) = getcga ()

  val (scanp | scanlines) = alloc_line_ptr ()

  fun random_list_of_n_elements {x : int | 0 <= x} (at : int) (n : int(x)) : [k : int | 0 <= k] rclist_vt (struct_d_list_ent, k) =
    if n <= 0 then
      make_nil<struct_d_list_ent> ()
    else
      let
        val r = rand ()
        val rand_inc = (r / 4) % 13
        val rand_color = r % 4
        val new_higher_x = at + rand_inc
        val dle = d_list_ent (rand_color, at, 320, 0)
      in
        dle :: (random_list_of_n_elements new_higher_x (n - 1))
      end
  
  fun loop_random_px (n: int) : void =
    if n > 0 then
      let
	      val new_kb = keep_running ()
        val empty_list = (make_zero_element ()) :: NIL
        val color = 1 + (rand () % 3)
        val idx = rand () % 20
        val y = 100 + idx
        val lst = make_display_list_1 (idx) (* insert_into (empty_list, random_element color) *)
      in
        display_from_list_to_scan_line cga y lst ;
        consume_list lst ;
        consume_list empty_list ;
        loop_random_px (new_kb) ;
      end
    else
      ()
in
  loop_random_px 1 ;
  free_line_ptr (scanp | scanlines) ;
  textmode (pf | cga) ;
  0 
end

fn test_list_1 () = let
  val lst2 = make_display_list_1 (4)
in
  write_list lst2 ;
  consume_list lst2 ;
  0
end

implement main () =
  (* test_list_1 () *)
  run_cga ()
