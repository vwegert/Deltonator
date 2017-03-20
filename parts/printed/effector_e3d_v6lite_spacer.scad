/**********************************************************************************************************************
 **
 ** parts/printed/effector_e3d_v6lite_spacer.scad
 **
 ** This file constructs a spacer that sits above the effector plate and holds the mounting plate on top.
 ** Since the effector is printed flat on its back for maximum precision, these blocks are printed and mounted
 ** separately. Two of these blocks are needed for an effector.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>

/**
 * Creates the spacer by rendering it from scratch. This module is not to be called externally, use 
 * effector_e3d_v6lite_spacer() instead.
 */
module _render_effector_e3d_v6lite_spacer() {
	color_printed_effector()
		difference() {
			// the basic effector shape
			translate([-effector_e3d_v6lite_spacer_depth()/2,
			           -effector_e3d_v6lite_spacer_width()/2,
			           0])	
				cube([effector_e3d_v6lite_spacer_depth(),
					  effector_e3d_v6lite_spacer_width(),
					  effector_e3d_v6lite_spacer_height()]);
			// minus a threaded hole all the way through
			translate([0, 0, -epsilon()])
				cylinder(d = tap_base_diameter(hotend_e3d_v6lite_mounting_hole_size()),
					     h = effector_e3d_v6lite_spacer_height() + 2 * epsilon(),
						 $fn = effector_base_resolution());					     
		}
}

/**
 * Main module to use the pre-rendered spacer. The assembly is centered at the origin. 
 */
module effector_e3d_v6lite_spacer() {
	bom_entry(section = "Printed Parts", description = "Effector", size = "E3D V6 Lite Spacer");
	color_printed_effector()
		import(file = "effector_e3d_v6lite_spacer.stl");
}

_render_effector_e3d_v6lite_spacer();
