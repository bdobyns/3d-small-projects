// Barry A Dobyns, bdobyns@gmail.com, March 25 2015

include <M42_Sony_NEX_E-Mount-Lens_Adaptor_fixed.scad>
include <threads.scad>  // from http://dkprojects.net/openscad-threads/

// http://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#color
// http://www.openscad.org/cheatsheet/

module aperture_pin_flange(pos=0,dia=10,wid=5,ht=5) { // pos, dia, wid, ht
        e=0.5;
        translate(v = [0,0,pos])
        difference() {
            // the plate
            cylinder(h=ht, d=dia);
            
            // the hole
            translate([0,0,-e]) { 
                cylinder(h=(ht+2*e), d2=(dia+2*e), d1=(dia-wid), $fn=100); 
            }
        }
}

module hollow_ring(pos=0,dia=10,wid=5,ht=5) { // pos, dia, wid, ht
    color("blue")
    union() {
        translate(v = [0,0,pos]) {
            difference() {
                $fn=360;
                cylinder(h=ht,d=dia);
                translate([0,0,-0.5]) {
                    cylinder(h=(ht+1),d=(dia-wid));
                }
            }
        }
    }
}

module hollow_cone(pos=0,top=51,bot=61,wid=2,ht=5) { // pos, top, bot, wid, ht
    color("blue")
    union() {
        translate(v = [0,0,pos]) {
            difference() {
                $fn=360;
                cylinder(h=ht,d1=top,d2=bot);
                translate([0,0,-0.5]) {
                    cylinder(h=(ht+1),d=(top-wid));
                }
            }
        }
    }
}



module mount_lug(pos=0,dia=46,wid=7,h=2,ang=52,rot=0) { // pos, dia, wid, ht, ang, rot
    rotate(a=rot, v=[0,0,1])
    union() {
        e=0.02;
        translate(v = [0,0,pos]) {
            difference() {
                $fn=360;
                // make a disc
                cylinder(h=ht,d=dia);
                // cutout in the disc makes a ring
                translate([0,0,-0.5]) {
                    cylinder(h=(ht+1),d=(dia-wid));
                }
                // clip off half of the ring
                translate([0,(-dia/2),-e]){
                    cube([dia,dia,ht+4*e]);
                }
                // clip off all but the angle from the other side
                rotate(a=(180-ang), v=[0,0,1]) {
                    translate([0,(-dia/2),-e]){
                        cube([dia,dia,ht+4*e]);
                    }
                }
            }
        }
    }
}


module e_mount_base() { // draws about 25mm above the xy plane.  oh well.
    union() {
            color("blue") hollow_ring(pos=27.4,dia=43.4,wid=4,ht=5);
            color("red") {
                d=46.5; // outside diameter of the flange ear
                p=31.2; // z-axis position of the flange ear
                w=7.1; // width of the flange ear in the x-y plane
                h=1.255; // z-height of the flange ear
                mount_lug(pos=p,dia=d,wid=w,ht=h,ang=44,rot=0);
                mount_lug(pos=p,dia=d,wid=w,ht=h,ang=52,rot=142);
                mount_lug(pos=p,dia=d,wid=w,ht=h,ang=52,rot=(-101.5));
            }
            color("green") hollow_ring(pos=23.56,dia=46.495,wid=7.1,ht=5);
            difference() {
                color("aqua") hollow_ring(pos=22.46,dia=61.5,wid=22.11,ht=5);
            //color("salmon") {   
                translate([24,-13,27]) sphere(1.9,$fn=100);
                translate([23.5,-12.75,27]) sphere(1.9,$fn=100);
            }
            color("pink") hollow_ring(pos=23.5,dia=61.5,wid=1.9,ht=5);
            
            color("lime") hollow_cone(pos=17.5,top=51,bot=61.5,wid=6,ht=5);
        }
}


module inside_threaded_ring(pos=0,ht=5,dia=51,thread=42,pitch=1,rot=0) {  // pos, ht, dia, thread, pitch, rot
        e=0.5;
            rotate(a=rot, v=[0,0,1])
            translate(v=[0,0,pos])
            difference() {
                cylinder(h=ht,d=dia);
                translate(v=[0,0,-e])
                    metric_thread(thread,pitch,ht+2*e,internal=true);
                cylinder(h=(ht+2*e),d=(thread*0.5));
            }
}

module textured_ring_one_dim(pos=0,dia=10,wid=1,ht=5,grid=2) { // pos, dia, wid, ht
    e=0.5;
    translate(v=[0,0,pos])
    difference() {
        metric_thread(dia,grid,ht,n_starts=dia*3/grid);
        translate([0,0,-e]) {
                    cylinder(h=(ht+2*e),d=(dia-wid));
        }
    }   
}

module textured_ring(pos=0,dia=10,wid=1,ht=5,grid=2) { // pos, dia, wid, ht
    textured_ring_one_dim(pos=pos,dia=dia,wid=wid,ht=ht,grid=grid);
    mirror([1,0,0]) 
        textured_ring_one_dim(pos=pos,dia=dia,wid=wid,ht=ht,grid=grid);
}

module whole_thing() {
    union() {
            e_mount_base();
        
            // body of the mount 
            // - height determined by flange distance
            // see http://www.graphics.cornell.edu/~westin/misc/mounts-by-register.html
            color("tan") hollow_ring(pos=0,dia=51,wid=8.9,ht=25);
            // this is just an artistic pattern for grippy surface
            // you want to draw the textured ring on top of the body cylinder
            // it's a grid kind of like a knurled surface
            color("darkblue") 
            textured_ring(pos=0,dia=51.1,wid=8,ht=25,grid=5);
        
            // the cone is an alternative to the textured body
            // color("purple") hollow_cone(pos=0,bot=61.5,top=51,wid=8.8,ht=23);
                    
            // reference design
            // color("yellow") m42_nex();
    
            color("orange") 
            aperture_pin_flange(pos=6.85, dia=44, wid=11, ht=10);
        
            // M42x1 threads
            color("orangered") 
            inside_threaded_ring(pos=1.25,ht=5,dia=51,thread=42,pitch=1,rot=180);
    }
}

whole_thing();