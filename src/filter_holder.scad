/* Filter Holder
   To be pulled by a belt and holes to attach it to a linear guide
  ----------------------------------------------------------------------------
  -- (c) Felipe Machado
  -- Area of Electronic Technology. Rey Juan Carlos University (urjc.es)
  -- https://github.com/felipe-m
  -- 2017
  ----------------------------------------------------------------------------
  --- LGPL Licence
  ----------------------------------------------------------------------------

                         Z
                         :
                         :
          ___    ___     :     ___    ___       ____
         |   |  |   |    :    |   |  |   |     | || |
         |...|__|___|____:____|___|__|...|     |_||_|
         |         _           _         |     |  ..|
         |        |o|         |o|        |     |::  |
         |        |o|         |o|        |     |::  |
         |                               |     |  ..|
         |                               |     |  ..|
         |      (O)             (O)      |     |::  |
         |                               |     |  ..|
         |                               |     |  ..|
         |  (O)   (o)   (O)   (o)   (O)  |     |::  |
         |_______________________________|     |  ..|
         |_______________________________|     |     \_________________
         |  :.........................:  |     |       :............:  |
         |   :                       :   |     |        :          :   |
         |___:_______________________:___|     |________:__________:___|..>X



          _______________________________ ......> Y (width)
         |____|                     |____|
         |____   <  )          (  >  ____|
         |____|_____________________|____|
         |_______________________________|
         |  ___________________________  |..................
         | | ......................... | |...filt_supp_in  :
         | | :                       : | |                 :
         | | :                       : | |                 + filt_hole_d
         | | :                       : | |                 :
         | | :.......................: | |                 :
         | |___________________________| |.................:
          \_____________________________/
                        :
                        :
                        :
                        X (depth)



                       axis_h
                         :
                         :
          ___    ___     :     ___    ___ 
         |   |  |   |    :    |   |  |   |
         |...|__|___|____:____|___|__|...|...
         |         _           _         |   2 * bolt_linguide_head_r_tol
         |        |o|         |o|        |-----------------------
         |        |o|         |o|        |--------------------  +boltrow1_4_dist
         |                               |                   :  :
         |                               |                   +boltrow1_3_dist
         |      (O)             (O)      |--:                :  :
         |                               |  +boltrow1_2_dist :  :
         |                               |  :                :  :
         | (O)    (o)   (O)   (o)    (O) |--:----------------:--:
         |_______________________________|  + boltrow1_h
         |_______________________________|..:..................
         |  :.........................:  |..: filt_hole_h  :
         |   :                       :   |                 + base_h
         |___:___________x___________:___|.................:........axis_w
                         :     : :    :
                         :.....: :    :
                         : + boltcol1_dist
                         :       :    :
                         :.......:    :
                         : + boltcol2_dist
                         :            :
                         :............:
                            boltcol3_dist




                                     belt_clamp_l
                                    ..+...
                                    :    :
          _______________x__________:____:...................> axis_w
         |____|                     |____|..                :
         |____   <  )          (  >  ____|..: belt_clamp_t  :+ hold_d
         |____|_____________________|____|..................:
         |_______________________________|
         |  ___________________________  |.................
         | | ......................... | |..filt_supp_in   :
         | | :                       : | |  :              :
         | | :                       : | |  :              :+filt_hole_d
         | | :                       : | |  + filt_supp_d  :
         | | :.......................: | |..:              :
         | |___________________________| |.................:
          \_____________________________/.....filt_rim
         : : :                       : : :
         : : :                       : : :
         : : :                       :+: :
         : : :            filt_supp_in : :
         : : :                       : : :
         : : :.... filt_supp_w ......: : :
         : :                           : :
         : :                           : :
         : :...... filt_hole_w   ......: :
         :                             :+:
         :                      filt_rim :
         :                               :
         :....... tot_w .................:




                ____...............................
               | || |   + belt_clamp_h            :
               |_||_|...:................         :
               |  ..|                   :         :
               |::  |                   :         :
               |::  |                   :         :
               |  ..|                   :         :
               |  ..|                   :         :+ tot_h
               |::  |                   :         :
               |  ..|                   :+hold_h  :
               |  ..|                   :         :
               |::  |                   :         :
               |  ..|                   :         :
               |     \________________  :         :
               |       :...........:  | :         :
               |        :         :   | :         :
               x________:_________:___|.:.........:...>axis_d
               :                      :
               :                      :
               :...... tot_d .........:
 

*/


