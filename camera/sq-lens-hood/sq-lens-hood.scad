
// we try and calculate the size of the outer square taking into account the angle of view of the lens in question
// this has three variables we need to know: 
//   focal_length in mm
//   image_plane_horizontal in mm
//   Image_plane_vertical in mm

include<../../lib/text_on.scad>

/*  
the first column is values for 'sensor'
+-------+-------+------+
| type  | vert  | horz |
+-------+-------+------+
| 35mm  | 24    | 36   |
| APS-C | 16.7  | 25.1 |
| 4/3   | 13.5  | 18mm |
| 6x4.5 | 56.9  | 41.8 |
| 6x6   | 56.9  | 56.9 |
| 6x7   | 56.9  | 66.9 |
| 6x9   | 56.9  | 83.7 |
| 6x12  | 56.9  | 110  |
+-------+-------+------+
*/


// the inputs
focal_length=35; // the real focal length of your lens (not a 35mm equivalent)
sensor="APS-C"; // the format of your film camera or digital sensor
hood_inner_diameter=42.6; // the inner diameter of the hood where it slips over the lens
rim_height=2;  // the height of the straight portion at the lens
hood_max=65; // never make a hood longer than this
hood_thick=4;    // thickness of the walls 
hood_text=false;  // do we emboss the focal length, inner diameter and format?
alt_text="Sony E 16-50 kit lens"; // optional, goes on one long flat side

echo(focal_length=focal_length);
echo(sensor=sensor);
echo(hood_inner_diameter=hood_inner_diameter);
echo(rim_height=rim_height);
echo(hood_thick=hood_thick);

make_sq_hood();
// help_msg();

module make_sq_hood() {
// some constants
e=0.3;      // a small epsilon
box_corner_radius=3;   // rounding at the corners of the hood square end
$fn=90;       // make round things more round

Image_plane_vertical=v_lookup(sensor);  echo(Image_plane_vertical=Image_plane_vertical);
image_plane_horizontal=h_lookup(sensor); echo(image_plane_horizontal=image_plane_horizontal);


function degrees(a) = (a*180/PI);
// calculate the aov based on http://www.radical.org/aov
//    still available here https://web.archive.org/web/20160304084454/http://www.radical.org/aov/
// atan() in excel operates on radians
// atan() in openscad operates on degrees
vertical_angle_of_view = 2*atan(Image_plane_vertical /(2*focal_length)); echo(vertical_angle_of_view=vertical_angle_of_view);
horizontal_angle_of_view = 2*atan(image_plane_horizontal/(2*focal_length)); echo(horizontal_angle_of_view=horizontal_angle_of_view);
vB_angle = 90 - vertical_angle_of_view/2; echo(vB_angle=vB_angle);
hB_angle = 90 - horizontal_angle_of_view/2; echo(hB_angle=hB_angle);


// use pythogras to figure out the necessary size.
// see https://www.calculator.net/triangle-calculator.html

/*
C
| \
|  \
|   \
b   a
|     \
|      \
|       \
A---c----B

we know the angle of view aov which is B
we know the desired height of the hood b in the picture, typically less than or equal to the focal length
we know the minimum for c, which is based on the inner diameter of the hood_inner_diameter/2
we know that A is a right angle, always

so we have b >= hood_inner_diameter/2 , A=90, B=hB_angle or B=vB_angle
which allows us to calculate the rest

thus, 
C= 180 - A - B;
a = b·sin(A)/sin(B)
c = b·sin(C)/sin(B) 

b=hood_transition_height+rim_height; // we only need one rim_height for the one at the far end.
hC_angle = 180 - 90 - hB_angle;
box_end_horizontal = b*sin(hC_angle)/sin(hB_angle);
vC_angle = 180 - 90 - vB_angle;
box_end_vertical = b*sin(vC_angle)/sin(vB_angle);

then do a check for b > hood_inner_diameter/2;

*/

// hood_transition_height the total height of the transition part (perpendicular to film plane)
hood_transition_height= focal_length/2 > hood_max ? hood_max : focal_length/2; echo(hood_transition_height=hood_transition_height);
b=hood_transition_height+rim_height; echo(b=b);

hC_angle = 180 - 90 - hB_angle; echo(hC_angle=hC_angle);
hh = b*sin(hC_angle)/sin(hB_angle); 
// box_end_horizontal = the horizontal width of the hood sq end (parallel to the film plane)
// always make it wider by a bit, so it be cool
box_end_horizontal = hh < hood_inner_diameter ? hood_inner_diameter + rim_height + (image_plane_horizontal-Image_plane_vertical): hh  ;  echo(box_end_horizontal=box_end_horizontal);

vC_angle = 180 - 90 - vB_angle; echo(vC_angle=vC_angle);
hv = b*sin(vC_angle)/sin(vB_angle);
// box_end_vertical the inside tallness of the hood (parallel to the film plane)
box_end_vertical = hv < hood_inner_diameter ? hood_inner_diameter + rim_height : hv ;  echo(box_end_vertical=box_end_vertical);

// we make an inner hull and an outer hull, so we can subtract one from the other
difference() {
    // outer shell of hood
    union() {
        // the slip-on part at the lens
        cylinder(d=(hood_inner_diameter+hood_thick),h=(rim_height));
        
        // the transition
        hull() {
            // the round part where the hull begins
            translate([0,0,rim_height])
                cylinder(d=(hood_inner_diameter+hood_thick),h=e);
            // the square part of the hood
            translate([0,0,hood_transition_height])
                minkowski() {
                    cube([(box_end_horizontal+hood_thick-box_corner_radius), (box_end_vertical+hood_thick-box_corner_radius),rim_height/2],center=true);
                    if (box_corner_radius != 0) cylinder(r=box_corner_radius,center=true); // rounded corners
                } // square end
            } // the slanted hull part
        } // outer shell
    
     // inner cutout 
    union() {
        // the slip-on part at the lens
        translate([0,0,(-e/2)])
            cylinder(d=hood_inner_diameter,h=rim_height+e);
        // the transition
        hull() {
            // the round part where the hull begins
            translate([0,0,rim_height])
                cylinder(d=(hood_inner_diameter),h=e);
            // the square part of the hood
            translate([0,0,hood_transition_height])
                minkowski() {
                    cube([box_end_horizontal-box_corner_radius, box_end_vertical-box_corner_radius,rim_height/2],center=true);
                    if (box_corner_radius != 0)  cylinder(r=box_corner_radius,center=true); // rounded corners
                } // square end
            } // the slanted hull part
        } // outer shell
  
        
    // whack off a little more of the hood interior 
    {
        // the square part of the hood
        translate([0,0,hood_transition_height+e])
            minkowski() {
                cube([box_end_horizontal-box_corner_radius,box_end_vertical-box_corner_radius,rim_height/2],center=true);
                if (box_corner_radius != 0) cylinder(r=box_corner_radius,center=true); // rounded corners
            } // square end
     }   
} // end of difference()

if(hood_text) {
// use text_on() to put the input parameters directly on the hood.

// put the hood_inner_diameter on the lower ring FRONT
color("red")
    text_on_cylinder(t=str(hood_inner_diameter,"mm"),
        size=rim_height/2,
        r=(hood_inner_diameter+hood_thick)/2,
        h=1.5, face="front",updown=rim_height/3, eastwest=0);
// put the hood_inner_diameter on the lower ring BACK
rotate([0,0,180]) color("red") 
    text_on_cylinder(t=str(hood_inner_diameter,"mm"),
        size=rim_height/2,
        r=(hood_inner_diameter+hood_thick)/2,
        h=1.5, face="front",updown=rim_height/3, eastwest=0);
// put the sensor format and focal length along the long flat edge FRONT
fl_fmt_txt=str(focal_length,"mm lens  /  ", sensor, " camera");
alt_txt= len(alt_text) > 0 ? alt_text : fl_fmt_txt;
color("red")
  translate([0,0,hood_transition_height])
    text_on_cube(cube_size=[(box_end_horizontal+hood_thick-box_corner_radius), 
                            (box_end_vertical+hood_thick+box_corner_radius),rim_height/2],
                t=alt_txt,  // only put the alternative_text on one side
                size=rim_height/2,
                halign="center",
                face="front");
// put the sensor format and focal length along the long flat edge BACK                
rotate([0,0,180]) color("red") 
  translate([0,0,hood_transition_height])
    text_on_cube(cube_size=[(box_end_horizontal+hood_thick-box_corner_radius), 
                            (box_end_vertical+hood_thick+box_corner_radius),rim_height/2],
                t=fl_fmt_txt, // always put the focal length and fmt on the other
                size=rim_height/2,
                halign="center",
                face="front");
} // end of if (hood_text)              
  

} // end of module make_sq_hood()

