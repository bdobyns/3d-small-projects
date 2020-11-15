// This fits inside the triangular compartment in the parts drawer for the CR-6SE and holds your nozzeles
// drawer organizer here:  https://www.thingiverse.com/thing:4612526
//
// this by:
//   Nov-15-2020
//   bdobyns@gmail.com
//   https://www.facebook.com/barry.dobyns/   

use<../lib/text_on.scad>

maxx = 64;  // x dimension of the triangle
maxy = 84; // y dimension of the triangle
ht=5; // how high the thread part of the nozzle is
dia=5.9; // diameter of holes
spc=7; // spacing between holes
txt=false;
show_dims=false;

difference() {
// this is the basic triangle
linear_extrude(height=ht) 
  polygon(points = [[0,0],[maxx,0],[0,maxy]]);
   
    // make a lot of holes (maybe more than we need? by cube filling?
    
    
    for (xx = [ spc/2: spc: maxx ] ) {
        for ( yy = [spc/2: spc : maxy ] ) {
            // some of the holes are on-edge, do we want to work of removing them?
            if ( (yy< 6) && (xx < 55) ) one_cyl(xx, yy, dia);  
            if ( (yy< 11) && (xx < 47) ) one_cyl(xx, yy, dia);
            if ( (yy< 20) && (xx < 47) ) one_cyl(xx, yy, dia);
            if ( (yy< 27) && (xx < 40) ) one_cyl(xx, yy, dia);
            if ( (yy< 32) && (xx < 32) ) one_cyl(xx, yy, dia);
            if ( (yy< 40) && (xx < 31) ) one_cyl(xx, yy, dia);
            if ( (yy< 47) && (xx < 31) ) one_cyl(xx, yy, dia);
            if ( (yy< 54) && (xx < 24) ) one_cyl(xx, yy, dia);
            if ( (yy< 61) && (xx < 17) ) one_cyl(xx, yy, dia);
            if ( (yy< 74) && (xx < 10) ) one_cyl(xx, yy, dia);
            if ( (yy< 74) && (xx < 10) ) one_cyl(xx, yy, dia);  
            if ( (yy< 80) && (xx < 10) ) one_cyl(xx, yy, dia);
            
            // one_cyl(xx,yy,dia);
        }
    }
}

if(show_dims) {
    for (xx = [ spc/2: spc: maxx ] ) {
        for ( yy = [spc/2: spc : maxy ] ) {
             // do some nozzle dims
            if ( (yy < 6) && (xx > 53 ) && ( xx < 53+spc) ) noz_dim("0.4",xx-2,yy,dia);
            if ( (yy > 6) && (yy < 11) && (xx > 46 ) && ( xx < 46+spc) ) noz_dim("0.4",xx-1,yy,dia);
         }
    }
}
    
module one_cyl(xx=1, yy=1, dia=1) {
    translate([xx,yy,-0.5])  {
            color("red") cylinder(d=dia, h=ht+1, center=false, $fn=25);
        // we draw the coords on the cylinders so we can decide which ones to exclude above
        // in the for loop, so that we don't have a swiss-cheese edge.  this gives us
        // a surface to write their sizes upon
        if (txt)
            color("blue") text_on_cube(cube_size=[dia,dia,ht*2.1],t=str(xx,",",yy),size=0.5,face="top");
    }
}

module noz_dim(tx,xx,yy,dia) {
   translate([xx,yy,-0.5]) rotate([0,0,-55])  {
     color("green") text_on_cube(cube_size=[dia,dia,ht*2.1],t=tx,size=1,face="top");
   }
}
