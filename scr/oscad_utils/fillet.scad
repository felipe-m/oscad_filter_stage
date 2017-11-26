/*
 *    OpenScad functions to fillet
 *
 *    Copyright (C) 2016 Felipe Machado
 *    Universidad Rey Juan Carlos, Spain
 *    https://github.com/felipe-m
 *    License: LGPL 3.0 or later
 *
 *    to use this functions include in your file:
 * use <fillet.scad>
 *    if not in the same directory:
 * use <PATH_TO/fillet.scad>
 *    dont use 'include' instead of 'use' so you dont get the objects
 *    created in this file
*/


r_fillet = 5;
h_fillet = 10;

// adding 0.1mm to avoid non manifold corners when adding fillets and chamfers
nmf_add = 0.01;

// Having non-manifold problems with fillet_add, making it a little larger

// fillet: to substract, so we have to make it larger

module base_fillet_dif (r, h, fillet)
{  
  
  if (fillet==1) 
  {    
    difference ()
    {
     // -1, -2 y 2, 4 is to make the difference
     translate([0,0,-1])cube([r+1,r+1,h+2]);
     translate([0,0,-2])cylinder(r=r, h=h+4, $fa=1, $fs=0.5);
    }
  } else { // chamfer
    difference ()
    {
      translate([0,0,-1])cube([r+1,r+1,h+2]);
      // The cube has the vertexs on the X Y axis, so the difference
      // is done apropiately. 
      translate([0,0,-2])cylinder(r=r, h=h+4, $fn=4);
    }
  }
      
}

//*base_fillet_dif (r=r_fillet, h=h_fillet, fillet=1);
//*base_fillet_dif (r=r_fillet, h=h_fillet, fillet=0);


// ---------------------- FILLET_DIF -------------------------
// Makes a fillet in a vertical line used for difference
// It is bigger to be used for the difference
// So the dimensions are the dimensions of the fillet, 
// YOU DON'T HAVE TO MAKE IT LARGER to consider the difference
//   (to avoid non-manifold)
// r: Radius of the fillet
// h: Height of the fillet
// --------- taken away
// // x: position of the fillet (lowest X point)
// // Y: position of the fillet (lowest Y point)
// ----------------------
// xdir: x direction of the fillet. Values: 1, -1
// ydir: y direction of the fillet. Values: 1, -1
//
//                   Y
//            _      |     _
//   x=-1   /        |       \  x=1, y=1
//   y= 1   |        |       |
//                   |
//         -------------------> X +
//                   |        
//   x=-1   |        |       |   x=1
//   y=-1    \_      |    _ /    y=-1
//                   |
// fillet: fillet or chamfer
//         1: fillet
//         0: chamfer



//module fillet_dif_z (r, h, x, y, xdir, ydir, fillet)


module fillet_dif_z (r, h, xdir, ydir, fillet)
{
// This is what we want to do:    
//    if ((xdir == 1) && (ydir == 1)) {
//      rotation = 0;
//    } else if ((xdir == -1) && (ydir == 1)) {
//      rotation = 90;  
//    } else if ((xdir == -1) && (ydir == -1)) {
//      rotation = 180;
//    } else if ((xdir ==  1) && (ydir == -1)) {
//      rotation = 270;
//    } else {
//      echo ("Error: incorrect values for xdir, ydir");
//    }
// But since it is not possible in oscad, we do this way:
    // atan gives 45 when xdir== 1 and ydir== 1 
    //                 or xdir==-1 and ydir==-1
    // so we make it 0
    //
    // atan gives -45 when xdir==-1 and ydir== 1 
    //                  or xdir== 1 and ydir==-1
    // so whe make it -90 (270)
    //
    angle_aux =  atan (ydir/xdir) - 45;
    //echo ("angle: ", angle_aux);
     
    // when xdir == -1 we add 180, making:
    // from 0 of (xdir==-1 and ydir==-1) to 180
    // from -90 of (xdir==-1 and ydir== 1) to 90
    rotation = (xdir == 1) ? angle_aux : angle_aux + 180;
        
    //echo ("rotation: ", rotation);
    
    //translate([x,y,0]) // required translation
    translate([-xdir*r, -ydir*r,0])  // to have it in 0,0
      rotate ([0,0,rotation])
      base_fillet_dif (r=r, h=h, fillet=fillet);
}
    

//fillet_dif_z (r=r_fillet, h=h_fillet, xdir=1, ydir=1, fillet=1);
//fillet_dif_z (r=r_fillet, h=h_fillet, xdir=-1, ydir=1, fillet=1);
//fillet_dif_z (r=r_fillet, h=h_fillet, xdir=1, ydir=-1, fillet=1);
//fillet_dif_z (r=r_fillet, h=h_fillet, xdir=-1, ydir=-1, fillet=1);


