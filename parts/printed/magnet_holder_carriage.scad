/**********************************************************************************************************************
 **
 ** parts/printed/magnet_holder_carriage.scad
 **
 ** This file constructs the holder that will hold the magnets on the upper ends of the rods. To assemble the printer, 
 ** you need six of these parts.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>
use <magnet_holder.scad>

/**
 * Main module to use the pre-rendered magnet holder. The holder is upright, its direction of motion aligned 
 * with the Z axis. It is placed so that the left back corner is aligned to the Z axis with the lower corner at the 
 * origin.
 */
module magnet_holder() {
	bom_entry(section = "Printed Parts", description = "Small Parts", size = "Top Magnet Holder");
	color_printed_magnet_holders()
		import(file = "magnet_holder_carriage.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module magnet_holder_hardware() {
	_magnet_holder_hardware(ball_clearance = magnet_holder_top_ball_clearance());
}

_render_magnet_holder(ball_clearance = magnet_holder_top_ball_clearance(), debug = false);
