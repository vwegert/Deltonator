/**********************************************************************************************************************
 **
 ** parts/sheets/enclosure_door_inner_horizontal.scad
 **
 ** This file generates the intransparent parts of the enclosure that are mounted opposite to the A and B rails.
 ** This file is intended to be included by other files down the line.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>

use <../../parts/vitamins/vitamins.scad>

/**
 * Provides the pre-rendered plate. 
 */
module enclosure_door_inner_horizontal_plate() {
	bom_entry(section = "Sheet / Multiplex Plywood", 
		      description = "Enclosure Door: Inner Horizontal Plate", 
		      size = str(enclosure_door_inner_horizontal_part_size()));
	color_enclosure_solid()
		import(file = "enclosure_door_inner_horizontal.stl"); 
}

/** 
 * Renders the plate. This module is not intended to be called outside of this file.
 */
module _render_enclosure_door_inner_horizontal_plate() {
	cube(enclosure_door_inner_horizontal_part_size());
}

_render_enclosure_door_inner_horizontal_plate();
