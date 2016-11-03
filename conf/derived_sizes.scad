/**********************************************************************************************************************
 **
 ** conf/derived_sizes.scad
 **
 ** This file contains functions that calculate various dimensions of the printer. Note that sizes that are only 
 ** relevant for specific parts are calculated in the corresponding part files directly.
 **
 **********************************************************************************************************************/

include <printer_config.scad>

// ===== PRINTER FRAME SIZES ===========================================================================================

/**
 * The length of the vertical MakerSlide extrusions.
 */
function vertical_extrusion_length() = FRAME_V_RAIL_HEIGHT;

/**
 * The length of the horizontal 20x20 V-Slot extrusions.
 */
function horizontal_extrusion_length() = FRAME_H_RAIL_LENGTH;

/**
 * The offset of the horizontal V-Slot extrusions from the logical crossing point of the sides of the center triangle
 * (that is, from the center of the outer side of the MakerSlide rail).
 * Changing this value will affect the thickness of the material between the rails, so:
 * TODO: reverse this to have the offset calculated from the target material thickness.
 */
function horizontal_extrusion_offset() = 40;

/**
 * The overall size of the base triangle - from one crossing point to the next.
 */
function horizontal_base_length() = horizontal_extrusion_length() + 2 * horizontal_extrusion_offset();

// ===== PART PLACEMENT ================================================================================================

function position_rail_a() = [
	sqrt(pow(horizontal_base_length(), 2) - pow(horizontal_base_length() / 2, 2)), 
	-horizontal_base_length() / 2,
	0
];

function position_rail_b() = [
	sqrt(pow(horizontal_base_length(), 2) - pow(horizontal_base_length() / 2, 2)), 
	horizontal_base_length() / 2, 
	0
];

function position_rail_c() = [0, 0, 0];

function position_front_assembly() = [ 
	sqrt(pow(horizontal_base_length(), 2) - pow(horizontal_base_length() / 2, 2)) + 20, // vslot_width(), 
	-horizontal_extrusion_length()/2, 
	0 
];

// TODO determine the exact rail positions
function position_left_assembly() = [ 0, 0, 0 ];
// TODO determine the exact rail positions
function position_right_assembly() = [ 0, 0, 0 ];