include<../lib/jar_lid.scad>  


$fn=60;
// old, bad, complicated main ring
// hollow_ring(od=31.8, id=27.5, ht=20);
/*
// Internal dome so we don't need supports
p=32.1;
e=5;
translate([0,0,p/2+e])
 color("red")
  difference() {
    sphere(d=p);
    sphere(d=p-3);
    translate([0,0,p/2])
      cube([p+e,p+e,p+e], center=true);
}
// inner nubs, increase the strength of the whole without being solid
grip_cutouts(pos=0,dia=27,wid=8,ht=16.14,arc=360,cnt=5);
*/



// main ring
difference() {
    cylinder(d=31.8, h=20);
    translate([0,0,21]) sphere(d=28);
}


// cap lid
cylinder(d=38.1, h=3.1);
resize([38.2,38.2,8]) translate([0,0,-2.5])sphere(d=38); 
// outer nubs
grip_cutouts(pos=0,dia=31.5,wid=4,ht=17,arc=360,cnt=10); 


// body of the upper half 
u=26;
ep=1;
translate([0,0,-(u-ep*2)]) {
    // upper cylinder
    // hollow_ring(od=u, id=u-ep, ht=u-ep);

    resize([u,u,8]) sphere(d=u+3);
    translate([0,0,2.4]) color("pink") sphere(6.2);
    // cylinder(d=u+3,h=3);
}


// upper cable guides
cnt=5;
arc=360;
step=360/cnt;
rw=5;
ic=32;
// filler between the rings so it's solid
translate([0,0,-27])color("red") cylinder(d=rw, h=ic);
// spin this around
for(rot= [0: step : arc ]) {
    rotate(a=rot,v=[0,0,1])
    // one cable guide
    translate([(u)/2+ep,rw/2,-(u+3)/2+3])
      rotate([90,0,0]) 
        color("blue")
            hollow_ring(od=u+ep, id=u-rw+ep, ht=rw);
}



