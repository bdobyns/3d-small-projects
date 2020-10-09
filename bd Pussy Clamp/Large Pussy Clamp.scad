use <cubeX.scad>;


// center part
difference() {
    rotate ([90,0,0]) import("main body.stl");

}




translate([0,-9,0])  
union() {
// one side ring
difference() {
    color("red") hollow_ring(od=90,id=78,ht=10,[0,10,0]);
    e=150;
    translate([-e/2,-63,-1]) color("green") cube([e,80,12]);
}
    color("blue") translate([38,16,0]) ear([18,8,10]);
}
module ear(v=[10,10,10], cut=5) {
    cubeX(v,radius=1,rounded=true,$fn=16);
    difference() { 
        
    }
 
    
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
