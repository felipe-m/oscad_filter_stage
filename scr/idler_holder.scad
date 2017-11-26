// To support the NEMA 17 motor that is going to move the filter
// v02: more reinforcement on the x end

include <oscad_utils/bolt_sizes.scad> // include to use the constants
use <oscad_utils/fillet.scad>
use <oscad_utils/bolts.scad>  
// where the constants are defined
include <idler_cte.scad>

// Rotation and translation to print, axis are moved
//translate ([0, holder_y,0])
//rotate ([90,0,0])
difference () {
  union () 
  {
    // the base, to attach it to the aluminum profiles
    difference ()
    {
      cube([holder_base_x, holder_base_y, holder_base_z]);
      // The piece will be printed on the XZ plane, so this fillet will be 
      // raising
      fillet_dif_y (r=in_fillet, h = holder_base_y, xdir=-1, zdir=-1, fillet=1);
      translate ([0,0, holder_base_z])
      fillet_dif_y (r=in_fillet, h = holder_base_y, xdir=-1, zdir=1, fillet=1);
      translate ([holder_base_x,0, 0])
      fillet_dif_y (r=in_fillet, h = holder_base_y, xdir=1, zdir=-1, fillet=1);
      translate ([holder_base_x,0, holder_base_z])
      fillet_dif_y (r=in_fillet, h = holder_base_y, xdir=1, zdir=1, fillet=1);
  
    }


    translate ([profile,0,0])
    {
      difference () {
        // The main box
        cube([holder_x, holder_y, holder_z]);
  
        // The fillets on top:
        translate ([0,0, holder_z])
          fillet_dif_y (r=in_fillet, h=holder_y, xdir=-1,zdir=1,fillet=1);
        translate ([holder_x,0, holder_z])
          fillet_dif_y (r=in_fillet, h=holder_y, xdir=1,zdir=1,fillet=1);
  
        // big chamfer on the bottom
        translate ([0, holder_y,0])
          fillet_dif_x (r=holder_y-holder_base_y, h= holder_x,
                        ydir=1, zdir=-1, fillet=0);
        
        // The hole for the tensioner   
        translate ([side_thick,holder_y-tensioner_y_inside,tensioner_z_pos])
        {
          difference () 
          {
            //echo (tensioner_real_x, " - ", tensioner_y_inside, " - ", 
            //      tensioner_real_z);
            cube([tensioner_real_x, tensioner_y_inside+1, tensioner_real_z]);
              // camfers on the nut corner
            fillet_dif_x (r=2*in_fillet-tol, h=tensioner_real_z,
                        ydir=-1, zdir=-1, fillet=0);   
            translate([0,0,tensioner_real_z])
              fillet_dif_x (r=2*in_fillet-tol, h=tensioner_real_z,
                         ydir=-1, zdir=1, fillet=0); 
          }
        } 
        // A hole to be able to see inside
        translate ([holder_x-side_thick-1,
                    holder_y-tensioner_y_inside+nut_holder_plastic, //v02
                    tensioner_z_pos +  tensioner_real_z /2 - m4_nut_ap_tol ])
          cube([side_thick+2,
                tensioner_stroke+nut_space+nut_holder_plastic, //V02
                2*m4_nut_ap_tol]);

        // A hole for the leadscrew
        translate ([holder_x/2, -1, tensioner_z_pos + tensioner_real_z/2])
          rotate ([-90,0,0])
          // h is way larger than what is needed
          cylinder (r=m4_r_tol, h=holder_y, $fa=1, $fs=0.5); 


      }
    }

    // chamfer the unions
    translate ([profile, 0, holder_base_z])
      fillet_add_y (r=profile/2, h=holder_base_y, xdir=-1, zdir=1, fillet=0);
    translate ([holder_base_x - profile, 0, holder_base_z])
      fillet_add_y (r=profile/2, h=holder_base_y, xdir=1, zdir=1,fillet=0);
  
  }

  // Holes for the bolts to attach the piece to the aluminum profile
  translate ([profile/2, profile/2,0])
  translate ([0,0, holder_base_z + m5_head_l])
  rotate ([180,0,0])
  bolt_hole (r_shank = m5_r_tol, l_bolt = holder_base_z + m5_head_l,
             r_head = m5_head_r_tol, l_head = m5_head_l, hex_head = 0, 
             h_layer3d = 0, mnfold = 1);

  translate ([holder_base_x - profile/2, profile/2,0])
  translate ([0,0, holder_base_z + m5_head_l])
  rotate ([180,0,0])
  bolt_hole (r_shank = m5_r_tol, l_bolt = holder_base_z + m5_head_l,
             r_head = m5_head_r_tol, l_head = m5_head_l, hex_head = 0, 
             h_layer3d = 0, mnfold = 1);

}




