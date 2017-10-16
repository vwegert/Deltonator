/**********************************************************************************************************************
 **
 ** parts/vitamins/electronic/power_supply.scad
 **
 ** This file renders a power supply case placeholder.
 **
 **********************************************************************************************************************/

include <../../../conf/part_sizes.scad>

$fn = 48;

screw_offset_x = (ps_width() - ps_screw_distance_width()) / 2;
screw_left_x   = screw_offset_x;
screw_right_x  = ps_width() - screw_offset_x;
screw_offset_y = (ps_length() - ps_screw_distance_length()) / 2;
screw_near_y   = screw_offset_y;
screw_far_y    = ps_length() - screw_offset_y;

color("LightGray")
	difference() {
		// the body
		cube([ps_width(), ps_length(), ps_height()]);
		// minus the screw holes
		translate([screw_left_x, screw_near_y, -epsilon()])
			cylinder(d = ps_screw_size(), h = ps_screw_max_depth());
		translate([screw_right_x, screw_near_y, -epsilon()])
			cylinder(d = ps_screw_size(), h = ps_screw_max_depth());
		translate([screw_left_x, screw_far_y, -epsilon()])
			cylinder(d = ps_screw_size(), h = ps_screw_max_depth());
		translate([screw_right_x, screw_far_y, -epsilon()])
			cylinder(d = ps_screw_size(), h = ps_screw_max_depth());
	}
