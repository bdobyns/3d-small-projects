// This fits inside the triangular compartment in the parts drawer for the CR-6SE and holds your nozzeles
// drawer organizer here:  https://www.thingiverse.com/thing:4612526
//
// this by:
//   Nov-15-2020
//   bdobyns@gmail.com
//   https://www.facebook.com/barry.dobyns/   

use<../lib/text_on.scad>

maxx = 64;  // x dimension of the triangle mm
maxy = 84; // y dimension of the triangle mm
ht=11; // how high the swiss cheese is mm
dia=6.1; // diameter of holes mm
spc=8; // spacing between holes mm
strt=4; // where to start each row mm
e=.1; // a small epsilon mm
txt=false;
edge_dims=true;

difference() {
    union() {
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
        if(show_dims) {
            for (xx = [ strt: spc: maxx ] ) {
                for ( yy = [strt: spc : maxy ] ) {
                     // do some nozzle dims - if we skipped a hole because of the edge
                    if ( (lineCircle(x1=maxx, y1=0, x2=0, y2=maxy, cx=xx, cy=yy, r=dia/2+e) == true)
                        && (xx > strt) ) {
                            tx= 
                                (yy <= (strt + spc*2) ) ? str("0.4") :
                                (yy <= (strt + spc*4) ) ? str("0.3") :  
                                (yy <= (strt + spc*6) ) ? str("0.2") : str("0.1");
                            
                            // tx=str("0.",min(round(5-(yy/20)),4));  // just a kludge to get 
                            // d=distance(x1=maxx, y1=0, x2=0, y2=maxy, cx=xx, cy=yy, r=dia/2+e);
                            // echo("tx=",tx,"d=", str(d ));
                            dim_txt(tx,xx-2.3,yy,dia);
                        }
                 }
            }
        }
        else {
            xx=strt;
            for ( yy = [strt: spc : maxy ] ) {
                if  (lineCircle(x1=maxx, y1=0, x2=0, y2=maxy, cx=xx, cy=yy, r=dia/2+e) == false) {
                      tx= 
                        (yy <= (strt + spc*2) ) ? str("0.4") :
                        (yy <= (strt + spc*4) ) ? str("0.3") :  
                        (yy <= (strt + spc*6) ) ? str("0.2") : str("0.1");
                      left_txt(tx,,xx+spc/2,yy+spc/2,dia);
                      }
            }
        }
    } // union() of the swiss cheese and the dims-text
    
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
        if (txt)
            color("blue") text_on_cube(cube_size=[dia,dia,ht*2.1],t=str(xx,",",yy),size=0.5,face="top");
    }
}

module dim_txt(tx,xx,yy,dia) {
   translate([xx,yy,-0.5]) rotate([0,0,-55])  {
     color("green") text_on_cube(cube_size=[dia,dia,ht*2.1],t=tx,size=1.5,face="top");
   }
}

module left_txt(tx,xx,yy,dia) {
   translate([xx,yy,-0.5]) 
     color("green") text_on_cube(cube_size=[dia,dia,ht*2.1],t=tx,size=1.5,face="top");  
}


// now we tackle the problem of calculating whether a hole intersects the 
// hypotenuse of the triangular surface.  We horribly misuse code from 
// http://www.jeffreythompson.org/collision-detection/line-circle.php
// rewritten for OpenSCAD's bizarre functional one-pass style.
// LINE/CIRCLE Intersection, returns true if the line intersects the circle
function lineCircle(x1, y1, x2, y2, cx, cy, r) =
  // is either end INSIDE the circle?
  // if so, return true immediately
  pointCircle(x1,y1, cx,cy,r) ? true : 
  pointCircle(x2,y2, cx,cy,r) ? true : 
  ! onSegment(x1, y1, x2, y2, cx, cy, r) ?  false :
  distance(x1, y1, x2, y2, cx, cy, r) <= r ? true : false; 

// get length of the line
function dist(a,b) = a-b;
  // get distance between the two points using the Pythagorean Theorem
function llen(x1, y1, x2, y2) = sqrt( pow(dist(x1,x2),2) + pow(dist(y1,y2),2));
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
function distance(x1, y1, x2, y2, cx, cy, r) = sqrt( pow(ndistX(x1, y1, x2, y2, cx, cy, r),2) + pow(ndistY(x1, y1, x2, y2, cx, cy, r),2) );


// POINT/CIRCLE returns true if the point is inside the circle
function pointCircle( px, py, cx, cy, r) = llen(px, py, cx, cy) <= r ? true : false ;

// LINE/POINT returns true if the point lies on the line
function linePoint(x1, y1, x2, y2, px, py) =
   (llen(px, py, x1, y1)+llen(px, py, x2, y2) >= llen(x1,y1,x2,y2)-e && 
        llen(px, py, x1, y1)+llen(px, py, x2, y2) <= llen(x1,y1,x2,y2)+e) ? true : false ;
