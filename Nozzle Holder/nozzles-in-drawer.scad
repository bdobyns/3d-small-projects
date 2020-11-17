// This fits inside the triangular compartment in the parts drawer for the CR-6SE and holds your nozzeles
// drawer organizer here:  https://www.thingiverse.com/thing:4612526
//
// this by:
//   Nov-15-2020
//   bdobyns@gmail.com
//   https://www.facebook.com/barry.dobyns/   

use<../lib/text_on.scad>

// typically you need eight because you get eight rows.
//   we print 0.4 on the two longest (bottom) rows because they are the most common
//   we print 0.2 on the next two because after 0.4, they are more common than the others
dims_txt = ["0.4", "0.4", "0.2","0.3","0.5","0.6","0.8","1.0", "0.1",""]; 

maxx = 64;  // x dimension of the triangle mm
maxy = 84;  // y dimension of the triangle mm
ht=7;       // how high the swiss cheese is mm
dia=6.2;    // diameter of holes mm
spc=dia+2;  // spacing between holes mm
strt=5;     // where to start each row mm
e=.1;       // a small epsilon mm
dbg_txt=false;   // debugging text on the hole cutouts
edge_dims=false; // show the dims on the right edge, or left side


difference() {
    union() {
        // I designed this facing the wrong way, so had to switch it late
        translate([2,0,ht]) rotate([0,180,0]) 
        // swiss cheese part
        difference() {
        // this is the basic triangle
        linear_extrude(height=ht) 
          polygon(points = [[0,0],[maxx,0],[0,maxy]]);
           
            // make a lot of holes (maybe more than we need? by cube filling?
            for (xx = [ strt: spc: maxx ] ) {
                for ( yy = [strt: spc : maxy ] ) {
                   // don't draw the hole if it intersects the hypotenuse edge.  
                   // This also means holes off to the far right get drawn as well.  okay.
                   if (lineCircle(x1=maxx, y1=0, x2=0, y2=maxy, cx=xx, cy=yy, r=dia/2+e) == false )
                        one_cyl(xx,yy,dia);
                }
            }
        } // difference() of the wedge, and the holes
        
        // once we did the trigonometry to determine if the holes are on the edge, 
        // it was easy to use the same trig to determine when to write the dim text
        if(edge_dims) {
            for (xx = [ strt: spc: maxx ] ) {
                for ( yy = [strt: spc : maxy ] ) {
                     // do some nozzle dims - if we skipped a hole because of the edge
                    if ( (lineCircle(x1=maxx, y1=0, x2=0, y2=maxy, cx=xx, cy=yy, r=dia/2+e) == true)
                        && (xx > strt) ) {
                            tx = dims_txt[round((yy - strt)/spc)];
                            dim_txt(tx,xx-2.3,yy,dia);
                        }
                 }
            }
        }
        else /* left_dims */ {
            xx=strt;
            for ( yy = [strt: spc : maxy ]) {
                if  (lineCircle(x1=maxx, y1=0, x2=0, y2=maxy, cx=xx, cy=yy, r=dia/2+e) == false) {
                      tx = dims_txt[round((yy - strt)/spc)];
                      // left_txt(tx,xx+spc/2,yy-spc/2+2*e,dia);
                      left_txt(tx,1,yy,strt);
                      }
            }
        }
    } // union() of the swiss cheese and the dims-text
    
    if (edge_dims) // only needed
    // this is the inverse triangle - clip spurious text that overhangs the edge
    linear_extrude(height=ht*2) 
          polygon(points = [[maxx,maxy],[maxx,0],[0,maxy]]);
}

module one_cyl(xx=1, yy=1, dia=1) {
    translate([xx,yy,-0.5])  {
            color("red") cylinder(d=dia, h=ht+1, center=false, $fn=30);
        // we draw the coords on the cylinders so we can decide which ones to exclude above
        // in the for loop, so that we don't have a swiss-cheese edge.  this gives us
        // a surface to write their sizes upon
        if (dbg_txt)
            color("blue") text_on_cube(cube_size=[dia,dia,ht*2.1],t=str(xx,",",yy),size=0.5,face="top");
    }
}

