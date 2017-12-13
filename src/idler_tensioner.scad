/* Idler pulley tensioner
  ----------------------------------------------------------------------------
  -- (c) Felipe Machado
  -- Area of Electronic Technology. Rey Juan Carlos University (urjc.es)
  -- https://github.com/felipe-m
  -- December-2017
  ----------------------------------------------------------------------------
  --- LGPL Licence
  ----------------------------------------------------------------------------


           Z
           :              ........ tens_l ........
           :             :                        :
         .. ________       _______________________
         : |___::___|     /      ______   ___::___|
         : |    ....|    |  __  |      | |
  tens_h + |   ()...|    |:|  |:|      | |         
         : |________|    |  --  |______| |________
         :.|___::___|     \__________________::___|.......> Y


            ________ ....> X
           |___::___|
           |  ......|
           |  :.....|
           |   ::   |
           |........|
           |        |
           |        |
           |........|
           |........|
           |        |
           |   ()   |
           |        |
           |________|
           :        :
           :........:
               +
              tens_w
*/


include <oscad_utils/bolt_sizes.scad> // include to use the constants
use <oscad_utils/fillet.scad>
use <oscad_utils/bolts.scad>  
// where the constants are defined
include <kidler.scad>

module idler_tens ()
{


  difference () {
    /* --------------- step 01 ---------------------------      
       rectangular cuboid with basic dimensions
      
                Z
                :.....tens_l.......
                :_________________:
                /                /|
               /                / |
            ../________________/  |..............Y     .
           :  |                |  /     . 
      tens_h  |                | /     . tens_w
            :.|________________|/......
             .
            .
           X 
    */
    cube([tens_w, tens_l, tens_h]);

    /* --------------- step 02 ---------------------------  
      Space for the idler pulley

           Z
           :
           :_______________________
           |                 ______|....
           |              f2/          + idler_h
           |               |           :
           |              f1\______....:
           |_______________________|...wall_thick.......> Y
                           :       :
                           :.......:
                              +
                            2 * idler_r_xtr
    */
    translate ([-1, tens_l - 2*idler_r_xtr, wall_thick])
    {
      difference () {
        // y+1: outer side of Y, to avoid manifold
        // z+2: 2 sides of Z to avoid manifold 
        cube([tens_w+2, 2 * idler_r_xtr +1, idler_h]);
        // fillet f1
        fillet_dif_x (r=in_fillet, h=tens_w,
                      ydir=-1, zdir=-1, fillet=1);
        // fillet f2
        translate ([0,0,idler_h])
          fillet_dif_x (r=in_fillet, h=tens_w,
                        ydir=-1, zdir=1, fillet=1);
      }
    }  
    /* --------------- step 03 --------------------------- 
      Fillets at the idler end:

           Z
           :
           :_______________________f2
           |                 ______|
           |                /      f4
           |               |
           |                \______f3...
           |_______________________|....+ wall_thick.....> Y
           :                       f1
           :...... tens_l .........:
    */
    // fillet at the bottom f1
    translate ([0,tens_l,0])
      fillet_dif_x (r=in_fillet, h=tens_w,
                    ydir=1, zdir=-1, fillet=1);
    // fillet on top: f2
    translate ([0,tens_l,tens_h])
      fillet_dif_x (r=in_fillet, h=tens_w,
                    ydir=1, zdir=1, fillet=1);
    // fillet at the bottom, inner side: f3
    translate ([0,tens_l,wall_thick])
      fillet_dif_x (r=in_fillet, h=tens_w,
                    ydir=1, zdir=1, fillet=1);
    // fillet on top, inner side: f4
    translate ([0,tens_l,tens_h - wall_thick])
      fillet_dif_x (r=in_fillet, h=tens_w,
                    ydir=1, zdir=-1, fillet=1);

    /* --------------- step 04 --------------------------- 
      Chamfers at the nut end:

           Z
           :
           : ______________________
         ch2/                ______|
           |                /             
           |               |        
           |                \______
         ch1\______________________|.............> Y
           :                       :
           :...... tens_l .........:
    */
    // chamfer 1
    fillet_dif_x (r=2*in_fillet, h=tens_w,
                  ydir=-1, zdir=-1, fillet=0);                    
    // chamfer 2
    translate ([0,0,tens_h])
      fillet_dif_x (r=2*in_fillet, h=tens_w,
                    ydir=-1, zdir=1, fillet=0); 

   /* --------------- step 04b OPTIONAL---------------------- 
      Chamfers at the nut end on axis Z, they are 45 degrees
      so they should print ok without support, but you may
      not want to have them

            ________ ....> X
        ch1/________\ch2
           |        |
           |        |
           |        |
           |        |
           |        |
           |        |
           |........|
           |        |
           |        |
           |        |
           |________|
           :
           Y
           
    */

    if (opt_tens_chmf == 1) { // optional tensioner chamfer
      fillet_dif_z (r=2*in_fillet, h=tens_h,
                    xdir=-1, ydir=-1, fillet=0);   
      translate([tens_w,0,0])
        fillet_dif_z (r=2*in_fillet, h=tens_h,
                       xdir=1, ydir=-1, fillet=0);
    }

    /* --------------- step 05 --------------------------- 
      Shank hole for the idler pulley:

           Z                     idler_r_xtr
           :                    .+..
           : ___________________:__:
            /                __:_:_|
           |                /             
           |               |        
           |                \______
            \__________________:_:_|.............> Y
           :                       :
           :...... tens_l .........:
    */                    
    translate ([tens_w/2., tens_l - idler_r_xtr, -1])
        cylinder (r=boltidler_r_tol, h= tens_h +2, $fa=1, $fs=0.5);

    /* --------------- step 06 --------------------------- 
      Hole for the leadscrew (stroke):

           Z
           :
           : ______________________
            /      _____     __:_:_|
           |    f2/     \f4 /             
           |     |       | |        
           |    f1\_____/f3 \______
            \__________________:_:_|.............> Y
           :     :       :         :
           :     :.......:         :
           :     :   +             :
           :.....:  tens_stroke    :
           :  +                    :
           : nut_holder_total      :
           :                       :
           :...... tens_l .........:
    */

    // Space for screw (the stroke)
    translate ([-1, nut_holder_total,wall_thick])
    {
      difference () {
        // tens_w+2: 2 sides of X to avoid manifold 
        cube([tens_w+2, tens_stroke, idler_h]);

        // fillet f1
        fillet_dif_x (r=in_fillet, h=tens_w,
                      ydir=-1, zdir=-1, fillet=1);
        // fillet f2
        translate ([0,0,idler_h])
          fillet_dif_x (r=in_fillet, h=tens_w,
                        ydir=-1, zdir=1, fillet=1);

        // fillet f3
        translate ([0,tens_stroke,0])
          fillet_dif_x (r=in_fillet, h=tens_w,
                        ydir=1, zdir=-1, fillet=1);

        // fillet f4
        translate ([0,tens_stroke,idler_h])
          fillet_dif_x (r=in_fillet, h=tens_w,
                        ydir=1, zdir=1, fillet=1);
      
      }  
    }
    
    /* --------------- step 07 --------------------------- 
      Hole for the leadscrew shank at the beginning

           Z
           :
           : ______________________
            /      _____     __:_:_|
           |      /     \   /
           |:::::|       | |
           |      \_____/   \______
            \__________________:_:_|.............> Y
           :     :                 :
           :     :                 :
           :     :                 :
           :.....:                 :
           :  +                    :
           : nut_holder_total      :
           :                       :
           :...... tens_l .........:
    */                      
      translate ([tens_w/2, -1, tens_h/2])
        rotate ([-90,0,0])
          cylinder (r=bolttens_r_tol, h= nut_holder_total +2, $fa=1, $fs=0.5);

    /* --------------- step 08 --------------------------- 
      Hole for the leadscrew nut

           Z
           :
           : ______________________
            /      _____     __:_:_|
           |  _   /     \   /
           |:|_|:|       | |
           |      \_____/   \______
            \__________________:_:_|.............> Y
           : :   :                 :
           :+    :                 :
           :nut_holder_thick       :
           :.....:                 :
           :  +                    :
           : nut_holder_total      :
           :                       :
           :...... tens_l .........:
    */                      

    // Hole for the leadscrew nut
    // tens_w/2-1 to have more tolerance, so it is a little bit deeper
    translate ([tens_w/2-1, nut_holder_thick, tens_h/2])
      rotate([-90,0,0]) //-90 to go to the positive side of Y
        // +stol to make it bigger. This is a hexagon for the nut,
        // not a cylinder: fn=6
        cylinder (r=m4_nut_r_tol+stol, h = nut_space, $fn=6);
   
    // Hole to insert the leadscrew nut
    // tens_h/2-1 to haver more tolerance
    translate ([tens_w/2-1, nut_holder_thick, tens_h/2-m4_nut_ap_tol])
      cube([tens_w/2 + 2, nut_space, 2*m4_nut_ap_tol]);
  }
}

// rotate to print without support:
rotate([0,-90,0])
  idler_tens();
 
