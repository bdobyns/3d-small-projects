difference() {
rotate([90,0,0])
import("BASE.stl");

translate([-99.2,-20,-10])
cube([40,40,100]);

translate([58.9,-20,-10])
cube([40,40,100]);
}





difference() {
union(){
translate([58,40,-0.7])
color("red") import("bar-thread-end.stl");

translate([-77,40,-0.7])
color("red") import("bar-thread-end.stl");
}
translate([-96,-20,0])
cube([40,40,10]);

translate([57,-20,0])
cube([40,40,10]);
}
