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

%{^

struct vertex {
  int x;
  int y;
  int z;
};

%}

absvt@ype struct_vertex
vtypedef struct_vertex_impl = $extype_struct"struct vertex" of {
  x = int,
  y = int,
  z = int
}

assume struct_vertex = struct_vertex_impl

%{^

struct triangle {
  int color;
  int a;
  int b;
  int c;
};

%}

absvt@ype struct_triangle
vtypedef struct_triangle_impl = $extype_struct"struct triangle" of {
  color = int,
  a = int,
  b = int,
  c = int
}

assume struct_triangle = struct_triangle_impl

fn tri (a : int, b : int, c : int, color : int): struct_triangle = let
  var tri : struct_triangle
in
  tri.a := a ;
  tri.b := b ;
  tri.c := c ;
  tri.color := color ;
  tri
end

fn transform_vtx (dcos : int, dsin : int, dist : int, height : int, vtx : struct_vertex) : struct_vertex = let
  var out : struct_vertex

  // (xe * dcose / e) - (ze * sine / e) = ((x * dcos) - (z * sin)) / e
  val imed1 = ((vtx.x * dcos) / 65536) - ((vtx.z * dsin) / 65536)
  val imed2 = ((vtx.z * dcos) / 65536) + ((vtx.x * dsin) / 65536)
in
  out.z := dist + imed2 ;
  out.x := 160 + (((65536 * imed1) / (dist + imed2))) / 250 ;
  out.y := 100 + (((65536 * (height - vtx.y)) / (dist + imed2))) / 250 ;
  out
end

fn vertex (x : int, y : int, z : int): struct_vertex = let
  var vtx : struct_vertex
in
  vtx.x := x ;
  vtx.y := y ;
  vtx.z := z ;
  vtx
end

fn get_vertex {idx: int | 0 <= idx} (tri: !arrszref(struct_vertex), n : int(idx)) : struct_vertex =
  arrszref_get_at_gint (tri, n)

fn get_triangle {idx: int | 0 <= idx} (vtx: !arrszref(struct_triangle), n : int(idx)) : struct_triangle =
  arrszref_get_at_gint (vtx, n)

fn zero_vertex () : struct_vertex = let
  var vtx : struct_vertex
in
  vtx.x := 0 ;
  vtx.y := 0 ;
  vtx.z := 0 ;
  vtx
end

fn get_any_vertex
  {idx : int}
  (  last_vtx : int,
     vtx : !arrszref(struct_vertex),
     n : int(idx)
  ) : struct_vertex =
    if n < 0 then
      zero_vertex ()
    else if n > last_vtx then
      zero_vertex ()
    else
      get_vertex (vtx, n)
