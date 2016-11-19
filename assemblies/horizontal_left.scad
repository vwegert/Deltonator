/**********************************************************************************************************************
 **
 ** assemblies/horizontal_left.scad
 **
 ** This file renders and provides the horizontal parts on the left side with whatever is attached to it. 
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
module horizontal_left_assembly(position = [0, 0, 0], angle = 0, with_connectors = false) {
	rotate([0, 0, angle]) 
		translate(position) {
			_horizontal_left_assembly();
			// TODO connectors
		}
}

/** 
 * The module that actually renders the assembly. 
 * This module is not intended to be called outside of this file.
 */
module _horizontal_left_assembly(with_connectors = false) {
	// the bottom extrusion
	translate([vslot_2020_depth(), 0, 0])
		rotate([0, 0, 90])
			vslot_2020_side();
	// the top extrusion
	translate([vslot_2020_depth(), 0, vertical_extrusion_length() - vslot_2020_width()])
		rotate([0, 0, 90])
			vslot_2020_side();
}

// render the axis to a separate output file if requested
_horizontal_left_assembly(with_connectors = true);