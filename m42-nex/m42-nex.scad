// Barry A Dobyns, bdobyns@gmail.com, March 25 2015
// v0 - first printing attempt
//      threads from http://dkprojects.net/openscad-threads/
// v1 - grippy cutouts, vanity lettering
// v2 - fine-tuned so that it can F6 render and produce an STL
// v3 - airgap between threads and aperture flange so the support doesn't touch
// v4 - refactored in terms of ID and OD, fixed up some bugs in index-mark (printed)
// v5 - refactored to print one mount "end", or to print in half-sections
// v6 - refactored text to use Write.scad from Harlan Martin http://www.thingiverse.com/thing:16193/
// v7 - refactored to use text_on from Brody Kenrick https://github.com/brodykenrick/text_on_OpenSCAD
// v8 - bigbody alternative, as suggested by will

include <threads.scad>  // from http://dkprojects.net/openscad-threads/
include <text_on.scad>  // from https://github.com/brodykenrick/text_on_OpenSCAD

// - height determined by flange distance
// see http://www.graphics.cornell.edu/~westin/misc/mounts-by-register.html

// helpful see also
// http://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#color
// http://www.openscad.org/cheatsheet/
// http://edutechwiki.unige.ch/en/OpenScad_beginners_tutorial

//////////////////////////////////////////////////////////////////////
//////////////////////////////Parameters//////////////////////////////
//////////////////////////////////////////////////////////////////////

global_fn=100;
mount_dia=61.5;  // nominal 61.5 is correct
body_dia=61.5;   // 61.5 is the dia of the mount, 51.0 is the nominal minimimum dia

//////////////////////////////////////////////////////////////////////
//////////////////////////////Renders/////////////////////////////////
//////////////////////////////////////////////////////////////////////

//whole_thing(cutaway=false, body_dia=body_dia);

//translate(v=[ 40, 40,0]) complete_nex_mount(cutaway=false,pos=0,index=false);
translate(v=[-40,-40,0]) just_m42_threads(cutaway=false);

//translate(v=[0,-10,0]) just_right_half();
//translate(v=[0, 10,0]) just_left_half();

//////////////////////////////////////////////////////////////////////
//////////////////////////////Modules/////////////////////////////////
//////////////////////////////////////////////////////////////////////

module chamfered_ring(pos=0, od=10, id=5, ht=5, flip=false) { // triangle cross section
        e=0.2;
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

module hollow_cone(pos=0, od_top=51, od_bot=61, wid=2, ht=5, id_top=0, id_bot=0) { 
   // either use the wid=n argument OR
   // use id_top and id_bot 
    union() {
        translate(v = [0,0,pos]) {
            difference() {
                $fn=global_fn;
                cylinder(h=ht,d1=od_top,d2=od_bot);
                translate([0,0,-0.5]) {
                    if (id_top > 1 && id_bot > 0)
                        cylinder(h=(ht+1), d1=id_top, d2=id_bot);
                    else cylinder(h=(ht+1),d1=(od_top-wid), d2=(od_bot-wid));
                }
            }
        }
    }
}



module mount_lug(pos=0, od=46, id=39.4, ht=2, ang=52, rot=0) { 
    rotate(a=rot, v=[0,0,1])
    union() {
        e=0.02;
        translate(v = [0,0,pos]) {
            difference() {
                $fn=global_fn;
                // make a disc
                cylinder(h=ht,d=od);
                // cutout in the disc makes a ring
                translate([0,0,-2*e]) {
                    cylinder(h=(ht+4*e),d=id);
                }
                // clip off half of the ring
                translate([0,(-od/2),-e]){
                    cube([od,od,ht+4*e]);
                }
                // clip off all but the angle from the other side
                rotate(a=(180-ang), v=[0,0,1]) {
                    translate([0,(-od/2),-e]){
                        cube([od,od,ht+4*e]);
                    }
                }
            }
        }
    }
}


module e_mount_base(pos=23.5, index=true) { 
    e=6;  // small epsilon for low-res circles
    id=39.4; // inside diameter for the rings
    union() {
        // cylinder inside mount hole
        color("red") 
	    hollow_ring(pos=(4.94+pos),od=43.4,id=id,ht=5);
        // three mounting lugs
        color("orange") 
	    union() {
                d=46.5; // outside diameter of the flange ear
                p=(8.74+pos); // z-axis position of the flange ear
                h=1.255; // z-thickness of the flange ear
                mount_lug(pos=p,od=d,id=id,ht=h,ang=44,rot=0);
                mount_lug(pos=p,od=d,id=id,ht=h,ang=52,rot=142);
                mount_lug(pos=p,od=d,id=id,ht=h,ang=52,rot=(-101.5));
        }
        
