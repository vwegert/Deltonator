/**********************************************************************************************************************
 **
 ** printer/printer_default.scad
 **
 ** This file constructs the default version of the entire printer - mainly for cross-checking and illustration
 ** purposes.
 **
 **********************************************************************************************************************/

use <printer.scad>

printer_model();

// dummy printer build surface - this will be relocated later on
color("Salmon")
	translate([0, 0, bed_working_height() - 5])
		cylinder(d = 330, h = 5, $fn = 96);