use  <oscad_utils/chamfer.scad>

// La base donde va el filtro.
// Dimensiones exteriores
base_filtro_x = 39.5;
base_filtro_y = 80;
base_h = 8;

// Dimensions of the filter, taking this filter dimensions: lf102249
// http://www.deltaopticalthinfilm.com/product/lv-vis-bandpass-filter-b/

filter_l = 60;
filter_w = 25;
filter_t = 2.5;
filter_tol = 0.4;

// Filter hole with tolerances, to make it fit
// Note that now the dimensions width and length are changed.
// to depth and width
// they are relative to the holder width and depth, not to the filter length
// and width
filt_hole_w = filter_l + filter_tol;
filt_hole_d = filter_w + filter_tol;
filt_hole_h = filter_t + filter_tol/2; //0.5 the tolerance for height

// The hole under the filter to let the light go through
// and big enough to hold the filter
filt_supp_in = 2; 
// we could take filter_hole dimensions or filter dimensiones (tol difference)
filt_supp_d = filt_hole_d - 2 * filt_supp_in;
filt_supp_w = filt_hole_w - 2 * filt_supp_in;

fillet_r = 1;  //radius of the fillet

// separation of the bolts

boltrow1_2_dist = 12.5;
// bolt separation along axis perpendicular to rail in linear guide MGN12H
boltrow1_3_dist = 20; 
// bolt separation along axis perpendicular to rail in linear guides:
// SEBLV16 y SEBS15MGN12H
boltrow1_4_dist = 25;

// Bolt separation along the rail of SEBLV16, SEBS15, MGN12H linear guides
linguide_boltsep_d = 20;
boltcol1_dist = linguide_boltsep_d / 2;
boltcol2_dist = 12.5; // bolt distance of Thorlabs breadboard
boltcol3_dist = 25;   // 2xbolt distance of Thorlabs breadboard

despl_sop_guia_x = 8; // que se desplaza hacia atras, el resto se solapa con la base_filtro


// Radius of M4 thruhole
m4_r = 2.15; // diameter 4.3, 0.3 tolerance


//m4_head_r = 3.65; // diametro 7.3mm. La cabeza es de 7
m4_head_r = 3.7; // v05: diametro 7.4mm. La cabeza es de 7

// Radio de los taladros M3
m3_r = 1.6; // diametro 3.2, 0.2 de tolerancia
//m3_head_r = 2.85; // diameter 5.7mm. head is 5.5
m3_head_r = 2.9; // v05: diameter 5.8mm. head is 5.5

bolt_linguide_head_r_tol = m3_head_r;
bolt_cen_head_r_tol = m4_head_r;

boltrow1_h = 2 * bolt_cen_head_r_tol;


// dimensions for bolts
low_hole_z = boltrow1_h + base_h; //14;
// donde en la X empieza el taladro, lo que se va para atras, + mm to avoid non-manifold
hole_x = despl_sop_guia_x+1; 


// holder, just the part that holds, not the filter support
hold_d = 12;
sop_guia_y = base_filtro_y;
hold_h = (base_h +  boltrow1_h + boltrow1_4_dist
                 + 2 * bolt_linguide_head_r_tol); //45;


// -------------------- Filter base  ---------------------------------------
// Esta diferencia es la base del filtro

