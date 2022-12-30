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
  if cy = ay then
    ()
  else
    let
      val ac_y_pct = (65536 * (by - ay)) / (cy - ay)
      val cx_at_y = ax + ((ac_y_pct * (cx - ax)) / 65536)
    
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
            val () = insert_raster (color, depth, mid_y, mid_lx, mid_rx)
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

    in
      rasterize_lines (color, depth, ay, by, ax, bx, ax, cx_at_y, 200) ;
      rasterize_lines (color, depth, by, cy, bx, cx, cx_at_y, cx, 200)
    end
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