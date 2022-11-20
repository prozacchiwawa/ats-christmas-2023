absvtype d_list_ent_ptr(l:addr) = ptr(l)
typedef d_list_ent = $extype_struct "struct d_list_ent" of {
  next_ent = [l:addr] ptr(l), color = int, at_x = int
};

extern castfn takeout_d_list_ent_ptr {l:agz} (p: ptr(l)): d_list_ent_ptr(l)
extern castfn putback_d_list_ent_ptr {l:agz} (x: d_list_ent_ptr(l)): void
extern castfn takeout_d_list_ent {l:agz} (p: !d_list_ent_ptr(l)): (d_list_ent@l | ptr(l))
extern castfn putback_d_list_ent {l:agz} (pf: d_list_ent@l | addr: ptr(l)): void

fun{} d_list_ent_get_next {l1:agz} (x: !d_list_ent_ptr(l1)): [l2:addr] ptr(l2) = ret where {
  val (pf | p) = takeout_d_list_ent (x)
  val ret = p->next_ent
  val () = putback_d_list_ent (pf | p)
}
fun{} d_list_ent_set_next {l1,l2:agz} (x: !d_list_ent_ptr(l1), v: ptr(l2)): void = {
  val (pf | p) = takeout_d_list_ent (x)
  val () = p->next_ent := v
  val () = putback_d_list_ent (pf | p)
}
overload .next_ent with d_list_ent_get_next
overload .next_ent with d_list_ent_set_next
