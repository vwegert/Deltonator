/**********************************************************************************************************************
 **
 ** parts/printed/effector_dummy.scad
 **
 ** This file constructs a sample effector that consists of nothing but the base plate.
 ** This part is might be printed for calibration and testing purposes.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

use <effector_base.scad>

/**
 * Creates the effector base assembly by rendering it from scratch. This module is not to be called externally, use 
 * effector_dummy() instead.
 */
module _render_effector_dummy() {
	effector_base();
}

/**
 * Main module to use the pre-rendered dummy effector. The assembly is centered at the origin. Since this version is
 * not supposed to be printed, no BOM entry is generated.
 */
module effector_dummy() {
	color_printed_effector()
		import(file = "effector_dummy.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module effector_dummy_hardware() {
	effector_base_hardware();
}

/**
 * Renders a placeholder to indicate the location of an assumed tool mounted in the center of the effector.
 */
module effector_dummy_tool() {
	#rotate_extrude()
		polygon(points = [
			[0, 0],
			[0, -effector_tool_height()],
			[-effector_tool_height()/2, 0]
		]);
}

_render_effector_dummy();
