// modification of sx-70 tripod bracket from 
// https://www.thingiverse.com/thing:2337828
//
// as inspired by instagrammer lordchinchilla_
// who had the same film door problem
// https://www.instagram.com/p/BqLZt9tl_c5/

include<cubeX.scad>
include<text_on.scad>

difference() {

  union() {
  // the imported bracket
  translate([0,0,-1.3]) import("sx70-tripod-bracket.STL"); 
      
  // the extension for the film door 
  color("tan")   
  translate([39.35,15,0]) 
    cubeX([33.5,100,11.004],radius=2.5, 
      rounded=true, center=false, $fn=90);
  }

color("red") text_on_cube(cube_size=[33.5,100,11], 
    t="Barry A Dobyns  +1-408-981-4746",
    locn_vec=[55,105,10.2], 
    rotate=[0,90,90]);
}
// Barry A Dobyns  09-Oct-2020
// bdobyns@gmail.com 