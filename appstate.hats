abst@ype app

typedef struct app = $extype_struct "app" of {
  tri_outline_min = int,
  tri_outline_max = int,
  tri_outline = arrszref(int),

  vp_dir = int,
  vp_matrix = arrszref(int)
};
