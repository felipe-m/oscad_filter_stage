// Nema motor holder
//----------------------------------------------------------------------------
//-- (c) Felipe Machado
//-- Area of Electronic Technology. Rey Juan Carlos University (urjc.es)
//-- https://github.com/felipe-m
//-- 2019
//----------------------------------------------------------------------------
//-- LGPL Licence
//----------------------------------------------------------------------------
//
//   Creates a holder for a Nema motor
//       __________________
//      ||                ||
//      || O     __     O ||
//      ||    /      \    ||
//      ||   |   1    |   ||
//      ||    \      /    ||
//      || O     __     O ||
//      ||________________|| ..... wall_thick
//      ||_______2________|| ....................>Y
//                                    
//                                    
//                                    motor_xtr_space_d
//                                   :  :
//       ________3_________        3_:__:____________ ..............> X
//      |  ::  :    :  ::  |       |      :     :    |    + motor_thick
//      |__::__:_1__:__::__|       2......:..1..:....|....:
//      ||                ||       | :              .
//      || ||          || ||       | :           .
//      || ||          || ||       | :        .
//      || ||          || ||       | :      .
//      || ||          || ||       | :   .
//      ||________________||       |_: .
//      ::       :                 :                 :
//       + reinf_thick             :....tot_d........:
//               :
//               :
//               Z
//
//
//
//
//       __________________ ..................................
//      |  ::  :    :  ::  |                                  :
//      |__::__:_1__:__::__|....................              :
//      ||                ||....+ motor_min_h  :              :
//      || ||          || ||                   :              +tot_h
//      || ||          || ||                   + motor_max_h  :
//      || ||          || ||                   :              :
//      || ||          || ||...................:              :
//      ||________________||...................:.xtr_down.....:
//      :  :            :  :
//      :  :            :  :
//      :  :............:  :
//      :   bolt_wall_sep  :
//      :                  :
//      :                  :
//      :.....tot_w........:
//                       ::
//                        motor_xtr_space
//
//

include <oscad_utils/bolt_sizes.scad> // include to use the constants
use <oscad_utils/fillet.scad>
use <oscad_utils/bolts.scad>


fillet_dif_x (r=1, h=1, ydir=-1, zdir=-1, fillet=1);

//    Parameters:
//    -----------

// use these values for fast generation time but rough surfaces
//$fa=1;
//$fs=1.5;
// use these values for slow generation time but defined surfaces
$fa=0.5;
$fs=0.5;

// --------------- PARAMETERS (can be changed) ----------
// Nema Size, choose the NEMA size of your motor: 8, 11, 14, 17, 23, 34, 42
nema_size = 17;

//  thickness in mm of the side where the holder will be screwed to
wall_thick = 4;

//  thickness in mm of the top side where the motor will be screwed to
motor_thick = 4;

//  thickness of the reinforcement walls
reinf_thick = 4;

//  distance of from the inner top side to the top hole of the bolts to 
//  attach the holder (see drawing)
motor_min_h = 10;

// distance of from the inner top side to the bottom hole of the bolts to 
// attach the holder
motor_max_h = 40;

// extra separation between the motor and the sides
motor_xtr_space = 5;

// extra separation between the motor and the side of the wall
motor_xtr_space_d = 5;

// extra space from the motor_max_h to the end
xtr_down = 5;

// separation of the wall bolts, if 0, it will be the motor width
// has to be smaller than the total width
set_bolt_wall_sep = 0;


// metric of the bolts to attach the holder (diameter of the shank in mm)
bolt_wall_d = 3;

// radius of the chamfer
chmf_r = 1;

// motor hole radius: the hole for the motor circle that is with the axis
// if 0, will take the half of the distance of the bolts
set_motor_hole_r = 0;

// tolerances: 0.4 or 0.3 mm
TOL = 0.3;
STOL = TOL / 2;  //smaller tolerance

// -- DO NOT CHANGE ANYTHING UNDER THIS LINE UNLESS YOU KNOW WHAT YOU 
// ---             ARE DOING

 