// see the explanation on filled_add_x
module fillet_dif_x (r, h, ydir, zdir, fillet)
{
      if ((ydir == 1) && (zdir == 1)) {
      rotate ([0,90,0])
        fillet_dif_z (r=r, h=h, xdir=-1, ydir=1, fillet=fillet);
    } else if ((ydir == -1) && (zdir == 1)) {
      rotate ([0,90,0])
         fillet_dif_z (r=r, h=h, xdir=-1, ydir=-1, fillet=fillet);
    } else if ((ydir == 1) && (zdir == -1)) {
       rotate ([0,90,0])
       fillet_dif_z (r=r, h=h, xdir=1, ydir=1, fillet=fillet);
    } else if ((ydir == -1) && (zdir == -1)) {
       rotate ([0,90,0])
       fillet_dif_z (r=r, h=h, xdir=1, ydir=-1, fillet=fillet);
    } else {
        echo ("wrong ydir, zdir");
    }
}
    
//fillet_dif_x (r=r_fillet, h=h_fillet, ydir=-1, zdir=-1, fillet=1);

module fillet_dif_y (r, h, xdir, zdir, fillet)
{
       if ((xdir == 1) && (zdir == 1)) {
      rotate ([-90,0,0])
        fillet_dif_z (r=r, h=h, xdir=1, ydir=-1, fillet=fillet);
    } else if ((xdir == -1) && (zdir == 1)) {
      rotate ([-90,0,0])
         fillet_dif_z (r=r, h=h, xdir=-1, ydir=-1, fillet=fillet);
    } else if ((xdir == 1) && (zdir == -1)) {
       rotate ([-90,0,0])
       fillet_dif_z (r=r, h=h, xdir=1, ydir=1, fillet=fillet);
    } else if ((xdir == -1) && (zdir == -1)) {
       rotate ([-90,0,0])
       fillet_dif_z (r=r, h=h, xdir=-1, ydir=1, fillet=fillet);
    } else {
        echo ("wrong xdir, zdir");
    }
}

//fillet_dif_y (r=r_fillet, h=h_fillet, xdir=-1, zdir=-1, fillet=1);
//fillet_dif_y (r=r_fillet, h=h_fillet, xdir=1, zdir=1, fillet=1);

// ---------- chamfer to add, so no need to add milimitre to avoid nonmanifold

diagonal = 4;
largo = 50;

module chamfer_hal (diagonal, largo) 
{
    difference () {
        cube ([diagonal, largo, diagonal]);
        // le pongo 2*diagonal, para no estar con cuadrados y raices
        if (diagonal < 3) {
          translate([-1,-1, diagonal+1]) rotate ([0,45,0]) cube ([4*diagonal, largo+2, 4*diagonal]);
        } else {
          translate([-1,-1, diagonal+1]) rotate ([0,45,0]) cube ([2*diagonal, largo+2, 2*diagonal]);
        }  
    }
}

*chamfer_hal(diagonal=diagonal, largo=largo);

module base_fillet_add (r, h, fillet)
{  
  
  if (fillet==1) 
  {    
    difference ()
    {

     cube([r+nmf_add,r+nmf_add,h]);
     translate([0,0,-1])cylinder(r=r, h=h+2, $fa=1, $fs=0.5);
    }
  } else { // chamfer
    difference ()
    {
      cube([r+nmf_add,r+nmf_add,h]);
      translate([0,0,-1])cylinder(r=r, h=h+2, $fn=4);
    }
  }
      
}

//base_fillet_add (r=r_fillet, h=h_fillet, fillet=1);
*base_fillet_add (r=r_fillet, h=h_fillet, fillet=0);

// ------------------------ fillet_add_z ------------------------
// adds a vertical fillet
// Makes a fillet in a vertical line used for union difference
// r: Radius of the fillet
// h: Height of the fillet
// ---------- taken out
// //  x: position of the fillet (lowest X point)
// //  Y: position of the fillet (lowest Y point)
// ---------------
// xdir: x direction of the fillet. Values: 1, -1
// ydir: y direction of the fillet. Values: 1, -1
//
//                   Y
//                   |    
//   x=-1        |   |   |      x=1, y=1
//   y= 1      _ /   |   \_    
//                   |
//         -------------------> X +
//             _     |    _     
//   x=-1        \   |   /         x=1
//   y=-1        |   |   |      y=-1
//                   |
// fillet: fillet or chamfer
//         1: fillet
//         0: chamfer


//module fillet_add_z (r, h, x, y, xdir, ydir, fillet)

module fillet_add_z (r, h, xdir, ydir, fillet)
{
// This is what we want to do:    
//    if ((xdir == 1) && (ydir == 1)) {
//      rotation = 180;
//    } else if ((xdir == -1) && (ydir == 1)) {
//      rotation = 270;  
//    } else if ((xdir == -1) && (ydir == -1)) {
//      rotation = 0;
//    } else if ((xdir ==  1) && (ydir == -1)) {
//      rotation = 90;
//    } else {
//      echo ("Error: incorrect values for xdir, ydir");
//    }
// But since it is not possible in oscad, we do this way:
    // atan gives 45 when xdir== 1 and ydir== 1 
    //                 or xdir==-1 and ydir==-1
    // so we make it 0
    //
    // atan gives -45 when xdir==-1 and ydir== 1 
    //                  or xdir== 1 and ydir==-1
    // so whe make it -90 (270)
    //
    angle_aux =  atan (ydir/xdir) - 45;
    //echo ("angle: ", angle_aux);
     
