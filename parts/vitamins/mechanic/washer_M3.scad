/**********************************************************************************************************************
 **
 ** parts/vitamins/washer_M3.scad
 **
 ** This file renders a washer of the dimensions specified by the file name.
 **
 **********************************************************************************************************************/

$fn = 48;

rotate([0, 90, 0])
	difference() {
		cylinder(d = 7.0, h = 0.5);
		cylinder(d = 3.2, h = 0.5);
	}