include <oscad_utils/bolt_sizes.scad> // include to use the constants
use <oscad_utils/bolts.scad>  


// Height of the idler pulley group:
// - washer M6 DIN-9021
// - washer M4 DIN-125
// - bearing 624ZZ
// - washer M4 DIN-125
// - washer M6 DIN-9021
idler_h     = 10.8;  // no need for tolerance
//radius of the idler pulley 6mm DIN 9021 washer, the wider ones)
idler_r     = m6_wash9021_or + 2;  // or: outer radius
idler_r_xtr = idler_r + 2;  // +2: a little bit larger

// Thickness of the sides that holds the idler pulley
wall_thick = 5;


//  Length of the body, the stroke. Not including the pulley
tens_stroke = 20;

// distance between the pulley and the stroke
pulley_stroke_dist = wall_thick;

// plastic space above and bellow the nut for the screw
nut_holder_thick = 4;
// the space for the nut height, will be get multipliying this multiplier by
// the nut height 
nut_space_h_mult = 2;
nut_space = nut_space_h_mult * m4_nut_h_tol;
nut_holder_total = nut_space + 2*nut_holder_thick;

// inner fillet:
in_fillet = 2;

tens_h = idler_h + 2*wall_thick;
// old tensioner y
tens_l = (   nut_holder_total
          + tens_stroke
          + 2 * idler_r_xtr
          + pulley_stroke_dist) ;
tens_w = 2 * idler_r_xtr; 

tens_w_tol = tens_w + tol;
tens_h_tol = tens_h + tol;


// the shank for the idler pulley, 
boltidler_r_tol = m4_r_tol;
// the screw for tensioning the pulley 
bolttens_r_tol = m4_r_tol;

//aluprof_bolt_head_r_tol = m3_head_r_tol;
//aluprof_bolt_r_tol = m3_r_tol;
//aluprof_bolt_head_l = m3_head_l;
// bolt size to attach the piece to the aluminum profile
aluprof_bolt_d = 4;

// cannot do it with if due to the variable scope
aluprof_bolt_head_r_tol = (aluprof_bolt_d == 6) ?
                            m6_head_r_tol :
                          ((aluprof_bolt_d == 5) ?
                            m5_head_r_tol :
                          ((aluprof_bolt_d == 4) ?
                            m4_head_r_tol : m3_head_r_tol ));

// cannot do it with if due to the variable scope
aluprof_bolt_r_tol = (aluprof_bolt_d == 6) ?
                            m6_r_tol :
                          ((aluprof_bolt_d == 5) ?
                            m5_r_tol :
                          ((aluprof_bolt_d == 4) ?
                            m4_r_tol : m3_r_tol ));

// cannot do it with if due to the variable scope
aluprof_bolt_head_l = (aluprof_bolt_d == 6) ?
                            m6_head_l :
                          ((aluprof_bolt_d == 5) ?
                            m5_head_l :
                          ((aluprof_bolt_d == 4) ?
                            m4_head_l : m3_head_l ));

/* this is useless in openscad because of the variable scope
   the variables are not updated after the conditions
if (aluprof_bolt_d == 6) {
  aluprof_bolt_head_r_tol = m6_head_r_tol;
  aluprof_bolt_r_tol = m6_r_tol;
  aluprof_bolt_head_l = m6_head_l;
} else {
  if (aluprof_bolt_d == 5) {
    aluprof_bolt_head_r_tol = m5_head_r_tol;
    aluprof_bolt_r_tol = m5_r_tol;
    aluprof_bolt_head_l = m5_head_l;
    echo(aluprof_bolt_r_tol);
  } else {
    if (aluprof_bolt_d == 4) {
      aluprof_bolt_head_r_tol = m4_head_r_tol;
      aluprof_bolt_r_tol = m4_r_tol;
      aluprof_bolt_head_l = m4_head_l;
    } else {
      aluprof_bolt_head_r_tol = m3_head_r_tol;
      aluprof_bolt_r_tol = m3_r_tol;
      aluprof_bolt_head_l = m3_head_l;
    }
  }
}
*/


// We are using 30x30 profiles
aluprof_w = 30;

// The position where the GT2 starts, from the lower profile
// Considering that the filter holder and guide are in a higher
// aluminum profile than the filter_idler

gt2_pos_h = aluprof_w + 3.5;

tens_pos_h = gt2_pos_h - wall_thick;

// The part of the tensioner that will be inside
tens_l_inside = tens_l - 2 * idler_r_xtr;

// the height to the beggining of the pulley + pulley height +
//  

hold_w = tens_w + 2*wall_thick;
hold_l = tens_l_inside + wall_thick;
hold_h = tens_pos_h + tens_h + wall_thick;

hold_bas_w = hold_w + 2*aluprof_w;
hold_bas_l = aluprof_w;
hold_bas_h = 8;

// optional tensioner chamfer, see step 04b in idler_tensioner.scad
opt_tens_chmf = 1;
// if you want to have the hole at the idler_holder to see inside, on one
// side, or both sides:
hold_hole_2sides = 1;


