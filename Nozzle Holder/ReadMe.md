[drawer_org]:  https://www.thingiverse.com/thing:4612526 
[419mining]: https://www.thingiverse.com/419mining/designs
[scad]: OpenScAD.org

# Nozzles Holder for CR-6 SE Drawer Organizer

This is an accessory for the [drawer organizer][drawer_org] on Thingiverse.com by [419mining][], which I highly recommend.  You want to print out his organizer first, and then this goes in the triangular opening that isn't used by any other tools. 

This whole thing was banged together in an evening, and I wrote most of this ReadMe during the first printing.   It uses Math(tm) to figure out which holes would intersect the hypotenuse so that you don't have half-open holes along that edge.  This allows you to change the spacing between holes or the offset from the edge, and it will recalculate how many holes can fit in a row.

* Works properly with Customizer by labeling variables properly (updated: Nov-17-2020)
* Included the [OpenSCAD][scad] file so that you can change the spacing between the holes or change the text to identify the nozzles on each row.
* Included the STL at two different heights, 7mm and 11mm.
* Included the PLA gcode at 0.2mm layers, 0.4mm nozzle, 20% infill, sliced by Prusa

### .scad Code Notes:

*  this requires ```text_on()``` which is a library from https://github.com/brodykenrick/text_on_OpenSCAD - if you don't have this library, it still works; you just lose the text on each row.
*  you can change the spacing between holes with ```spc=``` near the top
*  you can make the whole insert taller (thicker) with ```ht=``` near the top.  6mm is tall enough to hold the nozzles, but the drawer insert is 11.8mm tall
*  change ```dims_txt=[]``` to alter the label on each row of holes
*  you can change how close holes are to the right angle sides with ```strt=```
*  you can change how close holes are to the hypotenuse with ```e=``` (epsilon)
*  figuring out if a hole intersects the hypotenuse edge is based on a working code example from http://www.jeffreythompson.org/collision-detection/line-circle.php which in turn includes routines for vector distance, vector dot-product, and more.
  *  converting that working procedural code into working stateless functional code for OpenSCAD took more time than all the rest.  OpenSCAD looks like normal programming but is not, in important ways.
  * but it allowed the script to be fully parameterized. 
    


### attribution
* Nov-15-2020
* bdobyns@gmail.com
* https://www.facebook.com/barry.dobyns/  