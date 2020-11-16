# Nozzles Holder for CR-6 SE Drawer Organizer
[drawer_org]:  https://www.thingiverse.com/thing:4612526 
[419mining]: https://www.thingiverse.com/419mining/designs
[scad]: OpenScAD.org
[polyhedron]: https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids#polyhedron

This depends first on the [drawer organizer][drawer_org] on Thingiverse.com by [419mining][] which I highly recommend.  You want to print out his organizer first, and then this goes in the triangular opening that isn't used by any other parts.

I used my calipers to measure the nozzles I had laying around and then designed this so that it holds them with the threaded end down, and with reasonable spacing so you can pick one out.

This whole thing was banged together in an evening, and I wrote most of this ReadMe during the first printing.   It uses trigonometry to figure out where the circles lie with respect to the hypotenuse so that you don't have open circles along that edge.

* Included the [OpenSCAD][scad] file so that you can change the spacing between the holes, or add some text to identify the nozzles on each row.
* Included the STL
* Included the gcode at 0.2mm layers, 0.4mm nozzle, 20% infill, sliced by Prusa

### Code Notes:

*  this requires ```text_on()``` which is a library from https://github.com/brodykenrick/text_on_OpenSCAD
*  you can change the spacing between holes with ```spc=``` near the top
*  you can make the whole insert taller with ```ht=``` near the top.  I printed only tall enough to hold the nozzles, but the drawer insert is 11.8mm tall
*  you can change how close it is to the right angle sides with ```strt=```
*  you can change how close it gets to the hypotenuse with ```e=```
*  I should have used ```polyhedron()``` instead of ```linear_extrude() polygon()``` but my copy of OpenSCAD threw an error on ```polyhedron()```.  Oh well.
*  if you want to adjust where each row begins to leave room for a label in front of each row, change ```strt=spc/2;``` to something larger, like ```strt=spc*6/7```
*  figuring out if a circle intersects an edge is based on a working example fromfrom http://www.jeffreythompson.org/collision-detection/line-circle.php  
  *  converting that working procedural code into stateless functional code for OpenSCAD took more time than all the rest.
  * but it allowed the script to be fully parameterized 
    
### Laziness or Bug?

* when you set ```show_dims=true```
   * it only shows nozzle dimensions on the first two rows.  
   * Furthermore, all the calculations about where and how to place the dimensions are caught up in if statements like the ones for which holes to omit.  Only more complicated.
   * It's probably easier to use a fine-point sharpie marker



### attribution
* Nov-15-2020
* bdobyns@gmail.com
* https://www.facebook.com/barry.dobyns/  