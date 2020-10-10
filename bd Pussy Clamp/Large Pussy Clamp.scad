// generally remixed from
// https://cults3d.com/en/3d-model/naughties/pussy-clamp-wide-thecuddlesdom

use <cubeX.scad>;

// center part unmodified
rotate ([90,0,0]) import("main body.stl");


// one redesigned side (the old one was the wrong shape)
// the original maker reused the side from 
//   https://cults3d.com/en/3d-model/naughties/pussy-clamp-narrow
// but that has the wrong interior radius
side();
// the other side
rotate([0,0,180]) side();

// two of the redesigned bolts with heads
translate([15,15,0]) bolt_with_head();
translate([-15,15,0]) bolt_with_head();

// then we need four nuts
translate([15,0,0]) one_nut();
translate([-15,0,0]) one_nut();
translate([15,-15,0]) one_nut();
translate([-15,-15,0]) one_nut();

module side() {
    translate([0,-7,0])  
        union() {
            // one side ring
            difference() {
                color("red") hollow_ring(od=90,id=78,ht=10,[0,10,0]);
                e=150;
                translate([-e/2,-61,-1]) color("green") cube([e,80,12]);
            }
        color("blue") translate([37.8,15,0]) 
            ear(w=18,d=8,h=10,cut=5);
        color("green") translate([-37.5,15,10]) rotate([0,180,0])
            ear(w=18,d=8,h=10,cut=5);
        }
}

module ear(w=10,d=10,h=10, cut=5) {
    difference() {
        color("green") _ear([w,d,h]);
        translate([cut,cut+1,-1]) difference() {
            color("tan") translate([(-w-1),(-d-1),-2]) _ear([w,d,h+4]);
            color("purple") translate([0,-1,-3]) cylinder(h=h+6,r=cut,$fn=60);
        }
        color("pink") rotate([90,0,0]) translate([11,5,-15])  
          cylinder(d=7,h=30,$fn=60);      
    }
} 

module _ear(v=[10,10,10], cut=5) {
        cubeX(v,radius=1,rounded=true,$fn=16);
}
 
// the we decided to put an "end" on the bolt
module bolt_with_head() {
    color("purple") cylinder(d=10,h=5);
    rotate([0,180,0]) translate([49.25,-5,-51.25]) 
        union() {
            import("nut.stl");
            import("bolt.stl");
        }
}

// this is a nut, reoriented and at the origin
module one_nut() {
    rotate([0,180,0]) translate([49.25,-5,-51.25]) import("nut.stl");
}


module hollow_ring(pos=[0,0,0], od=10, id=5, ht=5) { 
    union() {
        translate(v = pos) {
            difference() {
                $fn=global_fn;
                cylinder(h=ht,d=od,$fn=60);
                translate([0,0,-0.5]) {
                    cylinder(h=(ht+1),d=id,$fn=60);
                }
            }
        }
    }
}
