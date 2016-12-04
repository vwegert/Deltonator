/**********************************************************************************************************************
 **
 ** assemblies/horizontal_side.scad
 **
 ** This file renders and provides the horizontal parts on the sides with whatever is attached to it. 
 ** This assembly can be rendered into an STL file; however, for further construction of the model, that rendered
 ** version is NOT used because all the color information would be lost.
 **
 **********************************************************************************************************************/

include <../conf/colors.scad>
include <../conf/derived_sizes.scad>
include <../conf/part_sizes.scad>

use <../parts/extrusions/vslot_2020.scad>

/**
 * Provides access to the assembly.
 */
module horizontal_assembly(side = A, angle = 0, with_connectors = false) {
	rotate([0, 0, angle]) 
		translate([horizontal_distance_center_edge(), 0, 0])
			rotate([0, 0, 180])
				translate([-vslot_2020_depth() - horizontal_extrusion_outward_offset(), 
					       -horizontal_extrusion_length()/2, 
					       0]) {
					_horizontal_assembly(side = side, with_connectors = with_connectors);
					// TODO connectors	
				}
}

/** 
 * The module that actually renders the assembly. 
 * This module is not intended to be called outside of this file.
 */
module _horizontal_assembly(side = A, with_connectors = false) {
	if (foot_with_rail()) {
		// the bottom extrusion
		translate([vslot_2020_depth(), 0, 0])
			rotate([0, 0, 90])
				vslot_2020_side();
	}
	// the bed-level extrusion
	translate([vslot_2020_depth(), 0, bed_bracket_z_offset() + bed_bracket_height() - vslot_2020_width()])
		rotate([0, 0, 90])
			vslot_2020_side();
	// the top extrusion
	translate([vslot_2020_depth(), 0, vertical_extrusion_length() - vslot_2020_width()])
		rotate([0, 0, 90])
			vslot_2020_side();
}

// render the axis to a separate output file if requested
_horizontal_assembly(side = A, with_connectors = true);