typedef struct vertex = $extype_struct "struct vertex" of {
  x = int, y = int, z = int, tf_x = int, tf_y = int, tf_z = int
};

typedef struct pt = $extype_struct "struct pt" of {
  x = int, y = int
};

// Declare as abstract type and concrete struct
abst@ype tri_idx

typedef struct tri_idx = $extype_struct "tri_idx" of {
  v1 = int, v2 = int, v3 = int
};

assume tri_idx = tri_idx

typedef struct triangle = $extype_struct "struct triangle" of {
  v_idx = tri_idx, color = int, min_z = int
};
