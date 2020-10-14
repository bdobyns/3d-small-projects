// broth lid with rear-lens-cap insert

include <jar_lid.scad> // library for making a lid for plastic jars
include <broth_params.scad> // talenti ice cream jar

L1="Leica M39";   // outside rim, inside flat surface, outside flat surface
// L2="Jar Type";  // outside flat surface line 2
L3=""; // "Property of:";     // outside flat surface line 3
L4=" ";   // outside flat surface line 4
L5=" ";     // outside flat surface line 5

union() {
    jar_lid(height=lid_height, diameter=lid_inner_diameter, 
        threadpitch=lid_thread_pitch, wallthickness=lid_wallthickness,
        label1=L1, label2=L2, label3=L3, label4=L4, label5=L5,
        rim_grip_arc=lid_rim_grip_arc, rim_text_rot=lid_rim_text_rot);


    // this gets the mount in from someone else's designed file
    // http://www.thingiverse.com/thing:753741
    translate([0,0,2.4]) color("blue") 
         import("mounts/M39_rear_lens_cap_fixed.stl");
    
    // this makes sure the mount is attached to the lid
    color("red") hollow_ring(pos=1,od=45.5,id=41,ht=14,$fn=60);
}

