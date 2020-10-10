// Barry A Dobyns 
// bdobyns@gmail.com
// 408-981-474
// 2020-10-09

include <threads.scad>  // from http://dkprojects.net/openscad-threads/
include <text_on.scad>  // from https://github.com/brodykenrick/text_on_OpenSCAD

global_fn=90;

// originally designed to replace the talenti icecream lid
// but with suitable dimensions, should work on peanut butter jars, etc

// talenti measured height=13, diameter=90, threadpitch=4.9, wallthickness=1.8

module jar_lid(height=20, diameter=90, threadpitch=4.9, wallthickness=3,
    label1="", label2="", label3="", label4="", label5="",
    rim_grip_arc=230, rim_text_rot=30  ) 
    {
        
    outer=diameter+(wallthickness*2);
        
    // do the outer wall
    difference(){
        union() {
            // do the flat bottom plate
            cylinder(d=outer-1, h=wallthickness,$fa=2);
            // do the threads with the wall
            inside_threaded_ring(pos=0,ht=height,dia=outer,thread=diameter, 
                pitch=threadpitch, rot=0);    
        }
        
        // this is the text on the rim
        rotate(rim_text_rot) text_on_cylinder(t=label1,r=((diameter/2)+wallthickness), 
            h=height*1.1, size=14*5/9);
        
        // grippy bits on the rim outside
        grip_cutouts(pos=wallthickness/3, dia=outer+1.5, wid=3, 
                ht=height-wallthickness, cnt=100, arc=rim_grip_arc);
        
        // text on the inside
        /* text_on_cube(cube_size=[diameter,diameter,1.5], t=label,
            locn_vec=[0,0,3], face=top); */
        text_on_circle(r=diameter/2,middle=8.5, size=8,t=label1,
            locn_vec=[0,0,wallthickness]);
 
         // text on the outside
        color("pink") {
        text_on_cube(cube_size=[diameter,diameter,wallthickness], t=label1,
            locn_vec=[0,-15,wallthickness/2], rotate=[0,0,0], face="bottom");
        text_on_cube(cube_size=[diameter,diameter,wallthickness], t=label2,
            locn_vec=[0,-10,wallthickness/2], rotate=[0,0,0], face="bottom");
        text_on_cube(cube_size=[diameter,diameter,wallthickness], t=label3,
            locn_vec=[0,5,wallthickness/2], rotate=[0,0,0], face="bottom");
        text_on_cube(cube_size=[diameter,diameter,wallthickness], t=label4,
            locn_vec=[0,10,wallthickness/2], rotate=[0,0,0], face="bottom");    
        text_on_cube(cube_size=[diameter,diameter,wallthickness], t=label5,
            locn_vec=[0,15,wallthickness/2], rotate=[0,0,0], face="bottom");
        }
    }
}


// below were developed earlier for my M42 to Sony-E scratch design adapter

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

module inside_threaded_ring(pos=0, ht=5, dia=51, thread=42, pitch=1, rot=0) {   
        e=1.0;
            rotate(a=rot, v=[0,0,1])
            translate(v=[0,0,pos])
            difference() {
                cylinder(h=ht,d=dia,$fn=global_fn);
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

module grip_cutouts(pos=3, dia=51, wid=3, ht=15, cnt=10, arc=360) {
     step = 360/cnt;
    for (rot = [0 : step : arc] ) {
        one_grip_cutout(pos=pos, dia=dia, wid=wid, ht=ht, rot=rot);
     }
}  

