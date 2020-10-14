// talenti icecream lid with rear-lens-cap insert

include <jar_lid.scad> // library for making a lid for plastic jars
include <params-broth.scad> // talenti ice cream jar

L1="Sony E";   // outside rim, inside flat surface, outside flat surface
// L2="Jar Type";  // outside flat surface line 2
L3=""; // "Property of:";     // outside flat surface line 3
L4=""; //"Barry A Dobyns";   // outside flat surface line 4
L5=""; //"408-981-4746";     // outside flat surface line 5

lid_height=25;

union() {
    jar_lid(height=lid_height, diameter=lid_inner_diameter, 
        threadpitch=lid_thread_pitch, wallthickness=lid_wallthickness,
        label1=L1, label2=L2, label3=L3, label4=L4, label5=L5,
        rim_grip_arc=lid_rim_grip_arc, rim_text_rot=lid_rim_text_rot);


    // this gets the mount in from someone else's designed file
    // http://www.thingiverse.com/thing:753741
    translate([0,25,1.9]) color("blue") 
         import("mounts/Sony_E-mount_rear_lens_cap_v2.stl");
    
    // just cover the whole base with this riser
    // since the lid top can't actually reach this deep.
    color("red") hollow_ring(pos=3,od=66,id=55,ht=7,$fn=60);

    // this is the index mark
/*  rotate([0,0,0]) color("green") translate([0,-34,3]) 
        sphere(r=3,$fn=60);
*/
}

