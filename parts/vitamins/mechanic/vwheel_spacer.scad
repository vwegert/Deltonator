/**********************************************************************************************************************
 **
 ** parts/vitamins/vwheel_spacer.scad
 **
 ** This file renders the eccentric spacer used to adjust the V-Wheels. Note that the center hole is not actually
 ** off-center in this model.
 **
 **********************************************************************************************************************/

use <../../conf/part_sizes.scad>

// see https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
module cylinder_outer(height,radius,fn){
	fudge = 1/cos(180/fn);
	cylinder(h=height,r=radius*fudge,$fn=fn);
}

rotate([0, 90, 0])
	difference() {
		union() {
			cylinder_outer(height = vwheel_spacer_hex_height(), radius = vwheel_spacer_hex_size() / 2, fn = 6);
			translate([0, 0, -vwheel_spacer_inset_height()])
				cylinder(h = vwheel_spacer_inset_height(), d = vwheel_spacer_inset_diameter(), $fn = 48);
		}
		translate([0, 0, -vwheel_spacer_inset_height()])
			cylinder(d = vwheel_spacer_bore_diameter(), h = vwheel_spacer_total_height(), $fn = 48);
	}
