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

fn insert_into
  {x : int | 0 <= x}
  (lst : &rclist_vt (struct_d_list_ent, x),
   new_span : struct_d_list_ent
  ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = let

  fun copy_rest
    {x : int | 0 <= x}
    (lst : !rclist_vt (struct_d_list_ent, x)
    ) : rclist_vt (struct_d_list_ent, x) =
    case+ lst of
    | rclist_vt_nil () => NIL
    | rclist_vt_cons (head, tail) => head :: copy_rest tail

  fun insert_into_inner
    {x : int | 0 <= x}
    (lst : !rclist_vt (struct_d_list_ent, x), new_span : struct_d_list_ent
    ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = let

    (* While the list is obscured, keep skipping parts of the tail, then
     * find the balance of new_span and reenter insert_into_iter
     *)
    fun eat_while_obscured
      {x : int | 0 <= x}
      (new_span : struct_d_list_ent,
       lst : !rclist_vt (struct_d_list_ent, x)
      ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = begin
      case+ lst of
      | rclist_vt_nil () => new_span :: NIL
      | rclist_vt_cons (head, tail) => begin
        if head.depth < new_span.depth then
          let
            val updated_span = d_list_ent (new_span.color, head.until_x, new_span.until_x, new_span.depth)
          in
            insert_into_inner (lst, updated_span)
          end
        else
          eat_while_obscured (new_span, tail)
      end
    end    

    fun weave_into_inner
      {x : int | 0 <= x}
      (new_span : struct_d_list_ent,
       head : struct_d_list_ent,
       tail : !rclist_vt (struct_d_list_ent, x)
      ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = begin
      if head.at_x = new_span.at_x then
        if head.until_x = new_span.until_x then
          if head.depth < new_span.depth then
            head :: (copy_rest tail)
          else
            new_span :: (copy_rest tail)
        else if head.until_x < new_span.until_x then
          if head.depth < new_span.depth then
            (* head obscures first part of new_span *)
            let
              val updated_new_span = d_list_ent (new_span.color, head.until_x, new_span.until_x, new_span.depth)
            in
              head :: (insert_into_inner (tail, updated_new_span))
            end
          else
            eat_while_obscured (new_span, tail)
        else
          if head.depth < new_span.depth then
            head :: (copy_rest tail)
          else
            new_span :: copy_rest tail
      else if head.at_x < new_span.at_x then
        if head.depth < new_span.depth then
          let
            val updated_span = d_list_ent (new_span.color, head.until_x, new_span.until_x, new_span.depth)
          in
            head :: insert_into_inner (tail, updated_span)
          end
        else
          let
            val updated_head = d_list_ent (head.color, new_span.at_x, head.until_x, head.depth)
          in
            updated_head :: insert_into_inner (tail, new_span)
          end
      else
        if head.depth < new_span.depth then
          let
            val updated_span = d_list_ent (new_span.color, head.until_x, new_span.until_x, new_span.depth)
          in
            head :: insert_into_inner (tail, updated_span)
          end
        else
          let
            val updated_head = d_list_ent (head.color, new_span.at_x, head.until_x, head.depth)
          in
            updated_head :: insert_into_inner (tail, new_span)
          end
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
        if new_span.until_x < head.at_x then
          head :: copy_rest tail
        else if head.until_x < new_span.at_x then
          head :: insert_into_inner (tail, new_span)
        else
          weave_into_inner (new_span, head, tail)
  end

in
  insert_into_inner (lst, new_span)
end
