(*------------------------------------------------------------------*)

(* The Rosetta Code linear list type can contain any vt@ype.
   (The ‘@’ means it doesn’t have to be the size of a pointer.
   You can read {0 <= n} as ‘for all non-negative n’. *)
dataviewtype rclist_vt (vt : vt@ype+, n : int) =
| rclist_vt_nil (vt, 0)
| {0 <= n} rclist_vt_cons (vt, n + 1) of (vt, rclist_vt (vt, n))

(* A lemma one will need: lists never have negative lengths. *)
extern prfun {vt : vt@ype}
lemma_rclist_vt_param
          {n : int}
          (lst : !rclist_vt (vt, n)) :<prf> [0 <= n] void

(* Proof of the lemma. *)
primplement {vt}
lemma_rclist_vt_param lst =
  case+ lst of
  | rclist_vt_nil () => ()
  | rclist_vt_cons _ => ()

(*------------------------------------------------------------------*)

(* For simplicity, the Rosetta Code linear list insertion routine will
   be specifically for lists of ‘int’. We shall not take advantage of
   the template system. *)

(* Some things that will be needed. *)
#include "share/atspre_staload.hats"

(* The list is passed by reference and will be replaced by the new
   list. The old list is invalidated. *)
extern fun rclist_int_insert
          {m     : int}         (* ‘for all list lengths m’ *)
          (lst   : &rclist_vt (int, m) >> (* & = pass by reference *)
                      (* The new type will be a list of the same
                         length (if no match were found) or a list
                         one longer. *)
                      [n : int | n == m || n == m + 1]
                      rclist_vt (int, n),
           after : int,
           x     : int) :<!wrt> void

implement rclist_int_insert {m} (lst, after, x) =
  {
    (* A recursive nested function that finds the matching element
       and inserts the new node. *)
    fun
    find {k : int | 0 <= k}
         .<k>. (* Means: ‘k must uniformly decrease towards zero.’
                  If so, that is proof that ‘find’ terminates. *)
         (lst   : &rclist_vt (int, k) >>
                      [j : int | j == k || j == k + 1]
                      rclist_vt (int, j),
          after : int,
          x     : int) :<!wrt> void =
      case+ lst of
      | rclist_vt_nil () => ()  (* Not found. Do nothing *)
      | @ rclist_vt_cons (head, tail) when head = after =>
        {
          val _ = tail := rclist_vt_cons (x, tail)
          prval _ = fold@ lst (* I need this unfolding and refolding
                                 stuff to make ‘tail’ a reference
                                 rather than a value, so I can
                                 assign to it. *)
        }
      | @ rclist_vt_cons (head, tail) =>
        {
          val _ = find (tail, after, x)
          prval _ = fold@ lst
        }

    (* The following is needed to prove that the initial k above
       satisfies 0 <= k. *)
    prval _ = lemma_rclist_vt_param lst

    val _ = find (lst, after, x)
  }
  absvtype d_list_ent_ptr(l:addr) = ptr(l)

#define NIL rclist_vt_nil ()
#define :: rclist_vt_cons
overload insert with rclist_int_insert

fun {a : vt@ype} consume_list {x : nat} (lst : rclist_vt (a?, x)): void =
  case+ lst of
    | ~rclist_vt_nil () => ()
    | ~rclist_vt_cons (elt, tail) =>
        begin
          consume_list<a> (tail)
        end
