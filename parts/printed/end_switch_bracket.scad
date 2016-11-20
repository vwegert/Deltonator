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

// /**
//  * The Z position of the upper bracket - that is also the top position of the separator surface.
//  */
// function _end_switch_bracket_screw_bracket_base_z() = (bearing_f623_flange_diameter() - bearing_f623_outer_diameter())/2 + 
// 	                  end_switch_bracket_flange_width() + end_switch_bracket_separator_thickness();

// /**
//  * The Z position of the fastener nut.
//  */
// function _end_switch_bracket_screw_fastener_nut_z() = _end_switch_bracket_screw_bracket_base_z() + 
//                                              end_switch_bracket_screw_bracket_inner_height() + 
//                                              frame_wall_thickness()/3;

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
			       0, end_switch_bracket_foot_height() - switch_ss5gl_hole_bottom_distance()])
			rotate([270, 0, 0])
				cylinder(d = end_switch_bracket_screw_hole_diameter(),
					     h = end_switch_bracket_thickness(),
			    		 $fn = frame_screw_hole_resolution());
		translate([end_switch_bracket_foot_depth() - switch_ss5gl_hole_edge_distance() - switch_ss5gl_hole_distance(), 
			       0, end_switch_bracket_foot_height() - switch_ss5gl_hole_bottom_distance()])
			rotate([270, 0, 0])
				cylinder(d = end_switch_bracket_screw_hole_diameter(),
					     h = end_switch_bracket_thickness(),
			    		 $fn = frame_screw_hole_resolution());
	}
}

/**
 * Renders the upper part of the bracket that holds the nut.
 */
module _render_end_switch_bracket_upper() {

	// the vertical block
	translate([0, 0, end_switch_bracket_foot_height()]) 
		cube([end_switch_bracket_top_depth(), end_switch_bracket_thickness(), end_switch_bracket_top_height()]);

	// the horizontal block that will hold the nut
	difference() {
		translate([0, end_switch_bracket_thickness(), end_switch_bracket_total_height() - end_switch_bracket_thickness()]) 
			cube([end_switch_bracket_top_depth(), end_switch_bracket_top_depth(), end_switch_bracket_thickness()]);
		// minus the screw hole in the top plate
		translate([end_switch_bracket_top_depth()/2, 
			       end_switch_bracket_thickness() + end_switch_bracket_top_depth()/2, 
			       end_switch_bracket_total_height() - end_switch_bracket_thickness() - epsilon()])
			cylinder(d = M4, h = end_switch_bracket_thickness() + 2 * epsilon(), $fn = frame_screw_hole_resolution());
		// minus a recess to hold the screw in place
		translate([end_switch_bracket_top_depth()/2, 
			       end_switch_bracket_thickness() + end_switch_bracket_top_depth()/2, 
			       end_switch_bracket_total_height() - 2*end_switch_bracket_thickness()/3])
			rotate([0, 90, 0])
				nut_recess(M4);

	}

// function end_switch_bracket_thickness()       =  4;
// function end_switch_bracket_foot_depth()      = 20;
// function end_switch_bracket_foot_height()     = 10;
// function end_switch_bracket_screw_hole_diameter() = 1.5;

// function end_switch_bracket_top_height()      = 30;
// function end_switch_bracket_top_depth()       = 10;

// function end_switch_bracket_edge_radius()     =  2;
// function end_switch_bracket_edge_resolution() = 16;

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
 * The parameter screw_position determines how far the screw will be moved outwards - with screw_position = 0,
 * the screw and washer will lie exactly flush with the upper surface of the bracket. In reality, that will never 
 * happen - screw_position should always be at least frame_wall_thickness().
 */
module end_switch_bracket_hardware(screw_position = 15) {

	// the switch
	translate([end_switch_bracket_foot_depth() - switch_ss5gl_width() + switch_ss5gl_hole_edge_distance(), 
		       end_switch_bracket_thickness() + switch_ss5gl_thickness(), 
		       end_switch_bracket_foot_height() - switch_ss5gl_hole_bottom_distance()])
		rotate([0, 0, 270])
			switch_ss5gl();

	// the top level fastener stuff
	translate([end_switch_bracket_top_depth()/2, end_switch_bracket_thickness() + end_switch_bracket_top_depth()/2,  0]) {

		translate([0, 0, end_switch_bracket_total_height() - 2*end_switch_bracket_thickness()/3])
			rotate([0, 90, 0])
				nut(M4);
	}


}

_render_end_switch_bracket();
