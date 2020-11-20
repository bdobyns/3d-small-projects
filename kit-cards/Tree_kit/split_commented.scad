/*
New version with readable comments

The radius sequence I used to generate the STL files is
4 5 7 10 13 17

*/

b = 17; // piece radius, base/trunk
a = 13; // piece radius, branches

w = 1.3; // wall thickness -- tune for your printer
u = 1.5; // difference between peg size and branch size
h = 20;  // height/length of the base/trunk
k = 37;  // height/length of the branches
l = 9;   // length of the pegs

fs = 1.2; // feature size for cylinders ( smaller = finer )

// base/trunk
rotate(180,[1,0,0]) difference() {
	cylinder( h, b, b, $fs=fs );
	translate([0,0,-50]) cylinder( 100, b-w, b-w, $fs=fs );
}

difference() {
	union() {
		rotate( 20,[1,0,0]) cylinder( k+l, a-u, a-u, $fs=fs );
		rotate(-20,[1,0,0]) cylinder( k+l, a-u, a-u, $fs=fs );
		rotate( 20,[1,0,0]) cylinder( k, b, a, $fs=fs  );
		rotate(-20,[1,0,0]) cylinder( k, b, a, $fs=fs  );
	}
	rotate( 20,[1,0,0]) translate([0,0,-5])
		cylinder( k*2, a-u-w, a-u-w, $fs=fs  );
	rotate(-20,[1,0,0]) translate([0,0,-5])
			cylinder( k*2, a-u-w, a-u-w, $fs=fs );
	rotate( 20,[1,0,0]) translate([0,0,0])
			cylinder( k-5, b-w, a-w, $fs=fs);
	rotate(-20,[1,0,0]) translate([0,0,0])
			cylinder( k-5, b-w, a-w, $fs=fs );
	rotate( 20,[1,0,0]) translate([0,0,k-5])
			cylinder( 5, a-w, a-u-w, $fs=fs );
	rotate(-20,[1,0,0]) translate([0,0,k-5])
			cylinder( 5, a-w, a-u-w, $fs=fs );
}

