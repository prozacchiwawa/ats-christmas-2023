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
