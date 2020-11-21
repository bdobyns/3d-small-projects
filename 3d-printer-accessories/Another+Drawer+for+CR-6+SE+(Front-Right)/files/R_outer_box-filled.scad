import("/Users/bdobyns/Dropbox/Play/3dprint/3d-small-projects/3d-printer-accessories/Another+Drawer+for+CR-6+SE+(Front-Right)/files/R_Outer_Box.stl");

t=33;
translate([15.75,-12.3,0])
    linear_extrude(height=t+5) color("blue")
        polygon(points=[[0,0],[t+6.2,0],[0,t-0.8]]);
