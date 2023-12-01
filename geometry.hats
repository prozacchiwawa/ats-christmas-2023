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

val sincostable = (arrszref)$arrpsz{int}(
  100000, 165536,
  101613, 165516,
  103226, 165456,
  104836, 165357,
  106444, 165218,
  108047, 165039,
  109646, 164822,
  111239, 164564,
  112826, 164268,
  114404, 163933,
  115974, 163559,
  117534, 163146,
  119083, 162696,
  120621, 162207,
  122146, 161680,
  123658, 161116,
  125155, 160515,
  126638, 159877,
  128104, 159203,
  129553, 158494,
  130984, 157748,
  132397, 156968,
  133789, 156153,
  135162, 155304,
  136512, 154422,
  137841, 153506,
  139147, 152558,
  140429, 151579,
  141687, 150568,
  142919, 149526,
  144126, 148454,
  145305, 147353,
  146457, 146223,
  147581, 145065,
  148676, 143880,
  149742, 142669,
  150777, 141431,
  151782, 140168,
  152755, 138881,
  153697, 137571,
  154605, 136237,
  155481, 134882,
  156323, 133505,
  157131, 132108,
  157904, 130692,
  158642, 129257,
  159345, 127805,
  160011, 126335,
  160641, 124850,
  161235, 123349,
  161791, 121834,
  162310, 120306,
  162791, 118766,
  163234, 117214,
  163639, 115652,
  164005, 114081,
  164332, 112501,
  164620, 110913,
  164870, 109319,
  165079, 107719,
  165250, 106114,
  165380, 104506,
  165472, 102895,
  165523, 101282,
  165535, 99670,
  165507, 98056,
  165439, 96444,
  165332, 94834,
  165185, 93227,
  164998, 91624,
  164772, 90026,
  164507, 88435,
  164203, 86850,
  163859, 85273,
  163477, 83706,
  163057, 82148,
  162598, 80601,
  162102, 79065,
  161567, 77543,
  160996, 76034,
  160387, 74539,
  159742, 73060,
  159061, 71598,
  158344, 70152,
  157591, 68725,
  156804, 67316,
  155982, 65928,
  155126, 64560,
  154237, 63213,
  153314, 61889,
  152360, 60588,
  151374, 59311,
  150356, 58058,
  149308, 56831,
  148231, 55630,
  147124, 54456,
  145988, 53310,
  144825, 52192,
  143634, 51103,
  142417, 50043,
  141174, 49014,
  139906, 48016,
  138614, 47049,
  137299, 46114,
  135961, 45212,
  134601, 44344,
  133220, 43509,
  131819, 42708,
  130399, 41942,
  128961, 41211,
  127504, 40516,
  126032, 39857,
  124543, 39234,
  123039, 38648,
  121522, 38099,
  119991, 37588,
  118449, 37115,
  116895, 36680,
  115331, 36283,
  113757, 35925,
  112176, 35606,
  110587, 35325,
  108991, 35084,
  107390, 34883,
  105785, 34720,
  104176, 34598,
  102564, 34515,
  100951, 34471,
  99339, 34468,
  97725, 34504,
  96114, 34580,
  94504, 34695,
  92898, 34851,
  91296, 35045,
  89699, 35279,
  88109, 35552,
  86526, 35865,
  84951, 36216,
  83385, 36606,
  81830, 37034,
  80285, 37500,
  78752, 38005,
  77232, 38547,
  75726, 39126,
  74235, 39742,
  72759, 40395,
  71300, 41083,
  69858, 41808,
  68434, 42568,
  67030, 43362,
  65645, 44191,
  64282, 45054,
  62940, 45950,
  61620, 46879,
  60324, 47840,
  59052, 48832,
  57804, 49856,
  56583, 50910,
  55387, 51994,
  54219, 53107,
  53078, 54248,
  51966, 55417,
  50883, 56614,
  49830, 57836,
  48807, 59084,
  47815, 60357,
  46855, 61654,
  45927, 62974,
  45031, 64316,
  44170, 65680,
  43342, 67065,
  42548, 68470,
  41789, 69894,
  41065, 71337,
  40378, 72796,
  39726, 74272,
  39111, 75764,
  38532, 77271,
  37991, 78791,
  37488, 80324,
  37023, 81869,
  36595, 83425,
  36206, 84991,
  35856, 86566,
  35545, 88150,
  35273, 89740,
  35040, 91337,
  34846, 92939,
  34692, 94545,
  34577, 96155,
  34503, 97766,
  34467, 99380,
  34472, 100992,
  34516, 102605,
  34600, 104217,
  34724, 105826,
  34887, 107431,
  35090, 109032,
  35332, 110627,
  35613, 112216,
  35934, 113798,
  36293, 115371,
  36690, 116935,
  37127, 118488,
  37601, 120031,
  38113, 121561,
  38662, 123078,
  39249, 124581,
  39873, 126069,
  40533, 127542,
  41229, 128998,
  41961, 130436,
  42728, 131855,
  43529, 133256,
  44365, 134636,
  45235, 135995,
  46138, 137333,
  47073, 138648,
  48041, 139939,
  49040, 141206,
  50070, 142448,
  51130, 143665,
  52220, 144855,
  53339, 146017,
  54486, 147152,
  55661, 148259,
  56862, 149336,
  58090, 150383,
  59343, 151399,
  60621, 152385,
  61922, 153338,
  63247, 154260,
  64594, 155148,
  65963, 156003,
  67352, 156824,
  68761, 157611,
  70189, 158362,
  71635, 159079,
  73098, 159759,
  74577, 160403,
  76072, 161011,
  77581, 161582,
  79104, 162115,
  80640, 162610,
  82187, 163068,
  83745, 163488,
  85313, 163869,
  86890, 164211,
  88475, 164514,
  90067, 164778,
  91665, 165003,
  93268, 165189,
  94875, 165335,
  96485, 165441,
  98097, 165508,
  99711, 165535
)
  
