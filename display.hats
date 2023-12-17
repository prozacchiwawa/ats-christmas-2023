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

fn write_list {x : nat} (lst : !rclist_vt (struct_d_list_ent, x)): void = let
  fun loop_over_ents {k : nat} .<k>. (lst : !rclist_vt (struct_d_list_ent, k)) : void =
    case+ lst of
    | NIL => ()
    | head :: tail => begin
      loop_over_ents tail
    end

in
  loop_over_ents lst
end

fn copy_rest
  {x : int | 0 <= x}
  (lst : !rclist_vt (struct_d_list_ent, x)
  ) : rclist_vt (struct_d_list_ent, x) = let
  fun cr
    {x : int | 0 <= x}
    (lst : !rclist_vt (struct_d_list_ent, x)
    ) : rclist_vt (struct_d_list_ent, x) =
    case+ lst of
    | rclist_vt_nil () => NIL
    | rclist_vt_cons (head, tail) => head :: cr tail
in
  cr lst
end

fn debug_color (head: struct_d_list_ent, debug: bool): struct_d_list_ent = let
  val color = if debug then 8 else head.color
in
  d_list_ent (color, head.until_x, head.until_x, head.depth)
end

fn insert_into
  {x : int | 0 <= x}
  (lst : !rclist_vt (struct_d_list_ent, x),
   new_span : struct_d_list_ent, debug : bool
  ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = let

  (* head and new span have the same span *)
  fun handle_equal_spans
    {x : int | 0 <= x}
    (new_span : struct_d_list_ent,
     head : struct_d_list_ent,
     tail : !rclist_vt (struct_d_list_ent, x)
    ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = begin
    if head.depth < new_span.depth then
        head :: (copy_rest tail)
    else
        new_span :: (copy_rest tail)
  end

  fun insert_into_inner
    {x : int | 0 <= x}
    (lst : !rclist_vt (struct_d_list_ent, x), new_span : struct_d_list_ent, debug : bool
    ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = let

        fun weave_into_inner
                {x : int | 0 <= x}
                (new_span : struct_d_list_ent,
                 head : struct_d_list_ent,
                 tail : !rclist_vt (struct_d_list_ent, x),
                 debug : bool
                ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = let

          (* new_span is longer than head but they start at the same x *)
          fun handle_start_overlap
                  {x : int | 0 <= x}
                  (new_span : struct_d_list_ent,
                   head : struct_d_list_ent,
                   tail : !rclist_vt (struct_d_list_ent, x),
                   debug : bool
                  ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = begin
              if new_span.depth < head.depth then
                  insert_into_inner(tail, new_span, debug)
              else
                  let
                      val updated_span = d_list_ent (new_span.color, head.until_x, new_span.until_x, new_span.depth)
                  in
                      head :: insert_into_inner(tail, updated_span, debug)
                  end
          end

          (* new_span is longer than head but they end at the same x *)
          fun handle_end_overlap
                  {x : int | 0 <= x}
                  (new_span : struct_d_list_ent,
                   head : struct_d_list_ent,
                   tail : !rclist_vt (struct_d_list_ent, x)
                  ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = begin
              if new_span.depth < head.depth then
                  new_span :: (copy_rest tail)
              else
                  let
                      val updated_span = d_list_ent (new_span.color, new_span.at_x, head.at_x, new_span.depth)
                  in
                      updated_span :: head :: (copy_rest tail)
                  end
          end

          (* new_span is within head *)
          fun handle_mid_overlap
                  {x : int | 0 <= x}
                  (new_span : struct_d_list_ent,
                   head : struct_d_list_ent,
                   tail : !rclist_vt (struct_d_list_ent, x),
                   debug : bool
                  ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = begin
              if head.depth < new_span.depth then
                  (* head dominates new_span *)
                  insert_into_inner(tail, head, debug)
              else
                  (* head is broken by new span *)
                  let
                      val head_1 = d_list_ent (head.color, head.at_x, new_span.at_x, head.depth)
                      val head_2 = d_list_ent (head.color, new_span.until_x, head.until_x, head.depth)
                  in
                      head_1 :: new_span :: insert_into_inner(tail, head_2, debug)
                  end
          end

          (* new_span overlaps the beginning of head *)
          fun handle_overlap
                  {x : int | 0 <= x}
                  (new_span : struct_d_list_ent,
                   head : struct_d_list_ent,
                   tail : !rclist_vt (struct_d_list_ent, x),
                   debug : bool
                  ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = begin
              if head.depth < new_span.depth then
                  let
                      val updated_span = d_list_ent (new_span.color, new_span.at_x, head.at_x, new_span.depth)
                  in
                      updated_span :: insert_into_inner(tail, head, debug)
                  end
              else
                  let
                      val updated_head = d_list_ent (head.color, new_span.until_x, head.until_x, head.depth)
                  in
                      new_span :: insert_into_inner(tail, updated_head, debug)
                  end
          end
in
    if head.at_x = new_span.at_x then
        (* head starts at the same X value as head *)

        if head.until_x = new_span.until_x then
            handle_equal_spans (new_span, head, tail)
        else if head.until_x > new_span.until_x then
            handle_start_overlap (head, new_span, tail, debug)
        else (* head.until_x < new_span.until_x *)
            handle_start_overlap (new_span, head, tail, debug)
    else if head.at_x < new_span.at_x then
        if head.until_x = new_span.until_x then
            handle_end_overlap (head, new_span, tail)
        else if head.until_x > new_span.until_x then
            handle_mid_overlap (new_span, head, tail, false)
        else (* head.until_x < new_span.until_x *)
            handle_overlap (head, new_span, tail, false)
    else (* head.at_x > new_span.at_x *)
        if head.until_x = new_span.until_x then
            handle_end_overlap (new_span, head, tail)
        else if head.until_x > new_span.until_x then
            handle_overlap (new_span, head, tail, false)
        else (* head.until_x < new_span.until_x *)           
            handle_mid_overlap (head, new_span, tail, true)
  end

in

    if new_span.until_x <= new_span.at_x then
      case+ lst of
      | rclist_vt_nil () => NIL
      | rclist_vt_cons (head, tail) => head :: copy_rest tail
    else
      case+ lst of
      | rclist_vt_nil () => new_span :: NIL
      | rclist_vt_cons (head, tail) =>
        if head.until_x <= new_span.at_x then
          (* head is completely before new_span *)
          head :: insert_into_inner (tail, new_span, debug)
        else
          weave_into_inner (new_span, head, tail, debug)
  end

  val result = insert_into_inner (lst, new_span, debug)
in
  result
end

extern fun preload_scanlines (n : rclist_vt(struct_d_list_ent, 0)): void = "preload_scanlines"
extern fun get_line_ptr {j : int | 0 <= j} {l:addr} (i: int, replacement: rclist_vt(struct_d_list_ent, j)): [k : int | 0 <= k] rclist_vt(struct_d_list_ent, k) = "get_line_ptr"
