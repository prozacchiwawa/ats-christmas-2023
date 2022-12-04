%{^

struct d_list_ent {
  int color;
  int at_x;
};

%}

absvt@ype struct_d_list_ent
vtypedef struct_d_list_ent_impl = $extype_struct"struct d_list_ent" of {
  color = int,
  at_x = int
}
assume struct_d_list_ent = struct_d_list_ent_impl