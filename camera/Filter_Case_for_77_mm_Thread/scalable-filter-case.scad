d = 49; // nominal dia

od = d < 59 ? d+17 : d+20; 
// od = d > 70 ? d+23 : od ;
w=2;

resize([od,od,0])
import("/Users/bdobyns/Dropbox/Play/3dprint/3d-small-projects/camera/Filter_Case_for_77_mm_Thread/files/77mm_filter_case.STL");

p=-(od+10);
translate([p,0,0])
resize([od,od,0])
import("/Users/bdobyns/Dropbox/Play/3dprint/3d-small-projects/camera/Filter_Case_for_77_mm_Thread/files/77mm_filter_case_cap.STL");


// translate([8,((od/2)-w),0]) color("red") cube([d,w,w*3]);