        // main base plate
        color("green") 
        difference() {
            hollow_ring(pos=pos,od=mount_dia,id=id,ht=5);
            // latch cutout
            hull() {
                translate([24,-13,(4.54+pos)]) sphere(1.5,$fn=global_fn/e);
                translate([22.25,-12,(4.54+pos)]) sphere(1.5,$fn=global_fn/e);
            }
        }
        // inner rim on base plate
        color("olive") 
	    hollow_ring(pos=(1.1+pos),od=46.495,id=id,ht=5);
        // outer rim on base plate
        color("blue") 
	    hollow_ring(pos=(1.09+pos),od=mount_dia,id=59.6,ht=5);
        
        if (index) {
            // index mark that stands up above base plate
            rotate(a=175, v=[0,0,1])
            translate(v=[26,0,(-0.46+pos)])
            cube(size=[5.75,2,5.46]);
        
            // index mark print support (no removable support needed)
            rotate(a=-83, v=[0,0,1])
            difference() {
                hollow_cone(pos=(-4.96+pos), od_top=51, od_bot=62.5, wid=10, ht=4.5);
                translate(v=[30.6,0,0]) cube([70,70,70], center=true);
                rotate(a=160.5,v=[0,0,1]) translate(v=[31,0,0]) cube([70,70,70], center=true);
            }
        } else {
            // index mark that's flush with the main base plate
            rotate(a=175, v=[0,0,1])
            translate(v=[26,0,pos])
            cube(size=[5.25,2,5]);
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

module complete_nex_mount(cutaway=false,pos=22.46, txt="SONY NEX",index=false) {
     // The Sony NEX/E-Mount Base
     difference() {
        e_mount_base(pos=pos, index=index);
        // and some vanity text
         r=30.75;
         h=6;
         me="by  Barry A. Dobyns";
        text_on_cylinder(t=txt,locn_vec=[0,0,pos+0.5],r=r,h=h,eastwest=176);
        text_on_cylinder(t=me ,locn_vec=[0,0,pos+0.5],r=r,h=h,eastwest=-25);
        // vanity_text(pos=1,dia=64, ht=0.3);
        
        // cutaway view
        if (cutaway) translate(v=[-10,-10,-10]) cube(75,50,50);
     } 
}

module whole_thing(mount=true, cutaway=false) {
        difference() {
        union() {
            if(mount) {
                // The Sony NEX/E-Mount Base
                complete_nex_mount(pos=22.46,txt="M42-NEX",index=true);

                // angled join between mount and body - prints better than a ledge
                color("aqua")
                chamfered_ring(pos=17.5, od=44.25, id=39.4, ht=5, flip=true);
            }
            
            // body of the mount 
            color("tan") 
            hollow_ring(pos=0,od=body_dia,id=(42.75),ht=22.46);
            // a 'reducer' cone so we don't have to print support            
            if(body_dia < mount_dia) {
                color("beige") 
                hollow_cone(pos=17.5,od_top=body_dia,od_bot=mount_dia,id_top=43,id_bot=43,ht=5);
            }
            // maybe run the index mark all the way to the top, if wide-body
            if (body_dia==mount_dia) {
                rotate(a=175, v=[0,0,1])
                translate(v=[body_dia/2,0,0])
                // rotate(a=45,v=[0,0,1])
                cube(size=[1,2,22.46]);
            }
            
            // the aperture flange
            color("orange")    
            difference() {
                chamfered_ring(pos=6.0, od=44, id=36.4, ht=10);
                // a cut-out to protect the threads
                // from printing support for the flange
                chamfered_ring(pos=5.98, od=44.1, id=39.4, ht=4);
            }
            
            if(false) {
            // faux-support - protect the threads
            hollow_ring(pos=0, od=39.4, id=38.4, ht=5.75);
            hollow_ring(pos=0, od=39.4, id=39.38, ht=6);
            }
            
            // M42x1 threads
            color("orangered") 
            inside_threaded_ring(pos=1.25,ht=4.25,dia=50,thread=42.25,pitch=1,rot=180);
        }
        // subtract out the grip bits at the end from everything else
        // so it gets subtraced from both the body and the thread-ring
        grip_cutouts(pos=2,dia=body_dia,wid=4,ht=14.25,cnt=19);
        
        // cutaway view
        if (cutaway) translate(v=[-10,-10,-10]) cube(75,50,50);
    } 
}

module just_m42_threads(cutaway=false, pos=pos) {
    difference(){
        whole_thing(mount=false,cutaway=cutaway);
        translate(v=[0,0,11]) cylinder(h=100,d=100);
    };
}

module just_right_half() {
    difference() {
        siz=75;
        rotate(a=90,v=[1,0,0]) whole_thing();
        translate(v=[0,0,-siz/2]) cube(siz,siz,siz, center=true);
    }
}

module just_left_half() {
    difference() {
        siz=75;
        rotate(a=-90,v=[1,0,0]) whole_thing();
        translate(v=[0,0,-siz/2]) cube(siz,siz,siz, center=true);
    }
}

