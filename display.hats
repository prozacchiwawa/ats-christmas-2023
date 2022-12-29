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

fn write_ent (c : char, head : struct_d_list_ent) =
  println! (c, " ", head.color, " at_x ", head.at_x, " until_x ", head.until_x, " depth ", head.depth)

fn write_list {x : nat} (lst : !rclist_vt (struct_d_list_ent, x)): void = let
  fun loop_over_ents {k : nat} .<k>. (lst : !rclist_vt (struct_d_list_ent, k)) : void =
    case+ lst of
    | NIL => ()
    | head :: tail => begin
      write_ent ('>', head) ;
      loop_over_ents tail
    end

in
  loop_over_ents lst
end

fn insert_into
  {x : int | 0 <= x}
  (lst : !rclist_vt (struct_d_list_ent, x),
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

    fun weave_into_inner
      {x : int | 0 <= x}
      (new_span : struct_d_list_ent,
       head : struct_d_list_ent,
       tail : !rclist_vt (struct_d_list_ent, x)
      ) : [y : int | 0 <= y] rclist_vt (struct_d_list_ent, y) = begin
      println! ("weave_into_inner") ;
      write_ent ('w', head) ;
      write_ent ('n', new_span) ;
      println! ("weave list") ;
      write_list tail ;
      println! ("weave go") ;
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
            let
              val new_head = d_list_ent (head.color, new_span.until_x, head.until_x, head.depth)
            in
              if new_head.until_x < new_head.at_x then
                insert_into_inner (tail, new_span)
              else
                let
                  val new_lst = new_head :: copy_rest tail
                  val result = insert_into_inner (new_lst, new_span)
                in
                  consume_list new_lst ;
                  result
                end
            end
        else
          if head.depth < new_span.depth then
            head :: (copy_rest tail)
          else
            let
              val updated_head = d_list_ent (head.color, new_span.until_x, head.until_x, head.depth)
              val new_tail = updated_head :: copy_rest tail
              val result = new_span :: new_tail
            in
              result
            end
      else if head.at_x < new_span.at_x then
        if head.depth < new_span.depth then
          let
            val updated_span = d_list_ent (new_span.color, head.until_x, new_span.until_x, new_span.depth)
          in
            head :: insert_into_inner (tail, updated_span)
          end
        else
          let
            val updated_head = d_list_ent (head.color, head.at_x, new_span.at_x, head.depth)
            val broken_head = d_list_ent (head.color, new_span.at_x, head.until_x, head.depth)
          in
            write_ent ('U', updated_head) ;
            write_ent ('B', broken_head) ;
            if broken_head.until_x <= broken_head.at_x then
              updated_head :: insert_into_inner (tail, new_span)
            else
              let
                val new_tail = broken_head :: copy_rest tail
                val result = updated_head :: insert_into_inner (new_tail, new_span)
              in
                consume_list new_tail ;
                result
              end
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
            val updated_head = d_list_ent (head.color, new_span.until_x, head.until_x, head.depth)
          in
            if updated_head.until_x <= updated_head.at_x then
              insert_into_inner (tail, new_span)
            else
              begin
                write_ent ('H', updated_head) ;
                new_span :: updated_head :: copy_rest tail
              end
          end
    end

  in
    println! ("insert_into_inner") ;
    write_ent ('i', new_span) ;
    write_list lst ;
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
          let
            val w = weave_into_inner (new_span, head, tail)
          in
            println! ("weave =>") ;
            write_list w ;
            w
          end
  end

  val result = insert_into_inner (lst, new_span)
in
  println! ("insert_into_inner =>") ;
  write_list result ;
  result
end
