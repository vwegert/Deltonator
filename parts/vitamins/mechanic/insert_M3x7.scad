/**********************************************************************************************************************
 **
 ** parts/vitamins/insert_M3x7.scad
 **
 ** This file renders a threaded insert of the dimensions specified by the file name.
 **
 **********************************************************************************************************************/

include <../../conf/part_sizes.scad>

_height = 7.0;
$fn = 48;
rotate([0, 90, 0]) {
	difference() {
		cylinder(d = insert_outer_diameter_m3(), h = _height);
		cylinder(d = insert_inner_diameter_m3(), h = _height);
	}
}
