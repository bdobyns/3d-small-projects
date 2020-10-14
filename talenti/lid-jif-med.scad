// jif medium lid with rear-lens-cap insert

include <jar_lid.scad> // library for making a lid for plastic jars
include <jif-med-params.scad> // jif medium lid

L1="Jif Med Lid";   // outside rim, inside flat surface, outside flat surface
// L2="Jar Type";  // outside flat surface line 2
L3=""; // "Property of:";     // outside flat surface line 3
L4="Barry A Dobyns";   // outside flat surface line 4
L5="408-981-4746";     // outside flat surface line 5

difference() {
    jar_lid(height=lid_height, diameter=lid_inner_diameter, 
        threadpitch=lid_thread_pitch, wallthickness=lid_wallthickness,
        label1=L1, label2=L2, label3=L3, label4=L4, label5=L5,
        rim_grip_arc=lid_rim_grip_arc, rim_text_rot=lid_rim_text_rot);
    
   // cutaway view so we can figure out the thread problems
   // translate([0,0,-0.5]) cube([lid_inner_diameter,lid_inner_diameter,lid_height+2]);
}
