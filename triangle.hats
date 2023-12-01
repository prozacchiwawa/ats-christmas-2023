fn get_second_and_third_choices (first : int) : (int, int) = let
  val second_choice : int = if first = 0 then 1 else 0
  val third_choice : int =
    case+ (first, second_choice) of
    | (0,1) => 2
    | (1,0) => 2
    | (0,2) => 1
    | (_,_) => 1
in
  (second_choice, third_choice)
end

fn prim_triangle_decomp (ax : int, ay : int, bx : int, by : int, cx : int, cy : int) : struct_triangle_decomp = let
  var decomp : struct_triangle_decomp
in
  decomp.ax := ax;
  decomp.ay := ay;
  decomp.bx := bx;
  decomp.by := by;
  decomp.cx := cx;
  decomp.cy := cy;
  decomp.a_eq_b := (if ay = by then 1 else 0);
  decomp.b_eq_c := (if by = cy then 1 else 0);
  decomp
end

fn second_third_choice (q2y : int, q3y : int, second_choice : int, third_choice : int): (int, int) = let
  val second : int =
    if q2y <= q3y then
      second_choice
    else
      third_choice
  val third =
    if eq_g0int_int (second, second_choice) then
      third_choice
    else
      second_choice
in
  (second, third)
end

fn fixup_decomp (d : !struct_triangle_decomp) : struct_triangle_decomp = let
  val first =
    if d.ay <= d.by && d.ay <= d.cy then 0
    else if d.by <= d.ay && d.by <= d.cy then 1
    else 2
  val (second_choice, third_choice) = get_second_and_third_choices first
  val (p1x, p1y) = choose_point (d, first)
  val (q2x, q2y) = choose_point (d, second_choice)
  val (q3x, q3y) = choose_point (d, third_choice)
  val (second, third) = second_third_choice (q2y, q3y, second_choice, third_choice)
  val third = (if second = second_choice then third_choice else second_choice)
  val (p2x, p2y) = choose_point (d, second)
  val (p3x, p3y) = choose_point (d, third)
in
  prim_triangle_decomp (p1x, p1y, p2x, p2y, p3x, p3y)
end

fn decompose_triangle (ax : int, ay : int, bx : int, by : int, cx : int, cy : int) : struct_triangle_decomp = let
  val primt = prim_triangle_decomp (ax, ay, bx, by, cx, cy)
in
  fixup_decomp primt
end

fn get_xa_xb (xa : int, xb : int) : (int, int) =
  if xa < xb then
    (xa, xb)
  else
    (xb, xa)



fn insert_raster (color : int, depth : int, y : int, xa : int, xb : int) = let 
  val (x1, x2) = get_xa_xb (xa, xb)
  val old_list = get_line_ptr (y, NIL)
  val new_list = insert_into (old_list, d_list_ent (color, x1, x2, depth))
  val empty_list = get_line_ptr (y, new_list)
in
  consume_list empty_list ;
  consume_list old_list
end

fn make_triangle (color : int, ax : int, ay : int, bx : int, by : int, cx : int, cy : int, depth : int) : void = let
  val decomp = decompose_triangle (ax, ay, bx, by, cx, cy)
in
  if decomp.cy = decomp.ay then
    ()
  else
    let
      val ac_y_pct = (65536 * (decomp.by - decomp.ay)) / (decomp.cy - decomp.ay)
      val cx_at_by = decomp.ax + ((ac_y_pct * (decomp.cx - decomp.ax)) / 65536)

      fun rasterize_lines {k : int | 0 <= k} .<k>. (color : int, depth : int, uy : int, ly : int, lux : int, llx : int, rux : int, rlx : int, max_count : int(k)) = let
        val mid_lx = (lux + llx) / 2
        val mid_rx = (rux + rlx) / 2
        val mid_y = (uy + ly) / 2
      in
        if max_count = 0 then
          ()
        else if uy = ly then
          ()
        else
          let
            val () =
              if mid_y >= 0 && mid_y < 200 then
                insert_raster (color, depth, mid_y, mid_lx, mid_rx)
              else
                ()
                
            val () =
              if uy < (mid_y - 1) then
                begin
                  rasterize_lines (color, depth, uy, mid_y, lux, mid_lx, rux, mid_rx, max_count - 1)
                end
              else
                ()
          in
            if mid_y < (ly - 1) then
              begin
                rasterize_lines (color, depth, mid_y, ly, mid_lx, llx, mid_rx, rlx, max_count - 1)
              end
            else
              ()
          end
      end

      val _ =
        if decomp.by >= 0 && decomp.by < 200 then
          insert_raster (color, depth, decomp.by, decomp.bx, cx_at_by)
        else
          ()
    in
      rasterize_lines (color, depth, decomp.ay, decomp.by, decomp.ax, decomp.bx, decomp.ax, cx_at_by, 200) ;
      rasterize_lines (color, depth, decomp.by, decomp.cy, decomp.bx, decomp.cx, cx_at_by, decomp.cx, 200)
    end
end

fn normal_z (p1: struct_vertex, p2: struct_vertex, p3: struct_vertex): int = let
    val ax = p2.x - p1.x
    val ay = p2.y - p1.y
    val bx = p3.x - p1.x
    val by = p3.y - p1.y
in
    (ax * by) - (ay * bx)
end

fn draw_triangles
   {st : int | 0 <= st}
  (  start_tri: int(st),
     last_vtx: int,
     location: struct_vertex,
     angle: int,
     vtx: !arrszref(struct_vertex),
     tri: !arrszref(struct_triangle)
  ): void = let
  fun do_one_triangle
    {idx : int | 0 <= idx}
    .<idx>.
    ( vtx: !arrszref(struct_vertex),
      tri: !arrszref(struct_triangle),
      n : int(idx)
    ): void = let

    val the_tri = get_triangle (tri, n)
    val the_tri_a : int = g1ofg0_int (the_tri.a)
    val the_tri_b : int = g1ofg0_int (the_tri.b)
    val the_tri_c : int = g1ofg0_int (the_tri.c)
    val vtx_a : struct_vertex = transform_vtx (angle, location, get_any_vertex (last_vtx, vtx, the_tri_a))
    val vtx_b : struct_vertex = transform_vtx (angle, location, get_any_vertex (last_vtx, vtx, the_tri_b))
    val vtx_c : struct_vertex = transform_vtx (angle, location, get_any_vertex (last_vtx, vtx, the_tri_c))
    val depth = (vtx_a.z + vtx_b.z + vtx_c.z) / 3
    val _ =
        if nonzero_vtx(vtx_a) && nonzero_vtx(vtx_b) && nonzero_vtx(vtx_c) && normal_z (vtx_a, vtx_b, vtx_c) > 0 then
            make_triangle (the_tri.color, vtx_a.x, vtx_a.y, vtx_b.x, vtx_b.y, vtx_c.x, vtx_c.y, depth)
        else
            ()
  in
    if n <= 0 then
      ()
    else
      do_one_triangle (vtx, tri, (n - 1))
  end
in
  do_one_triangle (vtx, tri, start_tri)
end

fn show_rasterize_info () = let
 fun show_r_info {k : int | 0 <= k} .<k>. (y : int, count : int(k)) =
   if count = 0 then
     ()
   else
     let
       val this_lst = get_line_ptr (y, NIL)
     in
       println! (y, " line") ;
       write_list this_lst ;
       consume_list this_lst ;
       show_r_info (y + 1, count - 1)
     end
in
  show_r_info (0, 199)
end
