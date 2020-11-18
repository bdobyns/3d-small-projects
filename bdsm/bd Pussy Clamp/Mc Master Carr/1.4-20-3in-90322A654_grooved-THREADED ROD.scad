    c=1.5;
    e=3.2;
    f=0;

difference() {
    import("1.4-20-3in-90322A654_HIGH-STRENGTH STEEL THREADED ROD_formware.stl");


    translate([0,0,e+f]) rotate([45,0,0]) cube([80,c,c],true);
    translate([0,0,-(e+f)]) rotate([45,0,0]) cube([80,c,c],true);
    translate([0,e+f,0]) rotate([45,0,0]) cube([80,c,c],true);
    translate([0,-(e+f),0]) rotate([45,0,0]) cube([80,c,c],true);
}