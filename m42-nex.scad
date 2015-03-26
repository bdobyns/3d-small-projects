// Barry A Dobyns, bdobyns@gmail.com, March 25 2015
// v0 - first printing attempt
// v1 - grippy cutouts, vanity lettering
// v2 - fine-tuned so that it can F6 render and produce an STL

// include <M42_Sony_NEX_E-Mount-Lens_Adaptor_fixed.scad>
include <threads.scad>  // from http://dkprojects.net/openscad-threads/

// - height determined by flange distance
// see http://www.graphics.cornell.edu/~westin/misc/mounts-by-register.html

// helpful see also
// http://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#color
// http://www.openscad.org/cheatsheet/
// http://edutechwiki.unige.ch/en/OpenScad_beginners_tutorial

global_fn=100;

module aperture_pin_flange(pos=0, dia=10, wid=5, ht=5) { 
        e=0.5;
        translate(v = [0,0,pos])
        difference() {
            // the plate
            cylinder(h=ht, d=dia);
            
            // the hole
            translate([0,0,-e]) { 
                cylinder(h=(ht+2*e), d2=(dia+2*e), d1=(dia-wid), $fn=global_fn); 
            }
        }
}

module hollow_ring(pos=0, dia=10, wid=5, ht=5) { 
    // color("blue")
    union() {
        translate(v = [0,0,pos]) {
            difference() {
                $fn=global_fn;
                cylinder(h=ht,d=dia);
                translate([0,0,-0.5]) {
                    cylinder(h=(ht+1),d=(dia-wid));
                }
            }
        }
    }
}

module hollow_cone(pos=0, top=51, bot=61, wid=2, ht=5) {  
    // color("blue")
    union() {
        translate(v = [0,0,pos]) {
            difference() {
                $fn=global_fn;
                cylinder(h=ht,d1=top,d2=bot);
                translate([0,0,-0.5]) {
                    cylinder(h=(ht+1),d=(top-wid));
                }
            }
        }
    }
}



