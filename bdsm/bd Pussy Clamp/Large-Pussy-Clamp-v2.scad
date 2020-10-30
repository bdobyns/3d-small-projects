// generally remixed from
// https://cults3d.com/en/3d-model/naughties/pussy-clamp-wide-thecuddlesdom

global_fn=60;
use <cubeX.scad>;

centerhole();


module centerhole() {
    // center part unmodified
    rotate ([90,0,0]) import("large body.stl");
    
    e=37.25;
    //remove the text
    translate([e,0,0]) 
        color("violet")
            cylinder(d=9.5,h=10);
    
    //remove the text
    translate([-e,0,0]) 
        color("darkviolet")
            cylinder(d=9.5,h=10);
        
}


// my redesigned side the old one has the wrong interior radius
translate([0,10,0]) 
    side();

// the other side

rotate([0,0,180]) 
    translate([0,10,0]) 
        side();

/*
// two of the redesigned bolts with heads
translate([15,15,0]) bolt_with_head();
translate([-15,15,0]) bolt_with_head();

// then we need four nuts
translate([15,0,0]) one_nut();
translate([-15,0,0]) one_nut();
translate([15,-15,0]) one_nut();
translate([-15,-15,0]) one_nut();
*/



module side() {
    translate([0,-20,0])  
        union() {
            // one side ring
            difference() {
                color("red") 
                    hollow_ring(od=92,id=81,ht=10,[0,10,0]);
                e=150;
                translate([-e/2,-58,-1]) 
                    color("green") 
                        cube([e,79,12]);
     ex=43;
     ey=19;
     // whack off a little near the ends
        translate([ex,ey,-15]) 
          color("pink")
            rotate([0,0,45])
              cube([10,5,30]);
        
    // whack off a little near the ends                
        rotate([0,180,0])
         translate([ex,ey,-15]) 
          color("pink")
            rotate([0,0,45])
              cube([10,5,30]);              
            }
        

        // this is just the ear part of the old ones.    
        old_ear();
            
        /*
        color("blue") translate([37.8,15,0]) 
            new_ear(w=18,d=8,h=10,cut=5);
        color("green") translate([-37.5,15,10]) rotate([0,180,0])
            new_ear(w=18,d=8,h=10,cut=5); 
        */
        }
}

module old_ear() {
    translate([0,-2,0])
    difference() {
        rotate([90,0,0]) 
            color("brown")
                import("large side.stl");
        translate([0,35,0]) 
          color("tan")
            cube([76,30,30],center=true);
  
    translate([0,14,-15])
        cylinder(d=80,h=30);
    }

    //remove the text
    translate([40.8,30.4,0]) 
        color("violet")
            cylinder(d=9.5,h=10);
    
    //remove the text
    rotate([0,180,0])
    translate([40.8,30.4,-10]) 
        color("violet")
            cylinder(d=9.5,h=10);
}


module new_ear(w=10,d=10,h=10, cut=5) {
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
