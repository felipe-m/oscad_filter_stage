/*
 *    OpenScad constants for bolt
 *
 *    Copyright (C) 2016 Felipe Machado
 *    Universidad Rey Juan Carlos, Spain
 *    https://github.com/felipe-m
 *    License: LGPL 3.0 or later
 *
 *    to use this functions include in your file:
 * include <bolts.scad>
 *    if not in the same directory:
 * include <PATH_TO/bolts.scad>
*/


// Tolerance
tol =  0.4;
// Tolerance for small objects
stol = 0.2;

h_layer3d = 0.3;
$fa=1;
$fs=0.5;

// Nuts and bolt sizes
m3_r = 1.5;  
m4_r = 2;    
m5_r = 2.5;  

// Tolerances stol/2 because is the radius
m3_r_tol = m3_r + stol/2;  // M3 diameter 3.2 mm for the tolerance
m4_r_tol = m4_r + stol/2;  // M4 diameter 4.2 mm for the tolerance
m5_r_tol = m5_r + (tol + stol)/4;  // M5 diameter 5.3 mm for the tolerance
//echo ("m3_r_tol", m3_r_tol);
//echo ("m4_r_tol", m4_r_tol);

// -------------- Head sizes DIN-912 bolts
// Head radius DIN-912 bolts
m3_head_r  = 5.5/2;
m4_head_r  = 7/2;
m5_head_r  = 8.5/2;
m6_head_r  = 10/2;
m8_head_r  = 13/2;
m10_head_r = 16/2;

// Head radius DIN-912 bolts with tolerances. 
// divided by 2 because is the radius
m3_head_r_tol  = m3_head_r  + tol/2;
m4_head_r_tol  = m4_head_r  + tol/2;
m5_head_r_tol  = m5_head_r  + tol/2;
m6_head_r_tol  = m6_head_r  + tol/2;
m8_head_r_tol  = m8_head_r  + tol/2;
m10_head_r_tol = m10_head_r + tol/2;

// Head length DIN-912 bolts
m3_head_l = 3;
m4_head_l = 4;
m5_head_l = 4;
m6_head_l = 6;
m8_head_l = 8;

// M3 nut
m3_nut_r = 6.01/2;  // DIN934 M3 nut circumradius
m3_nut_h = 2.4;     // DIN934 M3 nut height

//less tolerance for small numbers. 0.2 (diameter)
m3_nut_r_tol = m3_nut_r + stol/2;  //radius: diam/2
m3_nut_h_tol = m3_nut_h + tol;

// M4 nut
m4_nut_r = 7.66/2;  // DIN934 M4 nut circumradius
m4_nut_h = 3.2;     // DIN934 M4 nut height
m4_nut_ap = 7/2;    // DIN934 M4 nut apotheme

//less tolerance for small numbers. 0.2 (diameter)
m4_nut_r_tol  = m4_nut_r + stol/2;  //radius: diam/2
m4_nut_h_tol  = m4_nut_h + tol;
m4_nut_ap_tol = m4_nut_ap + stol/2; 

// -------------------- DIN 9021 Washers ----------------
// outer radius (or)
m6_wash9021_or = 18 / 2;
// height
m6_wash9021_h = 1.6;