module mount_lug(pos=0, dia=46, wid=7, ht=2, ang=52, rot=0) { 
    rotate(a=rot, v=[0,0,1])
    union() {
        e=0.02;
        translate(v = [0,0,pos]) {
            difference() {
                $fn=global_fn;
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


module e_mount_base(pos=23.5) { 
    e=6;
    union() {
        // color("red") 
	    hollow_ring(pos=27.4,dia=43.4,wid=4,ht=5);
        // color("orange") 
	    union() {
                d=46.5; // outside diameter of the flange ear
                p=(7.7+pos); // z-axis position of the flange ear
                w=7.1; // width of the flange ear in the x-y plane
                h=1.255; // z-height of the flange ear
                mount_lug(pos=p,dia=d,wid=w,ht=h,ang=44,rot=0);
                mount_lug(pos=p,dia=d,wid=w,ht=h,ang=52,rot=142);
                mount_lug(pos=p,dia=d,wid=w,ht=h,ang=52,rot=(-101.5));
        }
        // color("yellow") 
	    hollow_ring(pos=(0.06+pos),dia=46.495,wid=7.1,ht=5);
        difference() {
            // color("green") 
            hollow_ring(pos=(-1.04+pos),dia=61.5,wid=22.11,ht=5);
            hull() {
                translate([(0.5+pos),-13,27]) sphere(1.9,$fn=global_fn/e);
                translate([(0+pos),-12.75,27]) sphere(1.9,$fn=global_fn/e);
            }
        }
        // color("blue") 
	    hollow_ring(pos=(0+pos),dia=61.5,wid=1.9,ht=5);
    }
}


module inside_threaded_ring(pos=0, ht=5, dia=51, thread=42, pitch=1, rot=0) {   
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

module textured_ring_one_dim(pos=0, dia=10, wid=1, ht=5, grid=2) { 
    e=0.5;
    translate(v=[0,0,pos])
    difference() {
        metric_thread(dia,grid,ht,n_starts=dia*3/grid);
        translate([0,0,-e]) {
                    cylinder(h=(ht+2*e),d=(dia-wid));
        }
    }   
}

module textured_ring(pos=0, dia=10, wid=1, ht=5, grid=2) { 
    textured_ring_one_dim(pos=pos,dia=dia,wid=wid,ht=ht,grid=grid);
    mirror([1,0,0]) 
        textured_ring_one_dim(pos=pos,dia=dia,wid=wid,ht=ht,grid=grid);
}

module one_grip_cutout(pos=0, dia=10, wid=1, ht=5, rot=0) {
    e=3;
    rotate(a=rot,v=[0,0,1])
    translate(v=[dia/2,0,pos+(wid/2)])
    minkowski() {
        sphere(r=wid/2,$fn=global_fn/e);
        cylinder(r=wid/2,h=ht-wid,$fn=global_fn/e);
    }
}

module grip_cutouts(pos=3, dia=51, wid=3, ht=15, cnt=10) {
     step = 360/cnt;
    for (rot = [0 : step : 360] ) {
        one_grip_cutout(pos=pos, dia=dia, wid=wid, ht=ht, rot=rot);
     }
}


module one_letter(ht=1,pos=31,dia=62,ch="X",rot=0) {
    ft = "Liberation Sans";
    rotate(a=rot+180, v=[0,0,1]) // this moves it to the right angular position
    translate(v=[0,-dia/2,pos]) // move to right radial/vertical position
    rotate(a=90, v=[1,0,0]) // move text to vertical in xz plane
    translate(v=[0,0,-1.5]) // correct for height of text
    linear_extrude(height=ht)
    text(ch, font = ft, size = 3.75);
}

module vanity_text(pos=31,dia=62, ht=1, name=false) {
    // really want substr()
    p = pos;
    d = dia;
    a = 7;

    one_letter(ht=ht,pos=p,dia=d,ch="M",rot=a*0);  
    one_letter(ht=ht,pos=p,dia=d,ch="4",rot=a*1+1.5);  // manual kerning
    one_letter(ht=ht,pos=p,dia=d,ch="2",rot=a*2);   
    one_letter(ht=ht,pos=p,dia=d,ch="-",rot=a*3);
    one_letter(ht=ht,pos=p,dia=d,ch="-",rot=a*3+2);   // an em-dash
    one_letter(ht=ht,pos=p,dia=d,ch="N",rot=a*4);   
    one_letter(ht=ht,pos=p,dia=d,ch="E",rot=a*5);   
    one_letter(ht=ht,pos=p,dia=d,ch="X",rot=a*6);   
 // one_letter(ht=ht,pos=p,dia=d,ch="-",rot=a*7);     
 // one_letter(ht=ht,pos=p,dia=d,ch="E",rot=a*8-3);   // more kerning
    if (name) {
 // one_letter(ht=ht,pos=p,dia=d,ch=" ",rot=a*9);   
    one_letter(ht=ht,pos=p,dia=d,ch="b",rot=a*10);   
    one_letter(ht=ht,pos=p,dia=d,ch="y",rot=a*11-1);   
 // one_letter(ht=ht,pos=p,dia=d,ch=" ",rot=a*12);   
    one_letter(ht=ht,pos=p,dia=d,ch="B",rot=a*13);   
    one_letter(ht=ht,pos=p,dia=d,ch="a",rot=a*14);   
    one_letter(ht=ht,pos=p,dia=d,ch="r",rot=a*15-1);   // kerning
    one_letter(ht=ht,pos=p,dia=d,ch="r",rot=a*16-4);   
    one_letter(ht=ht,pos=p,dia=d,ch="y",rot=a*16);   
 // one_letter(ht=ht,pos=p,dia=d,ch=" ",rot=a*17);   
    one_letter(ht=ht,pos=p,dia=d,ch="A",rot=a*18-5);   
    one_letter(ht=ht,pos=p,dia=d,ch=".",rot=a*18+2);   
    one_letter(ht=ht,pos=p,dia=d,ch="D",rot=a*19);   
    one_letter(ht=ht,pos=p,dia=d,ch="o",rot=a*20+1);   
    one_letter(ht=ht,pos=p,dia=d,ch="b",rot=a*21);   
    one_letter(ht=ht,pos=p,dia=d,ch="y",rot=a*22-1);   
    one_letter(ht=ht,pos=p,dia=d,ch="n",rot=a*23-3);   
    one_letter(ht=ht,pos=p,dia=d,ch="s",rot=a*24-4);
    }   
}   

module whole_thing() {
    difference() {
        union() {
            // The Sony NEX/E-Mount Base
            difference() {
                e_mount_base(pos=23.5);
                // and some vanity text
                vanity_text(pos=23.5,dia=64, ht=0.3);
            }
                
            // body of the mount 
            // color("tan") 
            hollow_ring(pos=0,dia=51,wid=8.9,ht=25);
            // a 'reducer' cone so we don't have to print support
            // color("beige") 
            hollow_cone(pos=17.5,top=51,bot=61.5,wid=6,ht=5);
            
            // reference design
            // color("yellow") m42_nex();
        
            // color("orange") 
            aperture_pin_flange(pos=6.85, dia=44, wid=11, ht=10);
            
            // M42x1 threads
            // color("orangered") 
            inside_threaded_ring(pos=1.25,ht=5,dia=51,thread=42,pitch=1,rot=180);
        }
        // subtract out the grip bits at the end from everything else
        // so it gets subtraced from both the body and the thread-ring
        grip_cutouts(pos=2,dia=55,wid=3.5,ht=15,cnt=15);
    }
}

whole_thing();
