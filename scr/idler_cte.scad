// To support the NEMA 17 motor that is going to move the filter
// v02: more reinforcement on the x end

include <oscad_utils/bolt_sizes.scad> // include to use the constants
//use <oscad_utils/fillet.scad>
use <oscad_utils/bolts.scad>  


// Height of the idler pulley
idler_h     = 10;
idler_h_tol = idler_h + tol;  //tolerance included
//radius of the idler pulley 6mm DIN 9021 washer, the wider ones)
idler_r     = m6_wash9021_or + 2;  // or: outer radius,+2: little bigger

// Thickness of the sides that holds the idler pulley
side_thick = 5;


//  Length of the body, the stroke. Not including the pulley
tensioner_stroke = 20;

// distance between the pulley and the stroke
pulley_stroke_dist = 8;

// plastic space above and bellow the nut for the screw
nut_holder_plastic = 4;
nut_space = 2* m4_nut_h_tol;
nut_holder_total = nut_space + 2*nut_holder_plastic;

in_fillet = 2;

// Actually, the tensioner is rotated 90 on Y, to get a better print
// therefore x and z are changed
tensioner_x = idler_h_tol + 2*side_thick;
tensioner_y = nut_holder_total+tensioner_stroke + 2 * idler_r + pulley_stroke_dist ;
tensioner_z = 2 * idler_r;

// Actually, the tensioner is rotated 90 on Y, to get a better print
// therefore x and z are changed
tensioner_real_x = tensioner_z + tol;
tensioner_real_y = tensioner_y + tol;
tensioner_real_z = tensioner_x + tol;

//echo (tensioner_z, " - ", tensioner_real_x, " - ", tol);
//echo (tensioner_real_y, " - ", tensioner_y, " - ", tol);

// the shank for the idler pulley, 
idler_shank_r = m4_r_tol;
// the screw for tensioning the pulley 
tens_screw_r = m4_r_tol;


// We are using 30x30 profiles
profile = 30;

// The position where the GT2 starts, from the lower profile
// Considering that the filter holder and guide are in a higher
// aluminum profile than the filter_idler

gt2_z_pos = profile + 3.5;

tensioner_z_pos = gt2_z_pos - side_thick;

// The part of the tensioner that will be inside
tensioner_y_inside = tensioner_real_y - 2 * idler_r;

// the height to the beggining of the pulley + pulley height +
//  
holder_x = tensioner_real_x + 2*side_thick;
holder_y = tensioner_y_inside + 2*side_thick;
holder_z = tensioner_z_pos + tensioner_real_z + side_thick;

holder_base_x = holder_x + 2*profile;
holder_base_y = profile;
holder_base_z = 8;


