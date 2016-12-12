/**********************************************************************************************************************
 **
 ** parts/printed/enclosure_side_bracket.scad
 **
 ** This file constructs the bracket that holds the sides of the enclosure. To assemble the printer, eight of these 
 ** are required
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/extrusions/makerslide.scad>
use <../../parts/extrusions/vslot_2020.scad>
use <../../parts/vitamins/vitamins.scad>

/**
 * Renders the bracket body without the holes and recesses.
 */
module _enclosure_side_bracket_body() {
	union() {
		// the left foot
		translate([0, -encosure_bracket_total_width()/2, 0])
			cube([enclosure_bracket_thickness(), enclosure_bracket_foot_width(), enclosure_bracket_height()]);

		// the right foot
		translate([0, encosure_bracket_total_width()/2 - enclosure_bracket_foot_width(), 0])
			cube([enclosure_bracket_thickness(), enclosure_bracket_foot_width(), enclosure_bracket_height()]);

		// the left wall
		translate([0, -enclosure_bracket_body_width()/2, 0])
			cube([enclosure_bracket_depth(), enclosure_bracket_thickness(), enclosure_bracket_height()]);
	
		// the right wall
		translate([0, enclosure_bracket_body_width()/2 - enclosure_bracket_thickness(), 0])
			cube([enclosure_bracket_depth(), enclosure_bracket_thickness(), enclosure_bracket_height()]);
	
		// the front wall
		translate([enclosure_bracket_depth() - enclosure_bracket_thickness(),
			       -(enclosure_bracket_body_width() - enclosure_bracket_thickness()) / 2])
			cube([enclosure_bracket_thickness(), 
				  enclosure_bracket_body_width() - enclosure_bracket_thickness(),
				  enclosure_bracket_height()]);
	}
}

/**
 * Creates the bracket assembly by rendering it from scratch. This module is not to be called externally, use 
 * enclosure_side_bracket() instead.
 */
module _render_enclosure_side_bracket() {
	color_printed_inner_frame()
		render() {
			difference() {
				// the body of the bracket
				_enclosure_side_bracket_body();

				// minus the screw hole in the left foot
				translate([-epsilon(), 
					       -encosure_bracket_total_width()/2 + enclosure_bracket_foot_width()/2,
					       enclosure_bracket_height()/2])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), 
							     h = enclosure_bracket_thickness() + 2 * epsilon(),
							     $fn = enclosure_bracket_resolution());

				// minus the screw hole in the right foot
				translate([-epsilon(), 
					       encosure_bracket_total_width()/2 - enclosure_bracket_foot_width()/2,
					       enclosure_bracket_height()/2])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), 
							     h = enclosure_bracket_thickness() + 2 * epsilon(),
							     $fn = enclosure_bracket_resolution());

				// minus the left screw hole in the bracket center
				translate([enclosure_bracket_depth() - enclosure_bracket_thickness() - epsilon(), 
					       -enclosure_bracket_screw_distance()/2,
					       enclosure_bracket_height()/2])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), 
							     h = enclosure_bracket_thickness() + 2 * epsilon(),
							     $fn = enclosure_bracket_resolution());

				// minus the right screw hole in the bracket center
				translate([enclosure_bracket_depth() - enclosure_bracket_thickness() - epsilon(), 
					       enclosure_bracket_screw_distance()/2,
					       enclosure_bracket_height()/2])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), 
							     h = enclosure_bracket_thickness() + 2 * epsilon(),
							     $fn = enclosure_bracket_resolution());

				// minus a recess for the inner nut on the left-hand side
				translate([enclosure_bracket_depth() - enclosure_bracket_thickness() - epsilon(), 
					       -enclosure_bracket_screw_distance()/2,
					       enclosure_bracket_height()/2])
						nut_recess(size = frame_screw_size());

				// minus a recess for the outer nut on the right-hand side
				translate([enclosure_bracket_depth() - nut_thickness(frame_screw_size()) + epsilon(), 
					       enclosure_bracket_screw_distance()/2,
					       enclosure_bracket_height()/2])
						nut_recess(size = frame_screw_size());
			}
		} 
}

/**
 * Main module to use the pre-rendered bracket. If rotated i
 */
module enclosure_side_bracket(right_side = false) {
	bom_entry(section = "Printed Parts", description = "Enclosure", size = "Side Bracket");
	color_printed_outer_frame() {
		if (right_side) {
			translate([0, 0, enclosure_bracket_height()])
				rotate([180, 0, 0])
					import(file = "enclosure_side_bracket.stl");
		} else {
			import(file = "enclosure_side_bracket.stl");
		}
	}
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module _enclosure_side_bracket_hardware(nut_left = false, nut_right = false) {

	// the washer and screw on the left-hand side
	translate([enclosure_bracket_thickness(), 
		       -encosure_bracket_total_width()/2 + enclosure_bracket_foot_width()/2,
			   enclosure_bracket_height()/2]) {
		translate([epsilon(), 0, 0])
			washer(size = frame_screw_size());
		translate([2 * epsilon() + washer_thickness(frame_screw_size())]) 
			rotate([0, 180, 0])
				screw(size = frame_screw_size(), length = 12);
	}

	// the washer and screw on the right-hand side
	translate([enclosure_bracket_thickness(), 
		       encosure_bracket_total_width()/2 - enclosure_bracket_foot_width()/2,
			   enclosure_bracket_height()/2]) {
		translate([epsilon(), 0, 0])
			washer(size = frame_screw_size());
		translate([2 * epsilon() + washer_thickness(frame_screw_size())]) 
			rotate([0, 180, 0])
				screw(size = frame_screw_size(), length = 12);
	}

	// the inner nut on the left-hand side
	if (nut_left) {
		translate([enclosure_bracket_depth() - enclosure_bracket_thickness() - epsilon(), 
			       -enclosure_bracket_screw_distance()/2,
			       enclosure_bracket_height()/2])
				nut(size = frame_screw_size());
	}

	// the outer nut on the right-hand side
	if (nut_right) {
		translate([enclosure_bracket_depth() - nut_thickness(frame_screw_size()) + epsilon(), 
			       enclosure_bracket_screw_distance()/2,
			       enclosure_bracket_height()/2])
				nut(size = frame_screw_size());
	}

}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module enclosure_side_bracket_hardware(right_side = false, nut_left = false, nut_right = false) {
	if (right_side) {
		translate([0, 0, enclosure_bracket_height()])
			rotate([180, 0, 0])
				_enclosure_side_bracket_hardware(nut_left = nut_left, nut_right = nut_right);
	} else {
		_enclosure_side_bracket_hardware(nut_left = nut_left, nut_right = nut_right);
	}
}

_render_enclosure_side_bracket();
