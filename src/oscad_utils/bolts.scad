/*
 *    OpenScad functions to make bolt holes
 *
 *    Copyright (C) 2016 Felipe Machado
 *    Universidad Rey Juan Carlos, Spain
 *    https://github.com/felipe-m
 *    License: LGPL 3.0 or later
 *
 *    to use this functions include in your file:
 * use <bolts.scad>
 *    if not in the same directory:
 * use <PATH_TO/bolts.scad>
 *    dont use 'include' instead of 'use' so you dont get the objects
 *    created in this file
*/


include <bolt_sizes.scad>

// the hole for the bolt shank and the nut
// Tolerances have to be included
// r_shank: Radius of the shank (tolerance included)
// l_bolt: total length of the bolt: head & shank
// r_head: radius of the head (tolerance included)
// l_head: length of the head
// hex_head: inidicates if the head is hexagonal or rounded
//            1: hexagonal
//            0: rounded
// h_layer3d: height of the layer for printing, if 0, means that the support
//            is not needed
// mnfold: 1 if you want 1 mm on top and botton to avoid non-manifold
//             pieces after makeing differences


module bolt_hole (r_shank, l_bolt, r_head, l_head, hex_head, h_layer3d, mnfold)
{
  union () {
    // we make it all the way, although it is not necessary because
    // on the lower part it will be also the nut 
    // if mnfold == 1 it will make the translations and make the piece 
    // larger
    translate([0,0,-mnfold])
      cylinder (r= r_shank, h= l_bolt+2*mnfold, $fa=1, $fs=0.5);
   if (hex_head == 0) {
      translate([0,0,-mnfold])
        cylinder (r= r_head, h= l_head+mnfold, $fa=1, $fs=0.5);  
   } else {
      translate([0,0,-mnfold])
      cylinder (r= r_head, h= l_head+mnfold, $fn=6);  
   }
    
  // This is a triangle that it is barely supported by the bolt head
  // and it will support the circle above 
  // In a regular triangle the apotheme (in radius) is twice
  // the circumradius (r)
  // Intersection with the hexagon to take the vertexs away, because
  // they are outside the hexagon
  if ( h_layer3d > 0) { // we don't do this if h_layer3d == 0
    intersection () {  
      rotate([0,0,30])translate([0,0,l_head])
        cylinder (r= r_shank*2, h=h_layer3d, $fn=3);
      // take vetexs away:
      if (hex_head == 0) {
        translate([0,0,l_head])
          cylinder (r= r_head, h= h_layer3d, $fa=1, $fs=0.5);       
      } else {
        translate([0,0,l_head])
          cylinder (r= r_head, h= h_layer3d, $fn=6);           
      }
    }
        // 1.15 is the relationship between the Radius and the Apothem
    // of the hexagon: sqrt(3)/2 . I make it slightly smaller
    translate([0,0,l_head+h_layer3d])
      //rotate ([0,0,30])
      cylinder (r=r_shank*1.15, h=h_layer3d, $fn=6);  
  
  }
 
 }  
  
}



bolt_hole (r_shank= m4_r_tol, l_bolt=10, r_head=m4_head_r_tol, l_head=m4_head_l, h_layer3d);


bolt_hole (r_shank = m4_r_tol, l_bolt=10, r_head=m4_head_r_tol, l_head=m4_head_l, hex_head=1, h_layer3d=h_layer3d, mnfold=1);

translate ([10,0,0])
#bolt_hole (r_shank = m4_r_tol, l_bolt=10, r_head=m4_head_r_tol, l_head=m4_head_l, hex_head=0, h_layer3d=h_layer3d, mnfold=0);
