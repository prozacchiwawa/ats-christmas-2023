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

fn m_500 (): int = 50000 * (0 - 1)

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
            vertex(0, 10000, 0),
            vertex(5500, 0, 0),
            vertex(2750, 0, 4763),
            vertex(m1() * 2749, 0, 4763),
            vertex(m1() * 5499, 0, 0),
            vertex(m1() * 2750, 0, m1() * 4763),
            vertex(2749, 0, m1() * 4763),
            vertex(0, 32000, 0),
            vertex(21184, 6700, 8956),
            vertex(19526, 10150, m1() * 953),
            vertex(0, 32000, 0),
            vertex(6205, 6700, 22146),
            vertex(12920, 10150, 14672),
            vertex(0, 32000, 0),
            vertex(m1() * 13446, 6700, 18660),
            vertex(m1() * 3415, 10150, 19249),
            vertex(0, 32000, 0),
            vertex(m1() * 22972, 6700, 1121),
            vertex(m1() * 17179, 10150, 9331),
            vertex(0, 32000, 0),
            vertex(m1() * 15200, 6700, m1() * 17261),
            vertex(m1() * 18006, 10150, m1() * 7613),
            vertex(0, 32000, 0),
            vertex(4018, 6700, m1() * 22646),
            vertex(m1() * 5274, 10150, m1() * 18824),
            vertex(0, 32000, 0),
            vertex(20210, 6700, m1() * 10978),
            vertex(11429, 10150, m1() * 15861),
            vertex(0, 43000, 0),
            vertex(16809, 24300, 2540),
            vertex(12828, 26850, m1() * 6651),
            vertex(0, 43000, 0),
            vertex(2778, 24300, 16771),
            vertex(10289, 26850, 10145),
            vertex(0, 43000, 0),
            vertex(m1() * 15092, 24300, 7824),
            vertex(m1() * 6468, 26850, 12921),
            vertex(0, 43000, 0),
            vertex(m1() * 12105, 24300, m1() * 11935),
            vertex(m1() * 14287, 26850, m1() * 2159),
            vertex(0, 43000, 0),
            vertex(7610, 24300, m1() * 15201),
            vertex(m1() * 2361, 26850, m1() * 14255),
            vertex(0, 48000, 0),
            vertex(m1() * 5553, 35900, 9495),
            vertex(4629, 37550, 8123),
            vertex(0, 48000, 0),
            vertex(m1() * 5446, 35900, m1() * 9556),
            vertex(m1() * 9349, 37550, m1() * 52),
            vertex(0, 48000, 0),
            vertex(10999, 35900, 61),
            vertex(4720, 37550, m1() * 8071),
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
            tri(26, 10, 9, 1),
            tri(26, 9, 13, 5),
            tri(26, 13, 12, 1),
            tri(26, 12, 16, 5),
            tri(26, 16, 15, 1),
            tri(26, 15, 19, 5),
            tri(26, 19, 18, 1),
            tri(26, 18, 22, 5),
            tri(26, 22, 21, 1),
            tri(26, 21, 25, 5),
            tri(26, 25, 24, 1),
            tri(26, 24, 28, 5),
            tri(26, 28, 27, 1),
            tri(26, 27, 10, 5),
            tri(41, 31, 30, 1),
            tri(41, 30, 34, 5),
            tri(41, 34, 33, 1),
            tri(41, 33, 37, 5),
            tri(41, 37, 36, 1),
            tri(41, 36, 40, 5),
            tri(41, 40, 39, 1),
            tri(41, 39, 43, 5),
            tri(41, 43, 42, 1),
            tri(41, 42, 31, 5),
            tri(50, 46, 45, 1),
            tri(50, 45, 49, 5),
            tri(50, 49, 48, 1),
            tri(50, 48, 52, 5),
            tri(50, 52, 51, 1),
            tri(50, 51, 46, 5),
            tri(53, 56, 55, 3),
            tri(53, 58, 57, 3),
            tri(53, 60, 59, 3),
            tri(53, 62, 61, 3),
            tri(53, 64, 63, 3),
            tri(53, 55, 58, 4),
            tri(53, 57, 60, 4),
            tri(53, 59, 62, 4),
            tri(53, 61, 64, 4),
            tri(53, 63, 56, 4),
            tri(54, 55, 56, 3),
            tri(54, 57, 58, 3),
            tri(54, 59, 60, 3),
            tri(54, 61, 62, 3),
            tri(54, 63, 64, 3),
            tri(54, 58, 55, 4),
            tri(54, 60, 57, 4),
            tri(54, 62, 59, 4),
            tri(54, 64, 61, 4),
            tri(54, 56, 63, 4)
        )
in
    run_cga (55, 65, vert, tri) ;
    0
end