module dim_txt(tx,xx,yy,dia) {
   translate([xx,yy,-0.5]) rotate([0,0,-55])  {
     color("green") text_on_cube(cube_size=[dia,dia,ht*2.1],t=tx,size=1.5,face="top");
   }
}

module left_txt(tx,xx,yy,dia) {
   translate([xx,yy,-0.5]) rotate([0,0,-90]) 
     color("green") text_on_cube(cube_size=[dia,dia,ht*2.1],t=tx,size=1.5,face="top");  
}


// now we tackle the problem of calculating whether a hole intersects the 
// hypotenuse of the triangular surface.  We horribly misuse code from 
// http://www.jeffreythompson.org/collision-detection/line-circle.php
// rewritten by bdobyns for OpenSCAD's bizarre functional one-pass style.

// LINE/CIRCLE Intersection, returns true if the line intersects the circle
function lineCircle(x1, y1, x2, y2, cx, cy, r) =
  // is either endpoint INSIDE the circle?
  // if so, return true immediately
  pointCircle(x1,y1, cx,cy,r) ? true : 
  pointCircle(x2,y2, cx,cy,r) ? true : 
  // is the line tangent to the circle? return false
  ! onSegment(x1, y1, x2, y2, cx, cy, r) ?  false :
  // is the closest distance to the center less than r?
  distance(x1, y1, x2, y2, cx, cy, r) <= r ? true : false; 

// get length of the line
function dist(a,b) = a-b;
  // get distance between the two points using the Pythagorean Theorem
function pythagoras(a,b) = sqrt(pow(a,2) + pow(b,2));
function llen(x1, y1, x2, y2) = pythagoras( dist(x1,x2), dist(y1,y2) );
  // get dot product of the line and circle
function dot(x1, y1, x2, y2, cx, cy, r) =  ( ((cx-x1)*(x2-x1)) + ((cy-y1)*(y2-y1)) ) / pow(llen(x1, y1, x2, y2),2);
function closestX(x1, y1, x2, y2, cx, cy, r) = x1 + (dot(x1, y1, x2, y2, cx, cy, r) * (x2-x1));
function closestY(x1, y1, x2, y2, cx, cy, r) = y1 + (dot(x1, y1, x2, y2, cx, cy, r) * (y2-y1));
  // is this point actually on the line segment?
  // if so keep going, but if not, return false
function onSegment(x1, y1, x2, y2, cx, cy, r) = linePoint(x1=x1,y1=y1,x2=x2,y2=y2, px=closestX(x1, y1, x2, y2, cx, cy, r),py=closestY(x1, y1, x2, y2, cx, cy, r));
  // get distance to closest point
function ndistX(x1, y1, x2, y2, cx, cy, r) = closestX(x1, y1, x2, y2, cx, cy, r) - cx;
function ndistY(x1, y1, x2, y2, cx, cy, r) = closestY(x1, y1, x2, y2, cx, cy, r) - cy;
function distance(x1, y1, x2, y2, cx, cy, r) = pythagoras( ndistX(x1, y1, x2, y2, cx, cy, r), ndistY(x1, y1, x2, y2, cx, cy, r) );

// POINT/CIRCLE returns true if the point is inside the circle
function pointCircle( px, py, cx, cy, r) = llen(px, py, cx, cy) <= r ? true : false ;

// LINE/POINT returns true if the point lies on the line
function linePoint(x1, y1, x2, y2, px, py) =
   (llen(px, py, x1, y1)+llen(px, py, x2, y2) >= llen(x1,y1,x2,y2)-e && 
        llen(px, py, x1, y1)+llen(px, py, x2, y2) <= llen(x1,y1,x2,y2)+e) ? true : false ;
