/**********************************************************************************************************************
 **
 ** lib/nutsnbolts/screw_M3x6.scad
 **
 ** This file renders a screw of the dimensions specified by the file name.
 **
 **********************************************************************************************************************/

include <nutsnbolts/cyl_head_bolt.scad>;

$fn = 48;
rotate([0, -90, 0])
	screw("M3x6"); 