/**********************************************************************************************************************
 **
 ** parts/vitamins/nut_M3.scad
 **
 ** This file renders a nut of the dimensions specified by the file name.
 **
 **********************************************************************************************************************/

include <../../lib/nutsnbolts/cyl_head_bolt.scad>;

$fn = 48;
rotate([0, -90, 0])
	nut("M3"); 