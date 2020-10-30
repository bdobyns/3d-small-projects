
include<../../lib/jar_lid.scad>  // for hollow_ring()

translate([-10,40,0])
difference() {
    // threaded bar end
    import("Shortbar1.stl");

    // subtract off most of the rest of the bar
    color("red")
        translate([20,-55,-15])
            cube([300,30,30]);

    // whack off the bottom, leaving just the thread
    color("green")
        translate([0,-50,5.2])
            cube([30,20,5]);
    
    // whack off the top, down to the thread
    color("green")
        translate([0,-50,-10.3])
            cube([35,20,5]);
    
    // cut off the irregular remainder
    translate([10,-40,-15])
        color("pink")
            hollow_ring(id=15, od=40, ht=30);
    
}

translate([-50,-50,-7])
difference() {
    // knurled end of screw
    color("blue")
        import("Screw.stl");
    
    // cut a hole in the middle
    translate([50,50,-10]) 
        color("red") 
            cylinder(d=13, h=150);

    // whack off the bottom so it's the same size as the threaded bit
    translate([40,40,-4.3])
        cube([30,20,6]);
    
    // whack off the top so it's the same size as the threaded bit
    translate([40,40,12.3])
        cube([35,20,6]);
}
