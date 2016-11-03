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

module printer_model() {

	// place the three axis assemblies
	vertical_axis_assembly(position = position_rail_a(), angle = 120);
	vertical_axis_assembly(position = position_rail_b(), angle = -120);
	vertical_axis_assembly(position = position_rail_c(), angle = 0);


}