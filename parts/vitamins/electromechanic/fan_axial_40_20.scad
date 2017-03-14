/**********************************************************************************************************************
 **
 ** parts/vitamins/electromechanic/fan_40_20.scad
 **
 ** This file renders a fan of 40x40 mm with a housing thickness of 20 mm.
 **
 **********************************************************************************************************************/

CORNER_RADIUS =  4.0;
SIDE_LENGTH   = 40.0;
DEPTH         = 20.0;

HOLE_DIAMETER =  4.0;
HOLE_OFFSET   =  4.0;

$fn = 48;
difference() {

	// the outer hull
	hull() {
		translate([CORNER_RADIUS, CORNER_RADIUS, 0])
			cylinder(r = CORNER_RADIUS, h = DEPTH);
		translate([SIDE_LENGTH - CORNER_RADIUS, CORNER_RADIUS, 0])
			cylinder(r = CORNER_RADIUS, h = DEPTH);
		translate([CORNER_RADIUS, SIDE_LENGTH - CORNER_RADIUS, 0])
			cylinder(r = CORNER_RADIUS, h = DEPTH);
		translate([SIDE_LENGTH - CORNER_RADIUS, SIDE_LENGTH - CORNER_RADIUS, 0])
			cylinder(r = CORNER_RADIUS, h = DEPTH);
	}

	// minus the screw holes
	translate([HOLE_OFFSET, HOLE_OFFSET, -1])
		cylinder(d = HOLE_DIAMETER, h = DEPTH + 2);
	translate([SIDE_LENGTH - HOLE_OFFSET, HOLE_OFFSET, -1])
		cylinder(d = HOLE_DIAMETER, h = DEPTH + 2);
	translate([HOLE_OFFSET, SIDE_LENGTH - HOLE_OFFSET, -1])
		cylinder(d = HOLE_DIAMETER, h = DEPTH + 2);
	translate([SIDE_LENGTH - HOLE_OFFSET, SIDE_LENGTH - HOLE_OFFSET, -1])
		cylinder(d = HOLE_DIAMETER, h = DEPTH + 2);


}

