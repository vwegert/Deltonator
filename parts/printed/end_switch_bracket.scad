/**********************************************************************************************************************
 **
 ** parts/printed/end_switch_bracket.scad
 **
 ** This file constructs the bracket that will hold the end switch against the head part. To assemble the printer, you 
 ** need three of these parts.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

/**
 * Renders the lower part of the bracket that holds the switch.
 */
module _render_end_switch_bracket_lower() {
	difference() {
		hull() {
			// lower front edge
			translate([end_switch_bracket_foot_depth() - end_switch_bracket_edge_radius(),
				       0, end_switch_bracket_edge_radius()])
				rotate([270, 0, 0])
					cylinder(r = end_switch_bracket_edge_radius(), 
						     h = end_switch_bracket_thickness(),
				    		 $fn = end_switch_bracket_edge_resolution());
			// upper front edge
			translate([end_switch_bracket_foot_depth() - end_switch_bracket_edge_radius(),
				       0, end_switch_bracket_foot_height() - end_switch_bracket_edge_radius()])
				cube([end_switch_bracket_edge_radius(), end_switch_bracket_thickness(), end_switch_bracket_edge_radius()]);
			// lower back edge
			translate([end_switch_bracket_edge_radius(),
				       0, end_switch_bracket_edge_radius()])
				rotate([270, 0, 0])
					cylinder(r = end_switch_bracket_edge_radius(), 
						     h = end_switch_bracket_thickness(),
				    		 $fn = end_switch_bracket_edge_resolution());
			// upper back edge
			translate([0, 0, end_switch_bracket_foot_height() - end_switch_bracket_edge_radius()])
				cube([end_switch_bracket_edge_radius(), end_switch_bracket_thickness(), end_switch_bracket_edge_radius()]);
		}
		// minus the screw holes to attach the switch
		translate([end_switch_bracket_foot_depth() - switch_ss5gl_hole_edge_distance(), 
			       0, end_switch_bracket_foot_height() - switch_ss5gl_hole_bottom_distance()]) {
			rotate([270, 0, 0]) 
				cylinder(d = end_switch_bracket_screw_hole_diameter(),
					     h = end_switch_bracket_thickness(),
			    		 $fn = frame_screw_hole_resolution());
		}
		translate([end_switch_bracket_foot_depth() - switch_ss5gl_hole_edge_distance() - switch_ss5gl_hole_distance(), 
			       0, end_switch_bracket_foot_height() - switch_ss5gl_hole_bottom_distance()]) {
			rotate([270, 0, 0])
				cylinder(d = end_switch_bracket_screw_hole_diameter(),
					     h = end_switch_bracket_thickness(),
			    		 $fn = frame_screw_hole_resolution());
		}
	}
}

/**
 * Renders the upper part of the bracket that holds the nut.
 */
module _render_end_switch_bracket_upper() {

	difference() {
		union() {
			// the vertical block
			translate([0, 0, end_switch_bracket_foot_height()]) 
				cube([end_switch_bracket_top_depth(), end_switch_bracket_thickness(), end_switch_bracket_top_height()]);
			// the horizontal block that will hold the nut
			translate([0, 0, end_switch_bracket_total_height() - end_switch_bracket_top_nutcatch_height()]) 
				cube([end_switch_bracket_top_depth(), end_switch_bracket_top_width(), end_switch_bracket_top_nutcatch_height()]);
		}				
		// minus the vertical screw hole
		translate([end_switch_bracket_top_depth()/2, 
			       end_switch_bracket_top_width()/2, 
			       end_switch_bracket_total_height() - end_switch_bracket_top_nutcatch_height() - epsilon()])
			cylinder(d = tap_base_diameter(M3), h = end_switch_bracket_top_nutcatch_height() + 2 * epsilon(), $fn = frame_screw_hole_resolution());
	
	}
}

/**
 * Creates the end switch bracket assembly by rendering it from scratch. This module is not to be called externally, use 
 * end_switch_bracket() instead.
 */
module _render_end_switch_bracket() {
	color_printed_head_parts()
		render() {
			// the lower part of the bracket that holds the switch
			_render_end_switch_bracket_lower();
			// the upper part that holds the nut
			_render_end_switch_bracket_upper();
		} 
}

/**
 * Main module to use the pre-rendered end switch bracket. The bracket is upright, its direction of motion aligned 
 * with the Z axis. It is placed so that the left back corner is aligned to the Z axis with the lower corner at the 
 * origin.
 */
module end_switch_bracket() {
	bom_entry(section = "Printed Parts", description = "Small Parts", size = "End Switch Bracket");
	color_printed_head_parts()
		import(file = "end_switch_bracket.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module end_switch_bracket_hardware() {

	// the switch
	translate([end_switch_bracket_foot_depth() - switch_ss5gl_width() + switch_ss5gl_hole_edge_distance(), 
		       end_switch_bracket_thickness() + switch_ss5gl_thickness(), 
		       end_switch_bracket_foot_height() - switch_ss5gl_hole_bottom_distance()])
		rotate([0, 0, 270])
			switch_ss5gl();

	// the screws to hold the switch
	_screw_length = switch_ss5gl_thickness() + end_switch_bracket_thickness() - nut_thickness(M2)/2;
	translate([end_switch_bracket_foot_depth() - switch_ss5gl_hole_edge_distance(), 
		       end_switch_bracket_thickness() + switch_ss5gl_thickness(), 
		       end_switch_bracket_foot_height() - switch_ss5gl_hole_bottom_distance()]) 
		rotate([90, 0, 270])
			screw(size = M2, min_length = _screw_length);
	translate([end_switch_bracket_foot_depth() - switch_ss5gl_hole_edge_distance() - switch_ss5gl_hole_distance(), 
		       end_switch_bracket_thickness() + switch_ss5gl_thickness(), 
		       end_switch_bracket_foot_height() - switch_ss5gl_hole_bottom_distance()]) 
		rotate([90, 0, 270])
			screw(size = M2, min_length = _screw_length);

	// the top level fastener stuff
	translate([end_switch_bracket_top_depth()/2, end_switch_bracket_top_width()/2, 0]) {

		// the screw
		translate([0, 0, end_switch_bracket_total_height() + end_switch_bracket_spring_height() + 
			             frame_wall_thickness() + washer_thickness(M3) + 2*epsilon()])
			rotate([0, 90, 0])
				screw(size = M3, length = end_switch_bracket_screw_length());

		// the washer on top
		translate([0, 0, end_switch_bracket_total_height() + end_switch_bracket_spring_height() + 
			             frame_wall_thickness() + washer_thickness(M3) + epsilon()])
			rotate([0, 90, 0])
				washer(M3);

	 	// the spring above the bracket
		translate([0, 0, end_switch_bracket_total_height() + epsilon()])
			spring(inner_diameter = 5, length = end_switch_bracket_spring_height());

	}
}

_render_end_switch_bracket();