// Due to the scope of variables in OpenSCAD we cannot use if

// width of the motor
motor_w = (nema_size == 8) ?
              20.2 : (
          (nema_size == 11) ?
              28.2 : (
          (nema_size == 14) ?
              35.2 : (
          (nema_size == 17) ?
              42.3 : (
          (nema_size == 23) ?
              56.4 : (
          (nema_size == 34) ?
              86.0 : (
          (nema_size == 42) ?
              110.0 : 
              0)  //not supported    
              )))));    
              
echo(motor_w);

// separation of the bolt holes of the motor 
motor_bolt_sep = (nema_size == 8) ?
              16.0 : (
          (nema_size == 11) ?
              23.0 : (
          (nema_size == 14) ?
              26.0 : (
          (nema_size == 17) ?
              31.0 : (
          (nema_size == 23) ?
              47.1 : (
          (nema_size == 34) ?
              69.6 : (
          (nema_size == 42) ?
              89.0 : 
              0)  //not supported    
              )))));    
              
echo(motor_bolt_sep);

//  motor bolt holes diameter 
// check datasheet, dimensions may vary
motor_bolt_d = (nema_size == 8) ?
              2 : (
          (nema_size == 11) ?
              2 : (
          (nema_size == 14) ?
              3 : (
          (nema_size == 17) ?
              3 : (
          (nema_size == 23) ?
              5 : (
          (nema_size == 34) ?
              5 : (
          (nema_size == 42) ?
              8 : 
              0)  //not supported    
              )))));    
              
echo(motor_bolt_d);


// if not defined motor_hole_r:
motor_hole_r = (set_motor_hole_r == 0) ?
               motor_bolt_sep/2 : set_motor_hole_r;

// if not defined the wall bolt separation
bolt_wall_sep = ( set_bolt_wall_sep == 0) ?
                  motor_w : set_bolt_wall_sep;



// radius of the motor bolts including tolerances
motor_bolt_r_tol = motor_bolt_d/2 + STOL;

// radius of the wall bolts including tolerances
bolt_wall_r_tol = bolt_wall_d/2 + STOL;

// total width: the reinforcement + motor width + xtr_space
tot_w = 2* reinf_thick + motor_w + 2 * motor_xtr_space;

// total height:
tot_h = motor_thick + motor_max_h + xtr_down;

// total depth:
tot_d = wall_thick + motor_w + motor_xtr_space_d;

