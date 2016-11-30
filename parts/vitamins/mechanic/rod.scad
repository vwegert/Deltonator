/**********************************************************************************************************************
 **
 ** parts/vitamins/mechanic/rod.scad
 **
 ** This file renders a carbon fiber rod used for the arms.
 **
 **********************************************************************************************************************/

include <../../../conf/part_sizes.scad>
include <../../../conf/derived_sizes.scad>

$fn = 96; 
difference() {
	cylinder(d = rod_outer_diameter(), h = arm_rod_length());
	translate([0, 0, -epsilon()])
		cylinder(d = rod_inner_diameter(), h = arm_rod_length() + 2 * epsilon());
}