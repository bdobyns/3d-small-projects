// Barry A Dobyns, bdobyns@gmail.com, March 25 2015
// v0 - first printing attempt
// v1 - grippy cutouts, vanity lettering
// v2 - fine-tuned so that it can F6 render and produce an STL
// v3 - airgap between threads and aperture flange so the support doesn't touch

// include <M42_Sony_NEX_E-Mount-Lens_Adaptor_fixed.scad>
include <threads.scad>  // from http://dkprojects.net/openscad-threads/

// - height determined by flange distance
// see http://www.graphics.cornell.edu/~westin/misc/mounts-by-register.html

// helpful see also
// http://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#color
// http://www.openscad.org/cheatsheet/
// http://edutechwiki.unige.ch/en/OpenScad_beginners_tutorial

global_fn=100;

module chamfered_ring(pos=0, od=10, id=5, ht=5, flip=false) { // triangle cross section
        e=0.5;
        if (flip) flip_chamfered_ring(pos=pos,od=od,id=id, ht=ht);
        else translate(v = [0,0,pos]) 
            difference() {
            // the plate
            cylinder(h=ht, d=od);
            
            // the hole tapers to a sharp edge
            translate([0,0,-e]) { 
                cylinder(h=(ht+2*e), d2=(od+2*e), d1=id, $fn=global_fn); 
            }
        }
}

module flip_chamfered_ring(pos=0,od=10,id=5,ht=5) {
    translate(v=[0,0,pos+ht]) // offset by the height since we flipped it over
    rotate(a=180,v=[1,0,0])
    chamfered_ring(pos=0,od=od,id=id,ht=ht,flip=false);
}

module hollow_ring(pos=0, od=10, id=5, ht=5) { 
    union() {
        translate(v = [0,0,pos]) {
            difference() {
                $fn=global_fn;
                cylinder(h=ht,d=od);
                translate([0,0,-0.5]) {
                    cylinder(h=(ht+1),d=id);
                }
            }
        }
    }
}

module hollow_cone(pos=0, top=51, bot=61, wid=2, ht=5) {  
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


module e_mount_base(pos=23.5, clr=false) { 
    e=6;  // small epsilon
    id=39.4; // inside diameter for the rings
    union() {
        // cylinder inside mount hole
        color("red") 
	    hollow_ring(pos=(3.9+pos),od=43.4,id=id,ht=5);
        // three mounting lugs
        color("orange") 
	    union() {
                d=46.5; // outside diameter of the flange ear
                p=(7.7+pos); // z-axis position of the flange ear
                w=d-id; // width of the flange ear in the x-y plane
                h=1.255; // z-height of the flange ear
                mount_lug(pos=p,dia=d,wid=w,ht=h,ang=44,rot=0);
                mount_lug(pos=p,dia=d,wid=w,ht=h,ang=52,rot=142);
                mount_lug(pos=p,dia=d,wid=w,ht=h,ang=52,rot=(-101.5));
        }
        
        // main base plate
        color("green") 
        difference() {
            hollow_ring(pos=(-1.04+pos),od=61.5,id=id,ht=5);
            // latch cutout
            hull() {
                translate([24,-13,(3.5+pos)]) sphere(1.7,$fn=global_fn/e);
                translate([23.5,-12.75,(3.5+pos)]) sphere(1.7,$fn=global_fn/e);
            }
        }
        // inner rim on base plate
        color("olive") 
	    hollow_ring(pos=(0.06+pos),od=46.495,id=id,ht=5);
        // outer rim on base plate
        color("blue") 
	    hollow_ring(pos=(0+pos),od=61.5,id=(61.5-1.9),ht=5);
        
        // index mark
        rotate(a=175, v=[0,0,1])
        translate(v=[26,0,(-1.5+pos)])
        cube(size=[5.25,2,5.46]);
        
