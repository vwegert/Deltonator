/**********************************************************************************************************************
 **
 ** printer/printer.scad
 **
 ** This file contains the code that combines the various assemblies into a printer model. It is not intended
 ** to be rendered itself; instead, it is used by other files in this directory.
 **
 **********************************************************************************************************************/

use <../conf/derived_sizes.scad>
use <../assemblies/vertical_axis.scad>
use <../assemblies/horizontal_front.scad>
use <../assemblies/horizontal_left.scad>
use <../assemblies/horizontal_right.scad>

module printer_model() {

	// place the three axis assemblies
	vertical_axis_assembly(position = position_rail_a(), angle = 120);
	vertical_axis_assembly(position = position_rail_b(), angle = -120);
	vertical_axis_assembly(position = position_rail_c(), angle = 0);

	// place the horizontal parts
	horizontal_front_assembly(position = position_front_assembly(), angle = 0, with_connectors = false);
	horizontal_left_assembly(position = position_left_assembly(), angle = 60, with_connectors = false);
	horizontal_right_assembly(position = position_right_assembly(), angle = -60, with_connectors = false);


}