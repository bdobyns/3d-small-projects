// 4 5 7 10 13 17
a = 13;
b = 17;
w = 1.3;
u = 1.5;
h = 20;
k = 37;
l = 9;
fs = 1.2;


rotate(180,[1,0,0]) {
difference() {
union() {
	cylinder( h, b, b, $fs=fs );
}
translate([0,0,-50])
	cylinder( 100, b-w, b-w, $fs=fs );
}
}

difference() {
	union() {
		rotate( 20,[1,0,0]) cylinder( k+l, a-u, a-u, $fs=fs );
		rotate(-20,[1,0,0]) cylinder( k+l, a-u, a-u, $fs=fs );
		rotate( 20,[1,0,0]) cylinder( k, b, a, $fs=fs  );
		rotate(-20,[1,0,0]) cylinder( k, b, a, $fs=fs  );
	}
	rotate( 20,[1,0,0])
		translate([0,0,-5])
		cylinder( k*2, a-u-w, a-u-w, $fs=fs  );
	rotate(-20,[1,0,0])
		translate([0,0,-5])
			cylinder( k*2, a-u-w, a-u-w, $fs=fs );
	rotate( 20,[1,0,0]) 
		translate([0,0,0])
			cylinder( k-5, b-w, a-w, $fs=fs);
	rotate(-20,[1,0,0])
		translate([0,0,0])
			cylinder( k-5, b-w, a-w, $fs=fs );
	rotate( 20,[1,0,0]) 
		translate([0,0,k-5])
			cylinder( 5, a-w, a-u-w, $fs=fs );
	rotate(-20,[1,0,0])
		translate([0,0,k-5])
			cylinder( 5, a-w, a-u-w, $fs=fs );
}

