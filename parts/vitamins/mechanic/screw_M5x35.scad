/**********************************************************************************************************************
 **
 ** parts/vitamins/screw_M5x35.scad
 **
 ** This file renders a screw of the dimensions specified by the file name.
 **
 **********************************************************************************************************************/

include <../../lib/nutsnbolts/cyl_head_bolt.scad>;

$fn = 48;
rotate([0, -90, 0])
	screw("M5x35"); 