/*  
typical usable film sensor dimensions
+-------+-------+------+
| type  | vert  | horz |
+-------+-------+------+
| 35mm  | 24    | 36   |
| APS-C | 16.7  | 25.1 |
| 4/3   | 13.5  | 18mm |
| 6x4.5 | 56.9  | 41.8 |
| 6x6   | 56.9  | 56.9 |
| 6x7   | 56.9  | 66.9 |
| 6x9   | 56.9  | 83.7 |
| 6x12  | 56.9  | 110  |
+-------+-------+------+
*/
function h_lookup(s) = (
       s == "35mm"  ? 36 
     : s == "APS-C" ? 25.1
     : s == "4/3"   ? 18
     : s == "6x4.5" ? 41.8
     : s == "6x6"   ? 56.9
     : s == "6x7"   ? 67
     : s == "6x9"   ? 83.7
     : s == "6x12"  ? 110
     : 0 
);

function v_lookup(s) = (
       s == "35mm"  ? 24 
     : s == "APS-C" ? 16.7
     : s == "4/3"   ? 13.5
     : s == "6x4.5" ? 56.9
     : s == "6x6"   ? 56.9
     : s == "6x7"   ? 56.9
     : s == "6x9"   ? 56.9
     : s == "6x12"  ? 56.9
     : 0 
);

module help_msg() {

echo("");
echo("C");
echo("|-\\");
echo("|--\\");
echo("|---\\");
echo("b----a");
echo("|-----\\");
echo("|------\\");
echo("|-------\\");
echo("A---c---B");
echo(" ");
echo("we know the angle of view aov which is B");
echo("we know the desired height of the hood b in the picture, typically less than or equal to the focal length");
echo("we know the minimum for c, which is based on the inner diameter of the hood_inner_diameter/2");
echo("we know that A is a right angle, always");
echo(" ");
echo("so we have b >= hood_inner_diameter/2 , A=90, B=hB_angle or B=vB_angle");
echo("which allows us to calculate the rest");
echo(" ");
echo("thus, ");
echo("C= 180 - A - B;");
echo("a = b·sin(A)/sin(B)");
echo("c = b·sin(C)/sin(B) ");
echo("");
echo("b=hood_transition_height+rim_height; // we only need one rim_height for the one at the far end.");
echo("hC_angle = 180 - 90 - hB_angle;");
echo("box_end_horizontal = b*sin(hC_angle)/sin(hB_angle);");
echo("vC_angle = 180 - 90 - vB_angle;");
echo("box_end_vertical = b*sin(vC_angle)/sin(vB_angle);");
echo("");
echo("then do a check for b > hood_inner_diameter/2;");

}
    