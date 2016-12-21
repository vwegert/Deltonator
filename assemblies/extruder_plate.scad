/**********************************************************************************************************************
 **
 ** assemblies/extruder_plate.scad
 **
 ** This file renders and provides the plate that holds the extruders with everything mounted on top.
 ** This assembly can be rendered into an STL file; however, for further construction of the model, that rendered
 ** version is NOT used because all the color information would be lost.
 **
 **********************************************************************************************************************/

include <../conf/colors.scad>
include <../conf/derived_sizes.scad>
include <../conf/part_sizes.scad>

use <../bom/bom.scad>

use <../parts/vitamins/vitamins.scad>

/**
 * Provides access to the assembly.
 */
module extruder_plate_assembly() {
}

/** 
 * The module that actually renders the assembly. 
 * This module is not intended to be called outside of this file.
 */
module _extruder_plate_assembly() {
	_extruder_assembly();
}

/**
 * Provides a single extruder assembly (bracket, motor extruder, mounting material).
 */
module _extruder_assembly() {

	// the bracket
	extruder_mount();

	// the stepper motor on one side
	translate([extruder_mount_thickness(), emotor_width() / 2, extruder_mount_motor_length() - emotor_height() / 2]) 
		rotate([0, 0, 180])
			stepper_medium(emotor_size());

	
}

// render the assembly to a separate output file if requested
_extruder_plate_assembly();