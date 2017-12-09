/*
 *    OpenScad functions to chamfer
 *
 *    Copyright (C) 2016 Felipe Machado
 *    Universidad Rey Juan Carlos, Spain
 *    https://github.com/felipe-m
 *    License: LGPL 3.0 or later
 *
 *    to use this functions include in your file:
 * use <chamfer.scad>
 *    if not in the same directory:
 * use <PATH_TO/chamfer.scad>
 *    dont use 'include' instead of 'use' so you dont get the objects
 *    created in this file
*/


r_fillet = 10;
h_fillet = 10;

// redondeo: to make differences, so it has to be larger

module redondeo (r_fillet, h_fillet)
{  
  difference ()
  {
   // el -1, -2 y 2, 4 es para la diferencia interna, y luego para quitar cuando se haga el chaflan
  translate([0,0,-1])cube([r_fillet+1,r_fillet+1,h_fillet+2]);
  translate([0,0,-2])cylinder(r=r_fillet, h=h_fillet+4, $fa=1, $fs=0.5);
  }
}

redondeo (r_fillet, h_fillet);

// Chamfers an edge

module chamfer (r_fillet, h_fillet)
{  
  difference ()
  {
   // el -1, -2 y 2, 4 es para la diferencia interna, y luego para quitar cuando se haga el chaflan
  translate([0,0,-1])cube([r_fillet+1,r_fillet+1,h_fillet+2]);
  translate([0,0,-2])cylinder(r=r_fillet, h=h_fillet+4, $fn=4);
  }
}

%chamfer (r_fillet, h_fillet);


// el redondeo en la esquina frontal derecha. El origen esta para que se ponga la x e y, sin rotar
module redondeo_xy (r_fillet, h_fillet)
{
    translate ([-r_fillet, -r_fillet,0]) redondeo(r_fillet, h_fillet);
}


//redondeo_xy (r_fillet, h_fillet);

//Redondeo en la esquina frontal izquierda (x, -y)

module redondeo_xmy (r_fillet, h_fillet) 
{
    translate([-r_fillet, r_fillet,0]) rotate ([0,0,-90]) redondeo(r_fillet, h_fillet);
}

//redondeo_xmy (r_fillet, h_fillet);

// Redondeo en la esquina trasera izquierda (-x, -y) (menos X menos Y)

module redondeo_mxmy (r_fillet, h_fillet) 
{
    translate([r_fillet, r_fillet,0]) rotate ([0,0,180]) redondeo(r_fillet, h_fillet);
}

//redondeo_mxmy (r_fillet, h_fillet);


// Redondeo en la esquina trasera derecha (-x, y) (menos X Y)

module redondeo_mxy (r_fillet, h_fillet) 
{
    translate([r_fillet, -r_fillet,0]) rotate ([0,0,90]) redondeo(r_fillet, h_fillet);
}

//redondeo_mxy (r_fillet, h_fillet);

// ------------------- modulo chaflan para anadir, por lo que no hay que anadir el milimetro

//diagonal = 4;
//largo = 50;

module chaflan_hal (diagonal, largo) 
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

//chaflan_hal(diagonal=diagonal, largo=largo);
