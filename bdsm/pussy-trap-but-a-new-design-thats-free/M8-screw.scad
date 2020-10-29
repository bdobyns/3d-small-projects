include<../../lib/ISOThread.scad>

difference() {
    rotate([0,0,18])
    union() {
        hex_bolt(8,40);                         // make an M8 wingnut
        translate([0,0,2.5]) hex_nut(8);
        translate([0,0,3.7]) hex_nut(8);
    }
   // translate([0,0,-1]) cube(size=[10,10,10], center=false);
}

scale([1.1,1.1,.88])
translate([66.75,-33.75,6])
rotate([90,0,0])import("nut1.stl");