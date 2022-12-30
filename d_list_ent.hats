%{^

struct d_list_ent {
  int color;
  int at_x;
  int until_x;
  int depth;
};

%}

absvt@ype struct_d_list_ent
vtypedef struct_d_list_ent_impl = $extype_struct"struct d_list_ent" of {
  color = int,
  at_x = int,
  until_x = int,
  depth = int
}
assume struct_d_list_ent = struct_d_list_ent_impl

fn d_list_ent (color : int, at_x : int, until_x : int, depth : int): struct_d_list_ent = let
  var dle: struct_d_list_ent
in
  dle.color := color ;
  dle.at_x := at_x ;
  dle.until_x := until_x ;
  dle.depth := depth ;
  dle
end

%{^

struct ptr_holder {
  int v;
};

%}

absvt@ype struct_ptr_holder
vtypedef struct_ptr_holder_impl = $extype_struct"struct ptr_holder" of {
  v = int
}
assume struct_ptr_holder = struct_ptr_holder_impl

%{^

struct triangle_decomp {
  int ax;
  int ay;
  int bx;
  int by;
  int cx;
  int cy;
  int a_eq_b;
  int b_eq_c;
 };

%}

absvt@ype struct_triangle_decomp
vtypedef struct_triangle_decomp_impl = $extype_struct"struct triangle_decomp" of {
  ax = int,
  ay = int,
  bx = int,
  by = int,
  cx = int,
  cy = int,
  a_eq_b = int,
  b_eq_c = int
}
assume struct_triangle_decomp = struct_triangle_decomp_impl

fn choose_point (d : !struct_triangle_decomp, idx : int): (int, int) =
  if idx = 0 then
    (d.ax, d.ay)
  else if idx = 1 then
    (d.bx, d.by)
  else
    (d.cx, d.cy)

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