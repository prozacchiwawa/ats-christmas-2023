#include "share/atspre_staload.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "libats/SATS/dynarray.sats"
staload _ = "libats/DATS/dynarray.dats"

#include "list.hats"
#include "system.hats"
#include "d_list_ent.hats"
#include "display.hats"
#include "geometry.hats"
#include "triangle.hats"
#include "appstate.hats"

fn keep_running () : int = let
    val gc = getchar ()
in
    if (gc % 256) != 0x1b then
      gc % 256
    else
      (0 - 1)
end

fn make_zero_element (): struct_d_list_ent = let
  val dle = d_list_ent (0, 0, 320, 100000000)
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

fn make_display_list_2 (r : int) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) =
let
  val empty_list = (make_zero_element ()) :: NIL
  val e1 = d_list_ent (1, 30 + r, 100, 7) ;
  val e2 = d_list_ent (2, 50, 120, 10) ;
  val lst = insert_into (empty_list, e1)
  val lst2 = insert_into (lst, e2)
in
  consume_list lst ;
  consume_list empty_list ;
  lst2
end

fn make_random_triangle (n : int) = let
  val ax = 160 (* 10 + rand () % 300 *)
  val ay = 70 (* 10 + rand () % 180 *)
  val bx = 10 (* 10 + rand () % 300 *)
  val by = 20 + (n % 160) (* 10 + rand () % 180 *)
  val cx = 310 (* 10 + rand () % 300 *)
  val cy = 140 (* 10 + rand () % 180 *)
  val color = 1 + rand () % 3
  val depth = 1 + rand () % 100
in
  make_triangle (color, ax, ay, bx, by, cx, cy, depth)
end

fn m1 (): int = (0 - 1)

fn run_cga
   {st: int | 0 <= st}
   ( max_tri: int(st),
     last_vtx: int,
     vert : !arrszref(struct_vertex),
     tri : !arrszref(struct_triangle)
   ) : void = let
  val (pf | cga) = getcga ()

  val _ = preload_scanlines NIL

  fun display_scan_lines {n : int | 0 <= n} .<n>. (cga : ptr, y : int(n)): void =
    if y = 0 then
      ()
    else
      let
        val old_list = get_line_ptr (y, make_zero_element () :: NIL)
      in
        display_from_list_to_scan_line cga y old_list ;
        consume_list old_list ;
        display_scan_lines (cga, y - 1)
      end

  val _ = display_scan_lines (cga, 199)

  fun interp_key (new_kb: int, dist: int, angle: int): (int, int) =
      if new_kb = 119 then
          if dist > 100000 then
              (dist - 10000, angle)
          else
              (dist, angle)
      else if new_kb = 115 then
          (dist + 10000, angle)
      else if new_kb = 97 then
          (dist, (angle + 251) % 256)
      else if new_kb = 100 then
          (dist, angle + 5)
      else
          (dist, angle)

  fun loop_random_px
    ( vtx : !arrszref(struct_vertex),
      tri : !arrszref(struct_triangle),
      dist : int,
      angle : int,
      n : int,
      y : int
    ) : void =
    if n >= 0 then
      let
	      val new_kb = keep_running ()
        val (new_dist, new_angle) = interp_key (new_kb, dist, angle)
      in
        draw_triangles (max_tri, last_vtx, new_dist, new_angle, vtx, tri) ;
        (* make_random_triangle y ; *)
        display_scan_lines (cga, 199) ;
        loop_random_px (vtx, tri, new_dist, new_angle, new_kb, y + 1)
      end
    else
      ()
in
  loop_random_px (vert, tri, 300000, 13, 1, 0) ;
  textmode (pf | cga)
end

fn test_list_1 () = let
  val lst2 = make_display_list_1 (4)
in
  write_list lst2 ;
  consume_list lst2 ;
  0
end

fn test_triangle_1 () = let
  val () = preload_scanlines NIL
  val color = 1 + (rand () % 3)
  val () = make_random_triangle 32
  val () = make_random_triangle 64
  val test_list = get_line_ptr (100, make_zero_element () :: NIL)
in
  println! ("line 100");
  write_list test_list ;
  consume_list test_list ;
  0
end

