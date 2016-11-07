/**********************************************************************************************************************
 **
 ** lib/MCAD/stepper_nema17_medium.scad
 **
 ** This file renders a NEMA stepper motor of the dimensions specified by the file name.
 **
 **********************************************************************************************************************/

include <MCAD/stepper.scad>

$fn = 48;
rotate([0, -90, 0])
	motor(Nema17, NemaMedium, dualAxis = false);