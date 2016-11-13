/**********************************************************************************************************************
 **
 ** parts/extrusions/vslot_2020.scad
 **
 ** This file ontains some general functions that provide the dimensions of the profile as well as the modules used 
 ** to import the rendered rails. 
 ** This file is intended to be included by other files down the line.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>

/**
 * Provides the pre-rendered horizontal side piece.
 * The extrusion will lie horizontally along the positive X axis and will extend into positve Y and Z.
 */
module vslot_2020_side() {
	bom_entry(section = "Aluminium Extrusions", description = "V-Slot Extrusion", size = str(horizontal_extrusion_length(), "x20x20 mm"));
	color_extrusion()
		import(file = "vslot_2020_side.stl"); 
}

/**
 * Create an object that resembles the outer shell of a V-Slot 20x20 mm extrusion. Usage is similar
 * to vslot_extrusion(length). This is handy to punch a hole into a printed part that will later
 * accomodate the V-Slot 20x20 mm extrusion.
 */
module vslot_2020_punch(length, rounded = false) {
	color_punch()
		linear_extrude(height = length, center = false, convexity = 10)
			if (rounded) {
				hull($fn = vslot_2020_edge_resolution()) {
					translate([vslot_2020_edge_radius(), vslot_2020_edge_radius(), 0])
						circle(r = vslot_2020_edge_radius());
					translate([vslot_2020_depth() - vslot_2020_edge_radius(), vslot_2020_edge_radius(), 0])
						circle(r = vslot_2020_edge_radius());
					translate([vslot_2020_edge_radius(), 18.5, 0])
						circle(r = vslot_2020_edge_radius());
					translate([vslot_2020_depth() - vslot_2020_edge_radius(), vslot_2020_width() - vslot_2020_edge_radius(), 0])
						circle(r = vslot_2020_edge_radius());
				}
			} else {
				square([vslot_2020_depth(), vslot_2020_width()]);
			}
}
