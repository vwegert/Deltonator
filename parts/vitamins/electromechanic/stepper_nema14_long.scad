/**********************************************************************************************************************
 **
 ** parts/vitamins/stepper_nema14_long.scad
 **
 ** This file renders a NEMA stepper motor of the dimensions specified by the file name.
 **
 **********************************************************************************************************************/

include <../../../lib/MCAD/stepper.scad>

$fn = 48;
translate([lookup(NemaRoundExtrusionHeight, Nema14), 0, 0])
	rotate([0, -90, 0])
		motor(Nema14, NemaLong, dualAxis = false);