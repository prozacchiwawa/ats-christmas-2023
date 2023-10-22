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
            vertex (m_500(), 0, m_500()),
            vertex (m_500(), 0, 50000),
            vertex (50000, 0, m_500()),
            vertex (50000, 0, 50000),
            vertex (0, 50000, 0)
        )

    val tri =
        (arrszref)$arrpsz{struct_triangle}(
            tri (0, 1, 4, 1),
            tri (2, 3, 4, 2),
            tri (0, 2, 4, 1),
            tri (1, 3, 4, 3)
        )
in
    run_cga (3, 4, vert, tri) ;
    0
end
