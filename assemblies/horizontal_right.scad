/**********************************************************************************************************************
 **
 ** assemblies/horizontal_right.scad
 **
 ** This file renders and provides the horizontal parts on the right side with whatever is attached to it. 
 ** This assembly can be rendered into an STL file; however, for further construction of the model, that rendered
 ** version is NOT used because all the color information would be lost.
 **
 **********************************************************************************************************************/

use <../parts/extrusions/vslot_2020.scad>

/**
 * Provides access to the assembly.
 */
module horizontal_right_assembly(position = [0, 0, 0], angle = 0, with_connectors = false) {
	translate(position)
		rotate([0, 0, angle]) {
			_horizontal_right_assembly();
			// TODO connectors
		}
}

/** 
 * The module that actually renders the assembly. 
 * This module is not intended to be called outside of this file.
 */
module _horizontal_right_assembly(with_connectors = false) {
	// the bottom extrusion
	// TODO offset to match foot?
	vslot_2020_side();
}

// render the axis to a separate output file if requested
_horizontal_right_assembly(with_connectors = true);