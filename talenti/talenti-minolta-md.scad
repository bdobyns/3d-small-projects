// talenti icecream lid with rear-lens-cap insert

include <jar_lid.scad> // library for making a lid that fits talenti ice cream jars

// general params for the official talenti lid.
jar_height=20;
jar_diameter=90;
jar_thread_pitch=4.9;
jar_wallthickness=3;
jar_rim_grip_arc=230;
jar_rim_text_rot=28.5;

L1="Minolta MD-Mount";   // outside rim, inside flat surface, outside flat surface
L2=""; // "Nikkor 55mm f1.2"; // outside flat surface line 2
L3=""; // "Property of:";     // outside flat surface line 3
L4=""; // "Barry A Dobyns";   // outside flat surface line 4
L5=""; // "408-981-4746";     // outside flat surface line 5

union() {
    jar_lid(height=jar_height, diameter=jar_diameter, 
        threadpitch=jar_thread_pitch, wallthickness=jar_wallthickness,
        label1=L1, label2=L2, label3=L3, label4=L4, label5=L5,
        rim_grip_arc=jar_rim_grip_arc, rim_text_rot=jar_rim_text_rot);
    
    // this gets the mount in from someone else's designed file
    // https://www.thingiverse.com/thing:214231
    // fixed in netfabb
    // https://service.netfabb.com/service.php
    translate([0,0,15]) rotate([180,0,0]) color("blue") 
        import("mounts/Minolta_SRRearCap20131228_fixed.stl");
    
    // whack off the knurling on the inner mount, and the taper at the bottom
    color("red") hollow_ring(pos=1,od=52,id=47,ht=14);
 }

