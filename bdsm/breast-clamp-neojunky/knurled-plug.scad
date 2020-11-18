
include<../../lib/jar_lid.scad>  // for hollow_ring()



translate([-50,-50,-7])
difference() {
    // knurled end of screw
    color("blue")
        import("Screw.stl");
    


    // whack off the bottom so it's the same size as the threaded bit
    translate([40,40,-4.3])
        cube([30,20,6]);
    
    // whack off the top so it's the same size as the threaded bit
    translate([40,40,12.3])
        cube([35,20,226]);
}
