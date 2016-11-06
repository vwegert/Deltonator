/**********************************************************************************************************************
 **
 ** assemblies/vertical_axis.scad
 **
 ** This file renders and provides the entire vertical axis assembly with all brackets, motors and whatever is 
 ** attached to it. 
 ** This assembly can be rendered into an STL file; however, for further construction of the model, that rendered
 ** version is NOT used because all the color information would be lost.
 **
 **********************************************************************************************************************/

use <../conf/derived_sizes.scad>
use <../conf/part_sizes.scad>
use <../parts/extrusions/makerslide.scad>
use <../parts/printed/foot.scad>

/**
 * Provides access to the assembly.
 */
module vertical_axis_assembly(position = [0, 0, 0], angle = 0) {
	translate(position)
		rotate([0, 0, angle])
			_vertical_axis_assembly();
}

/** 
 * The module that actually renders the assembly. 
 * This module is not intended to be called outside of this file.
 */
module _vertical_axis_assembly() {
	// the vertical MakerSlide extrusion
	makerslide_vertical_rail();
	// the lower foot with associated hardware
	foot();
	foot_hardware();
}

// render the axis to a separate output file if requested
_vertical_axis_assembly();