/**********************************************************************************************************************
 **
 ** parts/vitamins/mechanic/rail_bracket.scad
 **
 ** This file renders an - probably aluminium - 90° bracket that is used to combine 2020 rails.
 **
 **********************************************************************************************************************/

include <../../../conf/part_sizes.scad>

$fn = 96;

// Normally, these brackets have alignment tabs - we don't need these. (In fact, you would have to remove them
// in some places.)

union() {
	// the left side plate
	translate([0, -rail_bracket_width()/2 + rail_bracket_side_wall_thickness(), 0])
		side_plate();
	// the right side plate
	translate([0, rail_bracket_width()/2, 0])
		side_plate();
	// the bottom face plate
	translate([0, -rail_bracket_width()/2, 0])
		face_plate();
	// the back side face plate
	translate([rail_bracket_outer_wall_thickness(), -rail_bracket_width()/2, 0])
		rotate([0, 270, 0])
			face_plate();
}

module side_plate() {
	rotate([90, 0, 0])
		linear_extrude(height = rail_bracket_side_wall_thickness()) 
			polygon(points = [
				[0, 0],
				[rail_bracket_side_length(), 0],
				[rail_bracket_side_length(), rail_bracket_outer_wall_thickness()],
				[rail_bracket_outer_wall_thickness(), rail_bracket_side_length()],
				[0, rail_bracket_side_length()]
			]);
}

module face_plate() {
	difference() {
		cube([rail_bracket_side_length(), rail_bracket_width(), rail_bracket_outer_wall_thickness()]);
		hull() {
			translate([rail_bracket_hole_corner_offset() + rail_bracket_hole_width()/2, rail_bracket_width()/2, -1])
				cylinder(d = rail_bracket_hole_width(), h = rail_bracket_outer_wall_thickness()+2);
			translate([rail_bracket_hole_corner_offset() + rail_bracket_hole_length() - rail_bracket_hole_width()/2, rail_bracket_width()/2, -1])
				cylinder(d = rail_bracket_hole_width(), h = rail_bracket_outer_wall_thickness()+2);
		}
	}
}

