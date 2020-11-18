    c=1.5;
    e=3.2;
    f=0;

translate([35.38,0,0])  color("red") one_rod();
translate([-76/2,0,0])  one_rod();

module one_rod() {
difference() {
    import("1.4_28_3in-ALUMINUM THREADED ROD_fixed.stl");


    translate([0,0,e+f]) rotate([45,0,0]) cube([80,c,c],true);
    translate([0,0,-(e+f)]) rotate([45,0,0]) cube([80,c,c],true);
    translate([0,e+f,0]) rotate([45,0,0]) cube([80,c,c],true);
    translate([0,-(e+f),0]) rotate([45,0,0]) cube([80,c,c],true);
}
}

/*
translate([36.71,0,0]) import("/Users/bdobyns/Dropbox/Play/3dprint/3d-small-projects/bdsm/bd Pussy Clamp/Mc Master Carr/1.4-20-3in-90322A654_grooved-THREADED ROD.stl");
translate([-76/2,0,0])import("/Users/bdobyns/Dropbox/Play/3dprint/3d-small-projects/bdsm/bd Pussy Clamp/Mc Master Carr/1.4-20-3in-90322A654_grooved-THREADED ROD.stl");
*/