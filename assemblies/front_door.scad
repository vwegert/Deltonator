/**********************************************************************************************************************
 **
 ** assemblies/front_door.scad
 **
 ** This file renders and provides the front door.
 ** This assembly can be rendered into an STL file; however, for further construction of the model, that rendered
 ** version is NOT used because all the color information would be lost.
 **
 **********************************************************************************************************************/

include <../conf/colors.scad>
include <../conf/derived_sizes.scad>
include <../conf/part_sizes.scad>

use <../bom/bom.scad>

use <../parts/sheets/enclosure_door_inner_horizontal.scad>
use <../parts/sheets/enclosure_door_inner_vertical.scad>
use <../parts/sheets/enclosure_door_outer_horizontal.scad>
use <../parts/sheets/enclosure_door_outer_vertical.scad>

use <../parts/vitamins/vitamins.scad>

/**
 * Provides access to the assembly.
 */
module front_door_assembly() {
	translate([2 * enclosure_door_wood_thickness(), enclosure_door_width() / 2, 0])
		rotate([0, 0, 180])
			_front_door_assembly();
}

/** 
 * The module that actually renders the assembly. 
 * This module is not intended to be called outside of this file.
 */
module _front_door_assembly() {
	// the inner frame
	enclosure_door_inner_horizontal_plate();
	translate([0, 0, enclosure_door_inner_horizontal_part_size()[2] + enclosure_glass_height()])
		enclosure_door_inner_horizontal_plate();
	translate([0, 0, enclosure_door_inner_horizontal_part_size()[2]])
		enclosure_door_inner_vertical_plate();
	translate([0, enclosure_door_width() - enclosure_door_inner_vertical_part_size()[1], enclosure_door_inner_horizontal_part_size()[2]])
		enclosure_door_inner_vertical_plate();

	// the glass pane
	translate([enclosure_door_wood_thickness() - enclosure_door_glass_thickness(), 
		       enclosure_door_inner_vertical_part_size()[1], 
		       enclosure_door_inner_horizontal_part_size()[2]])
		#cube([enclosure_door_glass_thickness(), enclosure_glass_width(), enclosure_glass_height()]);

	// the outer frame
	translate([enclosure_door_wood_thickness(), 0, 0]) {
		translate([0, enclosure_door_outer_vertical_part_size()[1], 0])
			enclosure_door_outer_horizontal_plate();
		translate([0, enclosure_door_outer_vertical_part_size()[1], enclosure_door_outer_horizontal_part_size()[2] + enclosure_window_height()])
			enclosure_door_outer_horizontal_plate();
		enclosure_door_outer_vertical_plate();
		translate([0, enclosure_door_width() - enclosure_door_outer_vertical_part_size()[1], 0])
			enclosure_door_outer_vertical_plate();

	}

}

// render the assembly to a separate output file if requested
_front_door_assembly();