/**********************************************************************************************************************
 **
 ** parts/printed/foot_plate.scad
 **
 ** This file constructs the plate that is screwed under the foot bracket to level the printer. To assemble the 
 ** printer, you need three of these parts.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

/**
 * Creates the foot plate by rendering it from scratch. This module is not to be called externally, use 
 * foot() instead.
 */
module _render_foot_plate() {
	color_printed_outer_frame()
		render() {
			translate([0, 0, -foot_plate_thickness()])
				difference() {
					// the base plate
					cylinder(d = foot_plate_diameter(),
						     h = foot_plate_thickness(),
					    	 $fn = foot_plate_sides());
					// minus the screw hole (all the way through)
					translate([0, 0, -epsilon()])
						cylinder(d = foot_plate_screw_size(),
								 h = foot_plate_thickness() + 2 * epsilon(),
								 $fn = foot_plate_screw_hole_resolution());
					// minus the recess for the screw head
					translate([0, 0, -epsilon()])
						cylinder(d = nut_key_outer_diameter(foot_plate_screw_size()),
								 h = foot_plate_screw_recess_depth() + epsilon(),
								 $fn = 6);


				}
		} 
}

/**
 * Main module to use the pre-rendered foot plate. The assembly is centered at the origin protrudin ginto negative Z.
 */
module foot_plate() {
	bom_entry(section = "Printed Parts", description = "Frame", size = "Foot Plate");
	color_printed_outer_frame()
		import(file = "foot_plate.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module foot_plate_hardware() {
	translate([0, 0, foot_plate_screw_recess_depth() + epsilon() - foot_plate_thickness()])
		rotate([0, -90, 0])
			// TODO this renders a cap screw, but what we really want is a hex head screw here
			screw(size = foot_plate_screw_size(), min_length = foot_plate_screw_min_length());
}

_render_foot_plate();
