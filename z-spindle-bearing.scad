/*******************************************************************

This OpenSCAD code and its rendered 3D model are part of the

	Kühling&Kühling RepRap Industrial 3D Printer


All details, BOM, assembling instructions and latest sources:
	http://kuehlingkuehling.de

Designed and developed by:
	Jonas Kühling <mail@jonaskuehling.de>
	Simon Kühling <mail@simonkuehling.de>

Licensed under:
	Creative Commons Attribution-ShareAlike
	CC BY-SA 3.0
	http://creativecommons.org/licenses/by-sa/3.0/

*******************************************************************/

include <configuration.scad>


z_spindle_bearing();




module z_spindle_bearing(){

	difference(){
		union(){
			translate([0,0,0])	
				hull(){
					translate([z_spindle_bearing_body_width/2-wall,rod_dia/2+clearance,0])
						cylinder(r=wall,h=z_spindle_bearing_body_height);
					translate([-z_spindle_bearing_body_width/2+wall,rod_dia/2+clearance,0])
						cylinder(r=wall,h=z_spindle_bearing_body_height);
					translate([z_spindle_bearing_body_width/2-wall,-rod_dia/2-clearance-wall-2*clearance-z_rod_clamp_screw_dia-wall,0])
						cube([wall,wall,z_spindle_bearing_body_height]);
					translate([-z_spindle_bearing_body_width/2,-rod_dia/2-clearance-wall-2*clearance-z_rod_clamp_screw_dia-wall,0])
						cube([wall,wall,z_spindle_bearing_body_height]);
				}
			cylinder(r=bearing_dia/2+clearance+wall,h=z_spindle_bearing_body_height);
		}

		// spindle bearing trap
		translate([0,0,z_spindle_bearing_body_height-bearing_width-clearance])
			cylinder(r=bearing_dia/2+clearance,h=bearing_width+clearance+1);
		translate([0,0,-1])
			cylinder(r=z_spindle_dia/2+clearance+wall_thin,h=z_spindle_bearing_body_height+2);

		// rod clamps
		for(i=[0,1])
			mirror([i,0,0]){
				translate([z_rod_dist/2,0,-1])
					cylinder(r=rod_dia/2+clearance,h=z_spindle_bearing_body_height+2);
				translate([z_rod_dist/2-wall_thin/2,-z_spindle_bearing_body_length,-1])
					cube([wall_thin,z_spindle_bearing_body_length,z_spindle_bearing_body_height+2]);

				translate([z_spindle_bearing_body_width/2-(z_rod_clamp_screw_length+wall+1)/2+1,-rod_dia/2-clearance-wall-clearance-z_rod_clamp_screw_dia/2,z_spindle_bearing_body_height/2])
					rotate([0,0,0])
						teardrop(z_rod_clamp_screw_dia/2+clearance,z_rod_clamp_screw_length+wall+1);
				translate([z_rod_dist/2-clearance-z_rod_clamp_nut_height/2-wall_thin/2-2*wall,-rod_dia/2-clearance-wall-clearance-z_rod_clamp_screw_dia/2,z_spindle_bearing_body_height/2])
					rotate([90,0,0]) rotate([0,-90,0])
						nut_slot(z_rod_clamp_nut_wrench,z_rod_clamp_nut_height,z_spindle_bearing_body_height);
			}
	}
}