    // when xdir == 1 we add 180, making:
    // from 0 of (xdir==1 and ydir==1) to 180
    // from -90 of (xdir==1 and ydir== -1) to 90
    rotation = (xdir == 1) ? angle_aux +180 : angle_aux;
        
    //echo ("rotation: ", rotation);
    
    //translate([x,y,0]) // required translation
      translate([xdir*r, ydir*r,0])  // to have it in 0,0
      rotate ([0,0,rotation])
      base_fillet_add (r=r, h=h, fillet=fillet);
}
    
fillet_add_z (r=r_fillet, h=h_fillet, xdir=1, ydir=1, fillet=1);
//fillet_add_z (r=r_fillet, h=h_fillet, xdir=-1, ydir=1, fillet=0);
//%fillet_add_z (r=r_fillet, h=h_fillet, xdir=1, ydir=-1, fillet=1);
//#fillet_add_z (r=r_fillet, h=h_fillet, xdir=-1, ydir=-1, fillet=1);

// ----------------------------- fillet_add_x -----------------
// adds a fillet on the X axis (laying down).
// It will be on the origin. 
// translate it to move it. Place it on the lowest X point

//
//                   Z
//                   |    
//   y=-1        |   |   |      y=1, z=1
//   z= 1      _ /   |   \_    
//                   |
//         -------------------> Y +
//             _     |    _     
//   y=-1        \   |   /      y=1
//   z=-1        |   |   |      z=-1
//                   |
// fillet: fillet or chamfer
//         1: fillet
//         0: chamfer


module fillet_add_x (r, h, ydir, zdir, fillet)
{
    if ((ydir == 1) && (zdir == 1)) {
      rotate ([0,90,0])
        fillet_add_z (r=r, h=h, xdir=-1, ydir=1, fillet=fillet);
    } else if ((ydir == -1) && (zdir == 1)) {
      rotate ([0,90,0])
         fillet_add_z (r=r, h=h, xdir=-1, ydir=-1, fillet=fillet);
    } else if ((ydir == 1) && (zdir == -1)) {
       rotate ([0,90,0])
       fillet_add_z (r=r, h=h, xdir=1, ydir=1, fillet=fillet);
    } else if ((ydir == -1) && (zdir == -1)) {
       rotate ([0,90,0])
       fillet_add_z (r=r, h=h, xdir=1, ydir=-1, fillet=fillet);
    } else {
        echo ("wrong ydir, zdir");
    }
}

//fillet_add_x (r=r_fillet, h=h_fillet, ydir=1, zdir=-1, fillet=1);


// ----------------------------- fillet_add_y -----------------
// adds a fillet on the Y axis (laying down).
// It will be on the origin. 
// translate it to move it. Place it on the lowest Y point

//
//                   Z
//                   |    
//   x=-1        |   |   |      x=1, z=1
//   z= 1      _ /   |   \_    
//                   |
//         -------------------> X +
//             _     |    _     
//   x=-1        \   |   /      x=1
//   z=-1        |   |   |      z=-1
//                   |
// fillet: fillet or chamfer
//         1: fillet
//         0: chamfer


module fillet_add_y (r, h, xdir, zdir, fillet)
{
    if ((xdir == 1) && (zdir == 1)) {
      rotate ([-90,0,0])
        fillet_add_z (r=r, h=h, xdir=1, ydir=-1, fillet=fillet);
    } else if ((xdir == -1) && (zdir == 1)) {
      rotate ([-90,0,0])
         fillet_add_z (r=r, h=h, xdir=-1, ydir=-1, fillet=fillet);
    } else if ((xdir == 1) && (zdir == -1)) {
       rotate ([-90,0,0])
       fillet_add_z (r=r, h=h, xdir=1, ydir=1, fillet=fillet);
    } else if ((xdir == -1) && (zdir == -1)) {
       rotate ([-90,0,0])
       fillet_add_z (r=r, h=h, xdir=-1, ydir=1, fillet=fillet);
    } else {
        echo ("wrong xdir, zdir");
    }
}


//#fillet_add_y (r=r_fillet, h=h_fillet, xdir=1, zdir=-1, fillet=1);
//fillet_add_y (r=r_fillet, h=h_fillet, xdir=-1, zdir=1, fillet=1);
//%fillet_add_y (r=r_fillet, h=h_fillet, xdir=1, zdir=1, fillet=1);
//fillet_add_y (r=r_fillet, h=h_fillet, xdir=-1, zdir=-1, fillet=1);
