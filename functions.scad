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

module teardrop (r=4.5,h=20,alpha=45,teardropcorner=0,fulldrop=0){		// tear drop hole for top-centering
											// use teardropcorner=1 for bottom horizontal corners
	render()
	translate([-h/2,0,0])
		rotate([-270,0+(teardropcorner*180),90])
			difference(){
				linear_extrude(height=h){
					circle(r);
					polygon(points=[[0,0],[r*cos(alpha),r*sin(alpha)],[0,r/sin(alpha)],[-r*cos(alpha),r*sin(alpha)]], paths=[[0,1,2,3]]);
				}
				if(fulldrop==0) 
					translate([0,(r/sin(alpha))/2+r,h/2]) cube([2*r+2,r/sin(alpha),h+2],center=true);
			}
}

//teardrop(4.5,22,fulldrop=true);



module teardropcentering (r=4.5,h=20,alpha=45){				// tear drop hole for top-centering
	centering_offset_factor = 1.1;
	render()
	translate([-h/2,0,0])
		rotate([-270,0,90])
			difference(){
				linear_extrude(height=h){
					circle(r, $fn=24);
					polygon(points=[[0,0],[r*cos(alpha),r*sin(alpha)],[0,r/sin(alpha)],[-r*cos(alpha),r*sin(alpha)]], paths=[[0,1,2,3]]);
				}
				translate([0,(r/sin(alpha))/2+r*centering_offset_factor,h/2]) cube([2*r+2,r/sin(alpha),h+2],center=true);
			}
}

//teardropcentering();



module teardropcentering_half (r=4.5,h=20, bottom=0,alpha=45){				// tear drop hole for top-centering
																// upper half (bottom=0) or bottom half (bottom=1)
	centering_offset_factor = 1.2;
	render()
	translate([-h/2,0,0])
		rotate([-270,0,90])
			difference(){
				linear_extrude(height=h){
					circle(r, $fn=24);
					polygon(points=[[0,0],[r*cos(alpha),r*sin(alpha)],[0,r/sin(alpha)],[-r*cos(alpha),r*sin(alpha)]], paths=[[0,1,2,3]]);
				}
				translate([0,(r/sin(alpha))/2+r*centering_offset_factor,h/2]) cube([2*r+2,r/sin(alpha),h+2],center=true);
				translate([0,-(r*centering_offset_factor)/2-0.5+bottom*(r*centering_offset_factor+1),h/2]) cube([2*r+2,r*centering_offset_factor+1,h+2],center=true);
			}
}

//teardropcentering_half(bottom=0);


module polyhole(d,h){
	n = max(round(2 * d),3);
	cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n, center=true);
}



module roundcorner(radius,edge_length){
	render()
	translate([0,0,-1])
		difference(){
			translate([-1,-1,0])
				cube(size = [radius+1,radius+1,edge_length+2], center = false);
			translate(v = [radius,radius,-1])
				cylinder(h = edge_length+4, r=radius, center=false,$fs=0.1);
		}
}

//roundcorner(5,5);



module roundcorner_tear(radius,edge_length){
	render()
	difference(){
		translate([-1,-1,-1])
			cube(size = [edge_length+2, radius+1, radius+1], center = false);
		translate([(edge_length+4)/2-2, radius, radius])
			teardrop(radius, edge_length+4,teardropcorner=1);
	}
}

//roundcorner_tear(8,20);


module roundedge_tear(radius){
	render()
	difference(){
		translate([-1,-1,-1])
			cube(size = [radius+1, radius+1, radius+1], center = false);
		translate([radius,radius,radius])
			union(){
				sphere(r=radius, $fs=0.1);
				translate([0,0,-radius])
					cylinder(r1=(radius*sin(45))-(radius-(radius*sin(45))),r2=radius*sin(45),h=(radius-(radius*sin(45))), $fs=0.1);
			}
	}
}

//roundedge_tear(20);



module roundedge(radius){
	render()
	difference(){
		translate([-1,-1,-1])
			cube(size = [radius+1, radius+1, radius+1], center = false);
		translate([radius,radius,radius])
			sphere(r=radius, $fs=0.1);
	}
}

//roundedge(5);


module nut_trap(nut_wrench_size,trap_height,vertical=0, clearance=0.2,center=true){		// M3 wrench size = 5.5
	radius = cornerdiameter(nut_wrench_size+2*clearance) /2;
	rotate([0,vertical*90,0])
		cylinder(h = trap_height, r = radius, center=center, $fn = 6);
}

//nut_trap(5,5,0);

module nut_slot(nut_wrench_size,nut_height, nut_elevation,vertical=0, clearance=0.2){		// M3 wrench size = 5.5
	radius = cornerdiameter(nut_wrench_size+2*clearance) /2;
	slot_height = nut_height+2*clearance;
	slot_width = nut_wrench_size+2*clearance;
	rotate([0,vertical*270,0]){
		cylinder(h = slot_height, r = radius, center=true, $fn = 6);
		translate([0,-slot_width/2,-slot_height/2]) cube([nut_elevation+1,slot_width,slot_height]);
	}
}

//nut_slot(5.5,3,4,1);

function cornerdiameter(wrench_size) =  2* ((wrench_size)/2)/ cos(180/6);
function cornerdiameter_8(wrench_size) =  2* ((wrench_size)/2)/ cos(180/8);
