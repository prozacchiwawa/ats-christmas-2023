fn display_from_list_to_scan_line {x : nat} (cga : ptr) (y : int) (lst : !rclist_vt (struct_d_list_ent, x)): void = let
  fun loop_over_ents {k : nat} .<k>. (lst : !rclist_vt (struct_d_list_ent, k)) : void =
    case+ lst of
    | NIL => ()
    | head :: tail =>
       case+ tail of
       | next :: t =>
           begin
             write_color(cga, y, head.color, next.at_x, head.at_x) ;
             loop_over_ents tail
           end
       | NIL =>
           begin
             write_color(cga, y, head.color, 320, head.at_x) ;
             loop_over_ents tail
           end
in
  loop_over_ents lst
end