fn get_sin_cos (angle: int): (int, int) = let
  val truncated_selection = angle % 256
in
  if truncated_selection > 255 then
    (0,0)
  else
    let
      val s = sincostable[2 * truncated_selection] - 100000
      val c = sincostable[2 * truncated_selection + 1] - 100000
    in
      (s / 256, c / 256)
    end
end

fn choose_point (d : !struct_triangle_decomp, idx : int): (int, int) =
  if idx = 0 then
    (d.ax, d.ay)
  else if idx = 1 then
    (d.bx, d.by)
  else
    (d.cx, d.cy)

%{^

struct vertex {
  int x;
  int y;
  int z;
};

%}

absvt@ype struct_vertex
vtypedef struct_vertex_impl = $extype_struct"struct vertex" of {
  x = int,
  y = int,
  z = int
}

assume struct_vertex = struct_vertex_impl

%{^

struct triangle {
  int color;
  int a;
  int b;
  int c;
};

%}

absvt@ype struct_triangle
vtypedef struct_triangle_impl = $extype_struct"struct triangle" of {
  color = int,
  a = int,
  b = int,
  c = int
}

assume struct_triangle = struct_triangle_impl

fn tri (a : int, b : int, c : int, color : int): struct_triangle = let
  var tri : struct_triangle
in
  tri.a := a ;
  tri.b := b ;
  tri.c := c ;
  tri.color := color ;
  tri
end

fn transform_vtx (angle : int, location : struct_vertex, vtx : struct_vertex) : struct_vertex = let
  var out : struct_vertex

  val (dsin, dcos) = get_sin_cos (angle)

  // (xe * dcose / e) - (ze * sine / e) = ((x * dcos) - (z * sin)) / e
  val dx = vtx.x - location.x
  val dy = vtx.y - location.y
  val dz = vtx.z - location.z
  val imed1 = ((dx * dcos) - (dz * dsin)) / 256
  val zdist = 0 - (((dz * dcos) + (dx * dsin)) / 256)
  val _ =
    if zdist > 3000 then
      begin
        out.z := zdist ;
        out.x := 160 + ((256 * imed1) / zdist) ;
        out.y := 100 - ((256 * dy) / zdist)
      end
    else
      begin
        out.z := 0 ;
        out.x := 0 ;
        out.y := 0
      end
in
  out
end

fn nonzero_vtx (vtx: struct_vertex) : bool = vtx.z > 3000

fn vertex (x : int, y : int, z : int): struct_vertex = let
  var vtx : struct_vertex
in
  vtx.x := x ;
  vtx.y := y ;
  vtx.z := z ;
  vtx
end

fn get_vertex {idx: int | 0 <= idx} (tri: !arrszref(struct_vertex), n : int(idx)) : struct_vertex =
  arrszref_get_at_gint (tri, n)

fn get_triangle {idx: int | 0 <= idx} (vtx: !arrszref(struct_triangle), n : int(idx)) : struct_triangle =
  arrszref_get_at_gint (vtx, n)

fn zero_vertex () : struct_vertex = let
  var vtx : struct_vertex
in
  vtx.x := 0 ;
  vtx.y := 0 ;
  vtx.z := 0 ;
  vtx
end

fn get_any_vertex
  {idx : int}
  (  last_vtx : int,
     vtx : !arrszref(struct_vertex),
     n : int(idx)
  ) : struct_vertex =
    if n < 0 then
      zero_vertex ()
    else if n > last_vtx then
      zero_vertex ()
    else
      get_vertex (vtx, n)