implement main () = let
    val vert =
        (arrszref)$arrpsz{struct_vertex}(
        vertex(0, 0, 0),
        vertex(0, 44000, 0),
        vertex(5500, 0, 0),
        vertex(2750, 0, 4763),
        vertex(m1() * 2749, 0, 4763),
        vertex(m1() * 5499, 0, 0),
        vertex(m1() * 2750, 0, m1() * 4763),
        vertex(2749, 0, m1() * 4763),
        vertex(0, 30000, 0),
        vertex(19342, 6900, 8177),
        vertex(17828, 10050, m1() * 870),
        vertex(5666, 6900, 20221),
        vertex(11796, 10050, 13396),
        vertex(m1() * 12276, 6900, 17037),
        vertex(m1() * 3118, 10050, 17575),
        vertex(m1() * 20975, 6900, 1024),
        vertex(m1() * 15685, 10050, 8520),
        vertex(m1() * 13878, 6900, m1() * 15760),
        vertex(m1() * 16440, 10050, m1() * 6951),
        vertex(3668, 6900, m1() * 20677),
        vertex(m1() * 4816, 10050, m1() * 17187),
        vertex(18453, 6900, m1() * 10023),
        vertex(10435, 10050, m1() * 14481),
        vertex(0, 39000, 0),
        vertex(11865, 25800, 1793),
        vertex(9055, 27600, m1() * 4694),
        vertex(1961, 25800, 11838),
        vertex(7263, 27600, 7161),
        vertex(m1() * 10653, 25800, 5523),
        vertex(m1() * 4566, 27600, 9120),
        vertex(m1() * 8545, 25800, m1() * 8424),
        vertex(m1() * 10085, 27600, m1() * 1524),
        vertex(5372, 25800, m1() * 10730),
        vertex(m1() * 1666, 27600, m1() * 10062),
        vertex(0, 45000, 0),
        vertex(m1() * 4038, 36200, 6905),
        vertex(3366, 37400, 5907),
        vertex(m1() * 3961, 36200, m1() * 6950),
        vertex(m1() * 6799, 37400, m1() * 38),
        vertex(7999, 36200, 44),
        vertex(3432, 37400, m1() * 5869),
        vertex(0, 51000, m1() * 1125),
        vertex(0, 51000, 1125),
        vertex(7500, 51000, 0),
        vertex(1820, 49677, 0),
        vertex(2317, 58132, 0),
        vertex(1820, 52322, 0),
        vertex(m1() * 6067, 55408, 0),
        vertex(m1() * 695, 53139, 0),
        vertex(m1() * 6067, 46591, 0),
        vertex(m1() * 2249, 51000, 0),
        vertex(2317, 43867, 0),
        vertex(m1() * 695, 48860, 0)
        )

    val tri =
        (arrszref)$arrpsz{struct_triangle}(
        tri(1, 2, 3, 2),
        tri(1, 3, 4, 2),
        tri(1, 4, 5, 2),
        tri(1, 5, 6, 2),
        tri(1, 6, 7, 2),
        tri(1, 7, 2, 2),
        tri(8, 10, 9, 1),
        tri(8, 9, 12, 5),
        tri(8, 12, 11, 1),
        tri(8, 11, 14, 5),
        tri(8, 14, 13, 1),
        tri(8, 13, 16, 5),
        tri(8, 16, 15, 1),
        tri(8, 15, 18, 5),
        tri(8, 18, 17, 1),
        tri(8, 17, 20, 5),
        tri(8, 20, 19, 1),
        tri(8, 19, 22, 5),
        tri(8, 22, 21, 1),
        tri(8, 21, 10, 5),
        tri(23, 25, 24, 1),
        tri(23, 24, 27, 5),
        tri(23, 27, 26, 1),
        tri(23, 26, 29, 5),
        tri(23, 29, 28, 1),
        tri(23, 28, 31, 5),
        tri(23, 31, 30, 1),
        tri(23, 30, 33, 5),
        tri(23, 33, 32, 1),
        tri(23, 32, 25, 5),
        tri(34, 36, 35, 1),
        tri(34, 35, 38, 5),
        tri(34, 38, 37, 1),
        tri(34, 37, 40, 5),
        tri(34, 40, 39, 1),
        tri(34, 39, 36, 5),
        tri(41, 44, 43, 3),
        tri(41, 43, 46, 3),
        tri(42, 43, 44, 3),
        tri(42, 46, 43, 3),
        tri(41, 46, 45, 3),
        tri(41, 45, 48, 4),
        tri(42, 45, 46, 4),
        tri(42, 48, 45, 4),
        tri(41, 48, 47, 4),
        tri(41, 47, 50, 4),
        tri(42, 47, 48, 3),
        tri(42, 50, 47, 3),
        tri(41, 50, 49, 3),
        tri(41, 49, 52, 3),
        tri(42, 49, 50, 3),
        tri(42, 52, 49, 4),
        tri(41, 52, 51, 4),
        tri(41, 51, 44, 4),
        tri(42, 51, 52, 4),
        tri(42, 44, 51, 4)
        )
in
    run_cga (55, 65, vert, tri) ;
    0
end
