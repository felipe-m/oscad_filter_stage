// To support the NEMA 17 motor that is going to move the filter
// v02: more reinforcement on the x end

include <oscad_utils/bolt_sizes.scad> // include to use the constants
use <oscad_utils/fillet.scad>
use <oscad_utils/bolts.scad>  


// Tolerance
tol = 0.4;
// Tolerance for small objects
stol = 0.2;

// NEMA 17 base, it is 1.7 x 1.7 inches, which is 43.2 mm
// However I see that the specifications of the ones I have seen are
// 42.3 mm
dim_nema17 = 42.3;

dim_nema17_tol = dim_nema17 + 1.5*tol; // It was too tight in v02

// aluminum extrusion profile where this piece will be attached
profile = 30;

// Side size reinforcement
side_size = 8;

// The side_size reinforcement, how much is holding the motor
side_size_h = 10;


// z raise: the height needed for the stepper, considering that the
// linear guide is not attached to a profile, but to squares.
// So the profiles are the size of a profile lower (30mm)
// 18.2 is obtained from the size of the filter support: The belt
// clamp is raised 45mm (sop_guia_z), from the center of the linear
// guide is raised 18,5mm, and the center of the linear guide is raised
// 15mm (profile/2). So it is raised 33,5mm
// However, the GT2 pulley is raised from the motor (due to the shaft)
// 15,3 mm
// Therefore: 33.5 - 15.3 = 18.2

z_raise = 18.2;

// Height of the base where the motor is attached
motor_base_height = 5;

// Y alignment: to have the belt centered with the filter holder
//alignx_belt = 7; // v02 was wrong, it had to be moved 5 on the
                   // opposite direction
alignx_belt = 0;   // v03, it has to be improved, to get -5, but
                   // at least, not to increase the error

// v02 the x_dim dimension is larger by + side_size
x_dim = profile + dim_nema17_tol + alignx_belt  + side_size; 
y_dim = profile + dim_nema17_tol + side_size;
z_dim = z_raise + motor_base_height;

fillet_piece_r = 4;

// the radius (diagonal) used for the space of the NEMA17 motor
nema17_fillet_r = 3.5; //v03: it was 4, too tight
// radius of the center hole of the motor, where the axis is
nema17_center_hole_r = 13;
// distance between the bolts used to hold de motor
nema17_bolt_distance = 31;
m3_r = 1.5; // diameter 3
m3_r_tol = m3_r + stol; // diameter 3.2, 0.2 tolerance


// this translation and rotation is to put it on the way it 
// printed, not the way is going to be attached
// The rotation on the X axis makes Y and Z dimensions the opposite
//translate ([0, y_dim, z_dim])
//rotate ([180,0,0])
difference () {
cube ([x_dim, y_dim, z_dim]);

  // Take the corner away, in case we have a vertical profile
  translate ([-1, y_dim - profile, -1])
  cube( [profile+1, profile+1, z_dim + 2]);

// fillets for the piece
  fillet_dif_z (r=fillet_piece_r, h=z_dim, xdir=-1, ydir=-1, fillet=1);
  translate ([0,y_dim-profile, 0])
    fillet_dif_z (r=fillet_piece_r, h=z_dim, xdir=-1, ydir=1, fillet=1);
  translate ([profile,y_dim, 0])
    fillet_dif_z (r=fillet_piece_r, h=z_dim, xdir=-1, ydir=1, fillet=1);    
  translate ([x_dim,0, 0])
    fillet_dif_z (r=fillet_piece_r, h=z_dim, xdir=1, ydir=-1, fillet=1);
  translate ([x_dim,y_dim, 0])
    fillet_dif_z (r=fillet_piece_r, h=z_dim, xdir=1, ydir=1, fillet=1);


//-1 to avoid n-manifold
translate ([profile+alignx_belt, side_size,-1]) 
  // the space for the NEMA17 motor
  union ()
    {
      difference () {
        // X dimension is +1 to avoid manifold
        cube([dim_nema17_tol, dim_nema17_tol, z_raise+1]); 
        // chamfers on 4 sides
        fillet_dif_z (r=nema17_fillet_r, h=z_raise+1, 
                      xdir=-1, ydir=-1, fillet=0);
        translate ([0, dim_nema17_tol, 0])
          fillet_dif_z (r=nema17_fillet_r, h=z_raise+1,
                        xdir=-1, ydir=1, fillet=0);
        translate ([dim_nema17_tol, 0, 0])
          fillet_dif_z (r=nema17_fillet_r, h=z_raise+1,
                        xdir=1, ydir=-1, fillet=0);
        translate ([dim_nema17_tol, dim_nema17_tol, 0])
          fillet_dif_z (r=nema17_fillet_r, h=z_raise+1,
                        xdir=1, ydir=1, fillet=0);

          
      }
      // inner cylinder, on the center
      translate ([dim_nema17_tol/2, dim_nema17_tol/2, 0])
      cylinder (r=nema17_center_hole_r, h= z_dim+2, $fa=1, $fs=0.5);
      
      // Holes for the bolts to hold the motor
      for (x=[(dim_nema17_tol-nema17_bolt_distance)/2 ,
              (dim_nema17_tol+nema17_bolt_distance)/2 ])
      {
        for (y=[(dim_nema17_tol-nema17_bolt_distance)/2 ,
                (dim_nema17_tol+nema17_bolt_distance)/2 ])
        {
        translate ([x, y, 0])
          cylinder (r=m3_r_tol, h= z_dim+2, $fa=1, $fs=0.5);
        }
      }
      
    }

    // This is a chamfered space on the x end of the side_size
    // It is not necessary
    translate ([x_dim-side_size-nema17_fillet_r, side_size, -1])
      difference () {
        cube ([side_size+nema17_fillet_r+1, dim_nema17_tol,
               z_raise - side_size_h]);
         translate ([0,0,z_raise - side_size_h])
          fillet_dif_x (r=z_raise - side_size_h,
                       h= side_size+nema17_fillet_r+1,
                       ydir=-1, zdir=1, fillet=0);
         translate ([0,dim_nema17_tol,z_raise - side_size_h])
          fillet_dif_x (r=z_raise - side_size_h,
                       h= side_size+nema17_fillet_r+1,
                       ydir=1, zdir=1, fillet=0);

      }
        
    
    
    // bolts holes to attach this motor holder to the alum profiles
    translate ([profile/2,profile/2,z_dim])
    rotate ([180,0,0])
    bolt_hole (r_shank = m5_r_tol, l_bolt=z_dim, r_head=m5_head_r_tol, l_head=0.7*z_dim, hex_head=0, h_layer3d=h_layer3d, mnfold=1);

    translate ([profile/2,y_dim - 3*profile/2,z_dim])
    rotate ([180,0,0])
    bolt_hole (r_shank = m5_r_tol, l_bolt=z_dim, r_head=m5_head_r_tol, l_head=0.7*z_dim, hex_head=0, h_layer3d=h_layer3d, mnfold=1);

    translate ([3*profile/2,y_dim - profile/2,z_dim])
    rotate ([180,0,0])
    bolt_hole (r_shank = m5_r_tol, l_bolt=z_dim, r_head=m5_head_r_tol, l_head=0.7*z_dim, hex_head=0, h_layer3d=h_layer3d, mnfold=1);

    translate ([x_dim-profile/2,y_dim - profile/2,z_dim])
    rotate ([180,0,0])
    bolt_hole (r_shank = m5_r_tol, l_bolt=z_dim, r_head=m5_head_r_tol, l_head=0.7*z_dim, hex_head=0, h_layer3d=h_layer3d, mnfold=1);

}

   