difference () {

// La base del filtro, centrada en el eje X
translate([0,-base_filtro_y/2,0]) cube([base_filtro_x, base_filtro_y, base_h]);

// El hueco del filtro
translate ([(base_filtro_x-filt_hole_d)/2,
            -filt_hole_w/2,
            base_h - filt_hole_h/2])
   cube([filt_hole_d, filt_hole_w, filt_hole_h+1]);
   //el +1 del eje Z es para evitar non-manifold

// the hole under the filter to let the light go through
union () {
for (x=[-1,1])
    for (y=[-1,1])
        translate([
          base_filtro_x/2 + x * (filt_supp_d/2-fillet_r),
          y * (filt_supp_w/2 - fillet_r),
          -1])
         cylinder (r=fillet_r, h=base_h+2,$fa=1, $fs=0.5);
    
  //Length along X, width along Y
  translate([(base_filtro_x-filt_supp_d)/2,
            -(filt_supp_w/2-fillet_r),
            -1]) 
    cube ([filt_supp_d,filt_supp_w-2*fillet_r, base_h +2]);
    
 translate([(base_filtro_x-filt_supp_d)/2+fillet_r,
            -(filt_supp_w/2),
            -1]) 
    cube ([filt_supp_d-2*fillet_r,filt_supp_w, base_h +2]);
    
 
}
 
// chaflanes 

r_fillet = 5;
translate ([base_filtro_x,  base_filtro_y/2, 0]) 
  redondeo_xy (r_fillet=r_fillet, h_fillet=base_h);

translate ([base_filtro_x,  -base_filtro_y/2, 0]) 
  redondeo_xmy (r_fillet=r_fillet, h_fillet=base_h);

}

  
// ------------------------------ SOPORTE VERTICAL QUE UNE CON LA GUIA ----------------




module bolt (radio, head_r)
{
  union () {
    translate([-hole_x,0,low_hole_z])rotate([0,90,0])
      cylinder(r=radio, h=hold_d, $fa=1, $fs=0.5);

    translate([0,0,low_hole_z])rotate([0,90,0])
      cylinder(r=head_r,h= hold_d-despl_sop_guia_x+1,$fa=1, $fs=0.5);
}
}


// Necesito hacer la cabeza de dos y unirlas
module cabeza_tornillo (head_r)
{
    translate([0,0,low_hole_z])rotate([0,90,0])
      cylinder(r=head_r,h= hold_d-despl_sop_guia_x+1,$fa=1, $fs=0.5);
}

module vastago_tornillo (radio)
{
    translate([-hole_x,0,low_hole_z])rotate([0,90,0])
      cylinder(r=radio, h=hold_d, $fa=1, $fs=0.5);    
}


// Belt clamp hole thickness
//GT2 thickness is 1.38mm, since there are 2 belts clamped, it would be around
// 2mm, but 3 including tolerances:
belt_clamp_t = 3;

// Belt clamp length
belt_clamp_l = 14;
belt_clamp_h = 8; // width of the belt is 6 (+2) -> height of the clamp
belt_clamp_blk_t = (hold_d-belt_clamp_t)/2;

//pos_z_belt = low_hole_z + boltrow1_2_dist;
//pos_z_belt = hold_h - belt_clamp_h;
pos_z_belt = hold_h;

// referenciado a la esquina izquierda trasera
module atrapa_gt2 () 
{
    translate ([-despl_sop_guia_x,-sop_guia_y/2,pos_z_belt]) cube([belt_clamp_blk_t, belt_clamp_l, belt_clamp_h]);
}

// ---------------------- blocks to catch the belt -------------------

// El hueco para poner estos bloques
// Este hueco por ahora no se usa
y_hueco_atrapa_gt2 = sop_guia_y/2 - boltcol1_dist - m3_head_r - 5; 
y_hueco_atrapa_gt2_mn = y_hueco_atrapa_gt2 + 1; // +1 para evitar non+manifold

// Dejar 1.5 a cada lado, ya que la correa es de 1.38 de grosor
radio_atrapa_gt2_gr = (hold_d - 3) / 2;
// el del cilindro pequeno
radio_atrapa_gt2_pq = 1;

distancia_bloque_atrapa_cilindro = 4 + radio_atrapa_gt2_pq;

module rodea_gt2 () 
{
  hull () {
  // El cilindro para que la correa le rodee
  // La x la pongo a cero porque con la rotacion se queda descuadrada, y la muevo luego
  translate ([0,
              -sop_guia_y/2+belt_clamp_l+radio_atrapa_gt2_gr*2+distancia_bloque_atrapa_cilindro,
               pos_z_belt])
    cylinder (r=radio_atrapa_gt2_gr, h=belt_clamp_h,$fa=1, $fs=0.5);

  // El cilindro pequeno
  translate ([0,
              -sop_guia_y/2+belt_clamp_l+distancia_bloque_atrapa_cilindro,
              pos_z_belt])
     cylinder (r=radio_atrapa_gt2_pq, h=belt_clamp_h,$fa=1, $fs=0.5);
  }
}




