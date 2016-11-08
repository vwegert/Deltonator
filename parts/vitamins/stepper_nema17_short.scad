/**********************************************************************************************************************
 **
 ** parts/vitamins/stepper_nema17_short.scad
 **
 ** This file renders a NEMA stepper motor of the dimensions specified by the file name.
 **
 **********************************************************************************************************************/

include <../../lib/MCAD/stepper.scad>

$fn = 48;
translate([lookup(NemaRoundExtrusionHeight, Nema17)/2, 0, 0])
	rotate([0, -90, 0])
		motor(Nema17, NemaShort, dualAxis = false);