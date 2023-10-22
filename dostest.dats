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

  fun loop_random_px
    ( vtx : !arrszref(struct_vertex),
      tri : !arrszref(struct_triangle),
      dist : int,
      n : int,
      y : int
    ) : void =
    if n >= 0 then
      let
	      val new_kb = keep_running ()
        val new_dist =
            if new_kb = 119 then
                dist + 10000
            else if new_kb = 115 then
                dist - 10000
            else
                dist
      in
        draw_triangles (max_tri, last_vtx, new_dist, vtx, tri) ;
        (* make_random_triangle y ; *)
        display_scan_lines (cga, 199) ;
        loop_random_px (vtx, tri, new_dist, new_kb, y + 1)
      end
    else
      ()
in
  loop_random_px (vert, tri, 300000, 1, 0) ;
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
            vertex(19422, 10150, 2231),
            vertex(0, 32000, 0),
            vertex(12979, 6700, 18987),
            vertex(15132, 10150, 12377),
            vertex(0, 32000, 0),
            vertex(653, 6700, 22990),
            vertex(6038, 10150, 18594),
            vertex(0, 32000, 0),
            vertex(m1() * 11880, 6700, 19694),
            vertex(m1() * 4973, 10150, 18906),
            vertex(0, 32000, 0),
            vertex(m1() * 20641, 6700, 10144),
            vertex(m1() * 14405, 10150, 13216),
            vertex(0, 32000, 0),
            vertex(m1() * 22849, 6700, m1() * 2625),
            vertex(m1() * 19264, 10150, 3330),
            vertex(0, 32000, 0),
            vertex(m1() * 17802, 6700, m1() * 14562),
            vertex(m1() * 18006, 10150, m1() * 7613),
            vertex(0, 32000, 0),
            vertex(m1() * 7103, 6700, m1() * 21875),
            vertex(m1() * 11032, 10150, m1() * 16139),
            vertex(0, 32000, 0),
            vertex(5850, 6700, m1() * 22243),
            vertex(m1() * 555, 10150, m1() * 19542),
            vertex(0, 32000, 0),
            vertex(16947, 6700, m1() * 15549),
            vertex(10098, 10150, m1() * 16739),
            vertex(0, 32000, 0),
            vertex(22663, 6700, m1() * 3918),
            vertex(17545, 10150, m1() * 8623),
            vertex(0, 43000, 0),
            vertex(16809, 24300, 2540),
            vertex(14164, 26850, m1() * 2857),
            vertex(0, 43000, 0),
            vertex(11243, 24300, 12750),
            vertex(12687, 26850, 6915),
            vertex(0, 43000, 0),
            vertex(417, 24300, 16994),
            vertex(5273, 26850, 13453),
            vertex(0, 43000, 0),
            vertex(m1() * 10604, 24300, 13286),
            vertex(m1() * 4607, 26850, 13695),
            vertex(0, 43000, 0),
            vertex(m1() * 16664, 24300, 3361),
            vertex(m1() * 12333, 26850, 7529),
            vertex(0, 43000, 0),
            vertex(m1() * 14926, 24300, m1() * 8136),
            vertex(m1() * 14287, 26850, m1() * 2159),
            vertex(0, 43000, 0),
            vertex(m1() * 6204, 24300, m1() * 15827),
            vertex(m1() * 9557, 26850, m1() * 10838),
            vertex(0, 43000, 0),
            vertex(5420, 24300, m1() * 16112),
            vertex(m1() * 354, 26850, m1() * 14445),
            vertex(0, 43000, 0),
            vertex(14509, 24300, m1() * 8858),
            vertex(9013, 26850, m1() * 11293),
            vertex(0, 48000, 0),
            vertex(m1() * 5553, 35900, 9495),
            vertex(925, 37550, 9304),
            vertex(0, 48000, 0),
            vertex(m1() * 10746, 35900, m1() * 2347),
            vertex(m1() * 8562, 37550, 3755),
            vertex(0, 48000, 0),
            vertex(m1() * 1088, 35900, m1() * 10946),
            vertex(m1() * 6217, 37550, m1() * 6983),
            vertex(0, 48000, 0),
            vertex(10073, 35900, m1() * 4417),
            vertex(4720, 37550, m1() * 8071),
            vertex(0, 48000, 0),
            vertex(7314, 35900, 8215),
            vertex(9134, 37550, 1995),
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
            tri (1, 2, 3, 2),
            tri (1, 3, 4, 2),
            tri (1, 4, 5, 2),
            tri (1, 5, 6, 2),
            tri (1, 6, 7, 2),
            tri (1, 7, 2, 2),
            tri (38, 9, 10, 1),
            tri (38, 9, 13, 1),
            tri (38, 12, 13, 1),
            tri (38, 12, 16, 1),
            tri (38, 15, 16, 1),
            tri (38, 15, 19, 1),
            tri (38, 18, 19, 1),
            tri (38, 18, 22, 1),
            tri (38, 21, 22, 1),
            tri (38, 21, 25, 1),
            tri (38, 24, 25, 1),
            tri (38, 24, 28, 1),
            tri (38, 27, 28, 1),
            tri (38, 27, 31, 1),
            tri (38, 30, 31, 1),
            tri (38, 30, 34, 1),
            tri (38, 33, 34, 1),
            tri (38, 33, 37, 1),
            tri (38, 36, 37, 1),
            tri (38, 36, 40, 1),
            tri (38, 39, 40, 1),
            tri (38, 39, 10, 1),
            tri (65, 42, 43, 1),
            tri (65, 42, 46, 1),
            tri (65, 45, 46, 1),
            tri (65, 45, 49, 1),
            tri (65, 48, 49, 1),
            tri (65, 48, 52, 1),
            tri (65, 51, 52, 1),
            tri (65, 51, 55, 1),
            tri (65, 54, 55, 1),
            tri (65, 54, 58, 1),
            tri (65, 57, 58, 1),
            tri (65, 57, 61, 1),
            tri (65, 60, 61, 1),
            tri (65, 60, 64, 1),
            tri (65, 63, 64, 1),
            tri (65, 63, 67, 1),
            tri (65, 66, 67, 1),
            tri (65, 66, 43, 1),
            tri (80, 69, 70, 1),
            tri (80, 69, 73, 1),
            tri (80, 72, 73, 1),
            tri (80, 72, 76, 1),
            tri (80, 75, 76, 1),
            tri (80, 75, 79, 1),
            tri (80, 78, 79, 1),
            tri (80, 78, 82, 1),
            tri (80, 81, 82, 1),
            tri (80, 81, 70, 1),
            tri (83, 85, 86, 3),
            tri (83, 85, 88, 3),
            tri (84, 85, 86, 3),
            tri (84, 85, 88, 3),
            tri (83, 87, 88, 3),
            tri (83, 87, 90, 3),
            tri (84, 87, 88, 3),
            tri (84, 87, 90, 3),
            tri (83, 89, 90, 3),
            tri (83, 89, 92, 3),
            tri (84, 89, 90, 3),
            tri (84, 89, 92, 3),
            tri (83, 91, 92, 3),
            tri (83, 91, 94, 3),
            tri (84, 91, 92, 3),
            tri (84, 91, 94, 3),
            tri (83, 93, 94, 3),
            tri (83, 93, 86, 3),
            tri (84, 93, 94, 3),
            tri (84, 93, 86, 3)
        )
in
    run_cga (75, 94, vert, tri) ;
    0
end