difference () {
  union () {
    translate([-despl_sop_guia_x, -sop_guia_y/2,0])
      cube([hold_d, sop_guia_y, hold_h]);
    translate ([-despl_sop_guia_x+hold_d/2,0,0]) rodea_gt2 ();
    translate ([-despl_sop_guia_x+hold_d/2,0,0]) rotate ([0,0,180]) rodea_gt2();
      // Los bloques paralaleos que atrapan la correa
    atrapa_gt2();
    translate ([hold_d-belt_clamp_blk_t,0,0]) atrapa_gt2();
    translate ([0,sop_guia_y-belt_clamp_l,0]) atrapa_gt2();
    translate ([hold_d-belt_clamp_blk_t,sop_guia_y-belt_clamp_l,0]) atrapa_gt2();
  }

// Cubo que hace el hueco para que vayan las atrapa guias
//translate ([-despl_sop_guia_x-1,-sop_guia_y/2-1,pos_z_belt]) cube([hold_d+2, y_hueco_atrapa_gt2_mn, belt_clamp_h+1]);
//translate ([-despl_sop_guia_x-1,sop_guia_y/2-y_hueco_atrapa_gt2_mn+1,pos_z_belt]) cube([hold_d+2, y_hueco_atrapa_gt2_mn, belt_clamp_h+1]);
    
bolt (m4_r, m4_head_r);
// Taladros de Thorlabs
translate([0,boltcol3_dist,0]) bolt(m4_r, m4_head_r);
translate([0,-boltcol3_dist,0]) bolt(m4_r, m4_head_r);
translate([0,boltcol2_dist,boltrow1_2_dist]) bolt(m4_r, m4_head_r);
translate([0,-boltcol2_dist,boltrow1_2_dist]) bolt(m4_r, m4_head_r);

// Taladros de NB SEBS15A y SEBLV16 (Misumi)
translate([0,boltcol1_dist,0]) bolt(m3_r, m3_head_r);
translate([0,-boltcol1_dist,0]) bolt(m3_r, m3_head_r);
// Estos estan unidos, asi que hago las cabezas y los vastagos separados
//translate([0,boltcol1_dist,25]) bolt(m3_r, m3_head_r);
//translate([0,-boltcol1_dist,25]) bolt(m3_r, m3_head_r);
//translate([0,boltcol1_dist,boltrow1_3_dist]) bolt(m3_r, m3_head_r);
//translate([0,-boltcol1_dist,boltrow1_3_dist]) bolt(m3_r, m3_head_r);

// Cabezas y vastagos separados:
translate([0,boltcol1_dist,boltrow1_4_dist]) vastago_tornillo(m3_r);
translate([0,-boltcol1_dist,boltrow1_4_dist]) vastago_tornillo(m3_r);
translate([0,boltcol1_dist,boltrow1_3_dist]) vastago_tornillo(m3_r);
translate([0,-boltcol1_dist,boltrow1_3_dist]) vastago_tornillo(m3_r);
hull () {
  translate([0,boltcol1_dist,boltrow1_4_dist]) cabeza_tornillo(m3_head_r);
  translate([0,boltcol1_dist,boltrow1_3_dist]) cabeza_tornillo(m3_head_r);
}
hull () {
  translate([0,-boltcol1_dist,boltrow1_4_dist]) cabeza_tornillo(m3_head_r);
  translate([0,-boltcol1_dist,boltrow1_3_dist]) cabeza_tornillo(m3_head_r);
   
}


// Los redondeos de las esquinas
translate([-despl_sop_guia_x, sop_guia_y/2,0]) redondeo_mxy(r_fillet=2, h_fillet= pos_z_belt+belt_clamp_h);
translate([-despl_sop_guia_x, -sop_guia_y/2,0]) redondeo_mxmy(r_fillet=2, h_fillet= pos_z_belt+belt_clamp_h);

}



translate ([hold_d-despl_sop_guia_x,-base_filtro_y/2,base_h]) chaflan_hal (diagonal = 2, largo= base_filtro_y);

