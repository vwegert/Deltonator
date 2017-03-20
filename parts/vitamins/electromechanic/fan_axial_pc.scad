/**********************************************************************************************************************
 **
 ** parts/vitamins/electromechanic/fan_axial_pc.scad
 **
 ** This file renders an axial fan for part cooling.
 **
 **********************************************************************************************************************/

include <../../../conf/part_sizes.scad>

$fn = 48;
difference() {

	// the outer hull
	hull() {
		translate([pc_fan_corner_radius(), pc_fan_corner_radius(), 0])
			cylinder(r = pc_fan_corner_radius(), h = pc_fan_depth());
		translate([pc_fan_side_length() - pc_fan_corner_radius(), pc_fan_corner_radius(), 0])
			cylinder(r = pc_fan_corner_radius(), h = pc_fan_depth());
		translate([pc_fan_corner_radius(), pc_fan_side_length() - pc_fan_corner_radius(), 0])
			cylinder(r = pc_fan_corner_radius(), h = pc_fan_depth());
		translate([pc_fan_side_length() - pc_fan_corner_radius(), pc_fan_side_length() - pc_fan_corner_radius(), 0])
			cylinder(r = pc_fan_corner_radius(), h = pc_fan_depth());
	}

	// minus the screw holes
	translate([pc_fan_hole_offset(), pc_fan_hole_offset(), -1])
		cylinder(d = pc_fan_hole_diameter(), h = pc_fan_depth() + 2);
	translate([pc_fan_side_length() - pc_fan_hole_offset(), pc_fan_hole_offset(), -1])
		cylinder(d = pc_fan_hole_diameter(), h = pc_fan_depth() + 2);
	translate([pc_fan_hole_offset(), pc_fan_side_length() - pc_fan_hole_offset(), -1])
		cylinder(d = pc_fan_hole_diameter(), h = pc_fan_depth() + 2);
	translate([pc_fan_side_length() - pc_fan_hole_offset(), pc_fan_side_length() - pc_fan_hole_offset(), -1])
		cylinder(d = pc_fan_hole_diameter(), h = pc_fan_depth() + 2);
}

