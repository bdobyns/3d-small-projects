

include<../talenti/jar_lid.scad>

difference() {
    import("lampshade-three-graces-straight-26.stl");
    
    d=135;
    h=170;
    color("red") translate([0,0,-1]) hollow_ring(id=d,od=d+30,ht=h);
}