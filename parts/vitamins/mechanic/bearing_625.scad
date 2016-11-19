/**********************************************************************************************************************
 **
 ** parts/vitamins/bearing_625.scad
 **
 ** This file renders a ball bearing of the size specified by the file name.
 **
 **********************************************************************************************************************/

include <../../lib/MCAD/bearing.scad>

$fn = 96;
rotate([0, 90, 0])
	bearing(model = 625);