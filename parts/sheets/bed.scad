/**********************************************************************************************************************
 **
 ** parts/sheets/bed.scad
 **
 ** This file generates the heated bed with the holes for the mounting assembly.
 ** This file is intended to be included by other files down the line.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>

/**
 * Provides the pre-rendered bed plate. It will be centerd at the origin and wjust needs to be raised into positive Z
 * appropriately.
 */
module bed_plate() {
	bom_entry(section = "Sheet / Cast Aluminium", 
		      description = "Bed Plate", 
		      size = str("d = ", bed_diameter(), " mm, h = ", bed_thickness(), " mm"));
	color_cast_aluminium()
		import(file = "bed.stl"); 
}

module _bed_plate_mounting_hole() {
	translate([bed_center_hole_distance(), 0, -epsilon()])
		cylinder(d = bed_mounting_hole_size(), h = bed_thickness() + 2 * epsilon(), $fn = bed_mounting_hole_resolution());
	// TODO the hole should be countersunk
}

/** 
 * Renders the bed plate. This module is not intended to be called outside of this file.
 */
module _render_bed_plate() {
	difference() {
		// the base plate
		cylinder(d = bed_diameter(), h = bed_thickness(), $fn = 192);
		// minus the mounting holes
		rotate([0, 0, 0])
			_bed_plate_mounting_hole();
		rotate([0, 0, 120])
			_bed_plate_mounting_hole();
		rotate([0, 0, 240])
			_bed_plate_mounting_hole();
	}
}

_render_bed_plate();