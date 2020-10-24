include<../../lib/ISOThread.scad>;

translate([-10,10,0]) hex_bolt(8,32);	
translate([ 10,10,0]) hex_bolt(8,32);	

translate([-10,-10]) rotate([0,0,60]) wing_nut(8);
translate([ 10,-10]) rotate([0,0,60]) wing_nut(8);