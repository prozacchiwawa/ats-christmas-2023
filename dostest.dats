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

  fun interp_key (new_kb: int, location: struct_vertex, angle: int): (struct_vertex, int) =
      if new_kb = 119 then
          let
            val (dsin, dcos) = get_sin_cos (angle)
            val new_x = location.x - dsin * 3
            val new_z = location.z - dcos * 3
          in
            (vertex(new_x, location.y, new_z), angle)
          end
      else if new_kb = 115 then
          let
            val (dsin, dcos) = get_sin_cos (angle)
            val new_x = location.x + dsin * 3
            val new_z = location.z + dcos * 3
          in
            (vertex(new_x, location.y, new_z), angle)
          end
      else if new_kb = 100 then
          (location, (angle + 248) % 256)
      else if new_kb = 97 then
          (location, (angle + 12) % 256)
      else
          (location, angle)

  fun loop_random_px
    ( vtx : !arrszref(struct_vertex),
      tri : !arrszref(struct_triangle),
      location : struct_vertex,
      angle : int,
      n : int,
      y : int
    ) : void =
    if n >= 0 then
      let
	      val new_kb = keep_running ()
        val (new_location, new_angle) = interp_key (new_kb, location, angle)
      in
        draw_triangles (max_tri, last_vtx, new_location, new_angle, vtx, tri) ;
        (* make_random_triangle y ; *)
        display_scan_lines (cga, 199) ;
        // println!(new_location.x, " ", new_location.z, " a ", new_angle) ;
        loop_random_px (vtx, tri, new_location, new_angle, new_kb, y + 1)
      end
    else
      ()
in
  loop_random_px (vert, tri, vertex(15, 3000, 20000), 0, 1, 0) ;
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
        vertex(0, 4400, 0),
        vertex(550, 0, 0),
        vertex(275, 0, 476),
        vertex(m1() * 274, 0, 476),
        vertex(m1() * 549, 0, 0),
        vertex(m1() * 275, 0, m1() * 476),
        vertex(274, 0, m1() * 476),
        vertex(0, 3000, 0),
        vertex(1934, 690, 817),
        vertex(1782, 1005, m1() * 87),
        vertex(566, 690, 2022),
        vertex(1179, 1005, 1339),
        vertex(m1() * 1227, 690, 1703),
        vertex(m1() * 311, 1005, 1757),
        vertex(m1() * 2097, 690, 102),
        vertex(m1() * 1568, 1005, 852),
        vertex(m1() * 1387, 690, m1() * 1576),
        vertex(m1() * 1644, 1005, m1() * 695),
        vertex(366, 690, m1() * 2067),
        vertex(m1() * 481, 1005, m1() * 1718),
        vertex(1845, 690, m1() * 1002),
        vertex(1043, 1005, m1() * 1448),
        vertex(0, 3900, 0),
        vertex(1186, 2580, 179),
        vertex(905, 2760, m1() * 469),
        vertex(196, 2580, 1183),
        vertex(726, 2760, 716),
        vertex(m1() * 1065, 2580, 552),
        vertex(m1() * 456, 2760, 912),
        vertex(m1() * 854, 2580, m1() * 842),
        vertex(m1() * 1008, 2760, m1() * 152),
        vertex(537, 2580, m1() * 1073),
        vertex(m1() * 166, 2760, m1() * 1006),
        vertex(0, 4500, 0),
        vertex(m1() * 403, 3620, 690),
        vertex(336, 3740, 590),
        vertex(m1() * 396, 3620, m1() * 695),
        vertex(m1() * 679, 3740, m1() * 3),
        vertex(799, 3620, 4),
        vertex(343, 3740, m1() * 586),
        vertex(0, 5100, m1() * 112),
        vertex(0, 5100, 112),
        vertex(750, 5100, 0),
        vertex(182, 4967, 0),
        vertex(231, 5813, 0),
        vertex(182, 5232, 0),
        vertex(m1() * 606, 5540, 0),
        vertex(m1() * 69, 5313, 0),
        vertex(m1() * 606, 4659, 0),
        vertex(m1() * 224, 5100, 0),
        vertex(231, 4386, 0),
        vertex(m1() * 69, 4886, 0),

        vertex(18260, 0, 5967),
        vertex(26032, 0, 12260),
        vertex(13445, 0, 27803),
        vertex(5674, 0, 21510),
        vertex(18260, 10000, 5967),
        vertex(26032, 10000, 12260),
        vertex(13445, 10000, 27803),
        vertex(5674, 10000, 21510),
        vertex(22146, 15000, 9114),
        vertex(9560, 15000, 24657)
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
        tri(42, 44, 51, 4),

        tri(53, 54, 57, 3),
        tri(57, 54, 58, 3),
        tri(54, 55, 59, 4),
        tri(54, 59, 58, 4),
        tri(55, 56, 60, 3),
        tri(55, 60, 59, 3),
        tri(53, 56, 60, 4),
        tri(53, 60, 57, 4),
        tri(57, 58, 61, 3),
        tri(59, 60, 62, 3),
        tri(57, 61, 62, 2),
        tri(57, 62, 60, 2),
        tri(59, 62, 61, 2),
        tri(59, 61, 58, 2)
        )
in
    run_cga (65, 72, vert, tri) ;
    0
end