module nemamotor_holder()
{
  difference(){
    //  --------------- step 01 ---------------------------      
    //  rectangular cuboid with basic dimensions
    // 
    //                    Z
    //                    :
    //                    :
    //             :.....tot_w.......
    //             :______:__________:
    //             /                /|
    //            /                / |
    //           /                /  |
    //          /                /   |
    //       ../________________/    |
    //       : |                |    | 
    //       : |                |    |...............Y
    //       : |                |   /     . 
    //  tot_h: |                |  /     . tot_d
    //       : |                | /     . 
    //       :.|________________|/......
    //                .
    //               .
    //              X 
    //
    translate([0,-tot_w/2,0])cube([tot_d,tot_w,tot_h]);


    //  --------------- step 02 ---------------------------      
    //  chamfering the 4 vertical edges (marked with H)
    //
    //                   Z
    //                   :
    //                   :
    //            :.....tot_w.......
    //            :______:__________:
    //            /                /H chamfering
    //           /                / H
    //          /                /  H
    //         /                /   H
    //      ../________________/    H
    //      : H                H    H 
    //      : H                H    H...............Y
    //      : H                H   /     . 
    // tot_h: H                H  /     . tot_d
    //      : H                H /     . 
    //      :.H________________H/......
    //               .
    //              .
    //             X 
    //

    translate ([0,-tot_w/2,0])
      fillet_dif_z (r=chmf_r, h=tot_h,ydir=-1, xdir=-1, fillet=0);
    translate ([0,tot_w/2,0])
      fillet_dif_z (r=chmf_r, h=tot_h,ydir=1, xdir=-1, fillet=0);
    translate ([tot_d,-tot_w/2,0])
      fillet_dif_z (r=chmf_r, h=tot_h,ydir=-1, xdir=1, fillet=0);
    translate ([tot_d,tot_w/2,0])
      fillet_dif_z (r=chmf_r, h=tot_h,ydir=1, xdir=1, fillet=0);

    // --------------- step 03 ---------------------------      
    // Horizontal chamfering the top edge to make a 'triangular' reinforcement
    //
    //     Z
    //     :
    //     :___            . chmf_pos
    //     |    \
    //     |      \
    //     |        \
    //     |          \
    //     |            \
    //     |              \
    //     |________________.....X
    //
    //

    //the radius is the smaller part
    chmf_reinf_r = min(tot_d-wall_thick, tot_h-motor_thick);
    // still in difference
    translate([tot_d,-tot_w/2,tot_h])
      fillet_dif_y (r=chmf_reinf_r, h=tot_w, xdir=1, zdir=1);

    // --------------- step 04 ---------------------------      
    // Hole for the motor
    //
    //               Z                      Z
    //               :                      :
    //       ________:_________             :__
    //      | |              | |            | :  \        
    //      | |              | |            | :    \ 
    //      | |              | |            | :      \
    //      | |              | |            | :        \
    //      | |              | |            | :          \
    //      | |              | |            | :            \
    //      |_|______________|_|            | :..............\...motor_thick
    //      |_|______________|_|..Y         |_________________\..X
    //      : :                             : :
    //      : :                             : :
    //       reinf_thick                     wall_thick

    // still difference:
    translate([wall_thick, -(tot_w-2*reinf_thick)/2, motor_thick])
      cube([tot_d,tot_w-2*reinf_thick, tot_h]);
    
    // --------------- step 05 ---------------------------      
    // Holes for motor bolts, and the central hole
    //
    //   ____________________...............................>Y
    //  | ___________________|.. wall_thick         
    //  | |                | |.. motor_xtr_space..... 
    //  | | O     __     O | | --                   :motor_w/2
    //  | |    /      \    | |   .                  :
    //  | |   |   1    |   | |   .+ motor_bolt_sep ---
    //  | |    \      /    | |   .
    //  | | O     __     O | | --
    //  |_|________________|_| ..... wall_thick
    //            :        : :
    //            :         reinf_thick
    //      :     X      :
    //      :            :
    //      :            :
    //      motor_bolt_sep

    // central hole
    axis_x = wall_thick+motor_xtr_space+motor_w/2;
    translate([axis_x,0,-1])
      cylinder(r=motor_hole_r, h=motor_thick+2);
    for (x_side=[-1,1])
      for (y_side=[-1,1])
        translate([axis_x+x_side*motor_bolt_sep/2, y_side*motor_bolt_sep/2,-1])
          cylinder (r=motor_bolt_r_tol, h=motor_thick+2);

    // --------------- step 06 ---------------------------      
    // Rails to attach the holder
    //
    //           Z               
    //           :                
    //   ________:_________        
    //  | |              | |        
    //  | | ||        || | |-----------------------
    //  | | ||        || | |                       :
    //  | | ||        || | |                       +motor_max_h
    //  | | ||        || | |                       :
    //  | | ||        || | |-------                :
    //  |_|______________|_|.......:+ motor_min_h..: 
    //  |_|______________|_|....:+motor_thick............Y
    //       :         :                   
    //       :.........:
    //
    bothole_pos_z = motor_thick+motor_min_h;
    tophole_pos_z = motor_thick+motor_max_h;
    for (y_side=[-1,1])
      #hull(){
        translate([-1,y_side*bolt_wall_sep/2,bothole_pos_z])
          rotate ([0,90,0])
            cylinder(r=bolt_wall_r_tol, h=wall_thick+2);
        translate([-1,y_side*bolt_wall_sep/2,tophole_pos_z])
          rotate ([0,90,0])
            cylinder(r=bolt_wall_r_tol, h=wall_thick+2);
      }


    }
    
}
nemamotor_holder();