        // index mark support
        rotate(a=-83, v=[0,0,1])
        difference() {
            hollow_cone(pos=17.5,top=51,bot=62,wid=5,ht=4.5);
            translate(v=[30.6,0,0]) cube([70,70,70], center=true);
            rotate(a=160.5,v=[0,0,1]) translate(v=[31,0,0]) cube([70,70,70], center=true);
            // translate(v=[0,-31,0]) cube([70,70,70], center=true);            

        }
            
    }
}


module inside_threaded_ring(pos=0, ht=5, dia=51, thread=42, pitch=1, rot=0) {   
        e=1.0;
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
    e=5;
    rotate(a=rot,v=[0,0,1])
    translate(v=[dia/2,0,pos])
    hull() {
        translate(v=[0,0,wid/2]) sphere(r=wid/2,$fn=global_fn/e);
        translate(v=[0,0,ht])    sphere(r=wid/2,$fn=global_fn/e);
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
    rotate(a=rot+150, v=[0,0,1]) // this moves it to the right angular position
    translate(v=[0,-dia/2,pos]) // move to right radial/vertical position
    rotate(a=90, v=[1,0,0]) // move text to vertical in xz plane
    translate(v=[0,0,-1.5]) // correct for height of text
    linear_extrude(height=ht)
    text(ch, font = ft, size = 3.75);
}

module vanity_text(pos=31,dia=62, ht=1, name=true) {
    // really want substr()
    p = pos;
    d = dia;
    a = 7; // nominal width of a letter position

    one_letter(ht=ht,pos=p,dia=d,ch="M",rot=a*0);  
    one_letter(ht=ht,pos=p,dia=d,ch="4",rot=a*1+1.5);  // manual kerning
    one_letter(ht=ht,pos=p,dia=d,ch="2",rot=a*2);   
    one_letter(ht=ht,pos=p,dia=d,ch="-",rot=a*3);
    one_letter(ht=ht,pos=p,dia=d,ch="-",rot=a*3+2);   // an em-dash
    one_letter(ht=ht,pos=p,dia=d,ch="N",rot=a*4);   
    one_letter(ht=ht,pos=p,dia=d,ch="E",rot=a*5);   
    one_letter(ht=ht,pos=p,dia=d,ch="X",rot=a*6);   

    if (name) {
        e=125;
 //     one_letter(ht=ht,pos=p,dia=d,ch=" ",rot=e+a*1);   
        one_letter(ht=ht,pos=p,dia=d,ch="b",rot=e+a*0);   
        one_letter(ht=ht,pos=p,dia=d,ch="y",rot=e+a*1-1);   
 //     one_letter(ht=ht,pos=p,dia=d,ch=" ",rot=e+a*2);   
        one_letter(ht=ht,pos=p,dia=d,ch="B",rot=e+a*3);   
        one_letter(ht=ht,pos=p,dia=d,ch="a",rot=e+a*4);   
        one_letter(ht=ht,pos=p,dia=d,ch="r",rot=e+a*5-1);   // kerning
        one_letter(ht=ht,pos=p,dia=d,ch="r",rot=e+a*6-4);   
        one_letter(ht=ht,pos=p,dia=d,ch="y",rot=e+a*6);   
 //     one_letter(ht=ht,pos=p,dia=d,ch=" ",rot=e+a*7);   
        one_letter(ht=ht,pos=p,dia=d,ch="A",rot=e+a*8-5);   
        one_letter(ht=ht,pos=p,dia=d,ch=".",rot=e+a*8+2);   
        one_letter(ht=ht,pos=p,dia=d,ch="D",rot=e+a*9);   
        one_letter(ht=ht,pos=p,dia=d,ch="o",rot=e+a*10+1);   
        one_letter(ht=ht,pos=p,dia=d,ch="b",rot=e+a*11);   
        one_letter(ht=ht,pos=p,dia=d,ch="y",rot=e+a*12-1);   
        one_letter(ht=ht,pos=p,dia=d,ch="n",rot=e+a*13-3);   
        one_letter(ht=ht,pos=p,dia=d,ch="s",rot=e+a*14-4);
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
            color("tan") 
            hollow_ring(pos=0,od=51,id=(51-8.25),ht=25);
            // a 'reducer' cone so we don't have to print support
            color("beige") 
            hollow_cone(pos=17.5,top=51,bot=60,wid=5,ht=5);
            
            // the aperture flange
            color("orange")    
            difference() {
                chamfered_ring(pos=6.0, od=44, id=(44-7.25), ht=10);
                // a cut-out to protect the threads
                // from printing support for the flange
                chamfered_ring(pos=6.0, od=44.1, id=(44.1-5), ht=4);
            }
            
            // angled join between mount and body - prints better than a ledge
            color("aqua")
            chamfered_ring(pos=17.4, od=44.25, id=(44.25-5), ht=5, flip=true);
            
            // M42x1 threads
            color("orangered") 
            inside_threaded_ring(pos=1.25,ht=4.25,dia=50,thread=42.25,pitch=1,rot=180);
        }
        // subtract out the grip bits at the end from everything else
        // so it gets subtraced from both the body and the thread-ring
        grip_cutouts(pos=2,dia=51,wid=4,ht=14.25,cnt=20);
    } 
}

whole_thing();
