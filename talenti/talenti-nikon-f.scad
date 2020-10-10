// talenti icecream lid with rear-lens-cap insert

include <jar_lid.scad> // library for making a lid that fits talenti ice cream jars

// general params for the official talenti lid.
lid_height=20;
lid_inner_diameter=90.5;
lid_thread_pitch=4.9;
lid_wallthickness=3;
lid_rim_grip_arc=250;
lid_rim_text_rot=35;

L1="Nikon F-Mount";   // outside rim, inside flat surface, outside flat surface
L2=""; // "Nikkor 55mm f1.2"; // outside flat surface line 2
L3=""; // "Property of:";     // outside flat surface line 3
L4="Barry A Dobyns";   // outside flat surface line 4
L5="408-981-4746";     // outside flat surface line 5

union() {
    jar_lid(height=lid_height, diameter=lid_inner_diameter, 
        threadpitch=lid_thread_pitch, wallthickness=lid_wallthickness,
        label1=L1, label2=L2, label3=L3, label4=L4, label5=L5,
        rim_grip_arc=lid_rim_grip_arc, rim_text_rot=lid_rim_text_rot);

    // this gets the mount in from someone else's designed file
    // https://www.thingiverse.com/thing:114331
    translate([0,0,2.4]) color("blue") 
        import("mounts/nikon-fmount-plain.stl");
    
    // this ring does away with the absurd texturing
    color("red") hollow_ring(pos=1,od=56.5,id=48,ht=17.3);
}
