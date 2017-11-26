// To support the NEMA 17 motor that is going to move the filter
// v02: more reinforcement on the x end

include <oscad_utils/bolt_sizes.scad> // include to use the constants
use <oscad_utils/fillet.scad>
use <oscad_utils/bolts.scad>  
// where the constants are defined
include <idler_cte.scad>



difference () {
  //echo (tensioner_x, " - ", tensioner_y, " - ", tensioner_z);
  cube([tensioner_x, tensioner_y, tensioner_z]);
  // Space for the idler pulley
    translate ([side_thick, tensioner_y - 2*idler_r,-1])
    {
     difference () {
        // y+1: outer side of Y, to avoid manifold
        // z+2: 2 sides of Z to vaoid manifold 
        cube([idler_h_tol, 2 * idler_r +1, tensioner_z +2]);
        // fillet
        fillet_dif_z (r=in_fillet, h=tensioner_z,
                      xdir=-1, ydir=-1, fillet=1);
        translate ([idler_h_tol,0,0])
        fillet_dif_z (r=in_fillet, h=tensioner_z,
                      xdir=1, ydir=-1, fillet=1);
     }
   }  
   
   // fillets on the idler corner
   translate ([0,tensioner_y,0])
     fillet_dif_z (r=in_fillet, h=tensioner_z,
                   xdir=-1, ydir=1, fillet=1);
   translate ([tensioner_x,tensioner_y,0])
     fillet_dif_z (r=in_fillet, h=tensioner_z,
                   xdir=1, ydir=1, fillet=1);

   translate ([side_thick,tensioner_y,0])
     fillet_dif_z (r=in_fillet, h=tensioner_z,
                   xdir=1, ydir=1, fillet=1);

   translate ([tensioner_x-side_thick,tensioner_y,0])
     fillet_dif_z (r=in_fillet, h=tensioner_z,
                   xdir=-1, ydir=1, fillet=1);

   // camfers on the nut corner
    fillet_dif_z (r=2*in_fillet, h=tensioner_z,
                   xdir=-1, ydir=-1, fillet=0);   
    translate([tensioner_x,0,0])
    fillet_dif_z (r=2*in_fillet, h=tensioner_z,
                   xdir=1, ydir=-1, fillet=0); 
   
   // shank for the idler pulley
   translate ([-1,tensioner_y - idler_r, idler_r])
   
   rotate ([0,90,0])
   cylinder (r=idler_shank_r, h= tensioner_x +2, $fa=1, $fs=0.5);

   // shank for the leadscrew, stroke
   translate ([tensioner_x/2, -1, tensioner_z/2])

   rotate ([-90,0,0])
   cylinder (r=tens_screw_r, h= nut_holder_total +2, $fa=1, $fs=0.5);

   // Hole for the leadscrew nut
   // tensioner_z/2-1 to have more tolerance
   translate ([tensioner_x/2, nut_holder_plastic, tensioner_z/2-1])
   rotate ([0,90,0])
   rotate([-90,0,0])
    // +stol to make it bigger
   cylinder (r=m4_nut_r_tol+stol, h = nut_space, $fn=6);
   
   // Hole to insert the leadscrew nut
   // tensioner_z/2-1 to haver more tolerance
   translate ([tensioner_x/2-m4_nut_ap_tol, nut_holder_plastic, tensioner_z/2-1])
   cube([2*m4_nut_ap_tol, nut_space, tensioner_z/2+2]);
   
   
   // Space for screw (the stroke)
    translate ([side_thick, nut_holder_total,-1])
    {
     difference () {
        // z+2: 2 sides of Z to vaoid manifold 
        cube([idler_h_tol, tensioner_stroke, tensioner_z +2]);
        // fillet
        fillet_dif_z (r=in_fillet, h=tensioner_z+2,
                      xdir=-1, ydir=-1, fillet=1);
        translate ([idler_h_tol,0,0])
          fillet_dif_z (r=in_fillet, h=tensioner_z+2,
                        xdir=1, ydir=-1, fillet=1);
        translate ([0,tensioner_stroke,0])
          fillet_dif_z (r=in_fillet, h=tensioner_z+2,
                        xdir=-1, ydir=1, fillet=1);
        translate ([idler_h_tol,tensioner_stroke,0])
          fillet_dif_z (r=in_fillet, h=tensioner_z+2,
                        xdir=1, ydir=1, fillet=1);

     }
   }  
}


 
