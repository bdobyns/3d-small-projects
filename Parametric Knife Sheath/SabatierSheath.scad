
extrusion = 0.45;
wallPerimeters = 2;
bladeThickness = 2.55;
frameThickness = 2;
wallThickness = extrusion*wallPerimeters;
totalThickness = 2*wallThickness+bladeThickness;
clearance=0.5;
cutoutWidth = 8;
cutoutOverlap = 1;
cutoutStart = 10;
f = 1.0/10; // fudge factor
f2 = f*2;
fvz = [0,0,-f];

// waypoints is too long to type, sorry
// list of waypoints in ascending x-coordinate order
// Form is [x, bottom y, top y]; begin with x=0
wps = [
    [0, 0, 40],
    [10, 0, 40],
    [20, 0, 40],
    [30, 0.5, 39.5],
    [40, 1, 39],
    [50, 1, 38.5],
    [60, 1, 38],
    [70, 1.5, 37.5],
    [80, 1.5, 36.5],
    [90, 2, 36],
    [100, 2.5, 35.5],
    [110, 2.5, 35],
    [120, 3, 34.5],
    [130, 3.5, 33.5],
    [140, 4, 32],
    [150, 4.5, 30.5],
    [160, 5, 28.5],
    [170, 6.5, 26],
    [180, 8.5, 23],
    [190, 11, 17.5],
    [195, 14, 14]
    ];
function maxList(a, i = 0) = (i < len(a) - 1) ? max(a[i], maxList(a, i+1)) : a[i];
function column(a, index) = [for (L=a) L[index]];
    echo (column(wps,1));
maxX=maxList(column(wps,0));
maxY=maxList(column(wps,2));

union() {
    frame();
    wallWithCutouts(start=10);
    translate([0,0,wallThickness+bladeThickness]) wallWithCutouts(start=cutoutStart+cutoutWidth+cutoutOverlap);
}
module frame(){
    difference() {
        linear_extrude(height=totalThickness) offset(r=frameThickness+clearance) bladePolys();
        translate(fvz) linear_extrude(height=totalThickness+f2) offset(r=clearance) bladePolys();
        mirror([1,0,0]) translate([0,-2*frameThickness+clearance,-f]) cube([2*frameThickness+clearance, maxY+4*frameThickness+clearance,totalThickness+f2]);
    }
}

module bladePolys(){
    for(i=[0:len(wps)-2]) {
        polygon([[wps[i][0],wps[i][1]], [wps[i][0],wps[i][2]], [wps[i+1][0],wps[i+1][2]],[wps[i+1][0], wps[i+1][1]],[wps[i][0],wps[i][1]]]);
    }
}

module wall() {
    difference() {
        linear_extrude(wallThickness) offset(r=frameThickness+clearance) bladePolys();
        mirror([1,0,0]) translate([0,-2*frameThickness+clearance,-f]) cube([2*frameThickness+clearance, maxY+4*frameThickness+clearance,wallThickness+f2]);
    }
}

module wallWithCutouts(start=0) {
    difference() {
        wall();
        for(x=[start:2*cutoutWidth+2*cutoutOverlap:maxX]) translate([x,-f-frameThickness,-f]) cube([cutoutWidth,maxY+2*frameThickness+clearance+f2,wallThickness+f2]);
    }
}