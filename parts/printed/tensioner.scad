/**********************************************************************************************************************
 **
 ** parts/printed/tensioner.scad
 **
 ** This file constructs the tensioner that will hold the upper idler for the belts. To assemble the printer, you 
 ** need three of these parts.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

/**
 * The Z position of the upper bracket - that is also the top position of the separator surface.
 */
function _tensioner_screw_bracket_base_z() = (bearing_f623_flange_diameter() - bearing_f623_outer_diameter())/2 + 
	                  tensioner_flange_width() + tensioner_separator_thickness();

/**
 * The Z position of the fastener nut.
 */
function _tensioner_screw_fastener_nut_z() = _tensioner_screw_bracket_base_z() + 
                                             tensioner_screw_bracket_inner_height() + 
                                             frame_wall_thickness()/3;

/**
 * Creates the lower part of the tensioner that holds the idler.
 */
module _tensioner_idler_bracket() {
	_base_height = tensioner_width() + tensioner_separator_thickness();
	difference() {
		// the block of the base
		translate([-tensioner_depth()/2, -tensioner_width()/2, -(tensioner_width() - tensioner_idler_z_offset())])
			cube([tensioner_depth(), tensioner_width(), _base_height]);
		// minus the space where the idler sits
		translate([-tensioner_idler_gap_depth()/2,
		           -tensioner_width()/2, 
				   -(tensioner_width() - tensioner_idler_z_offset())])
			cube([tensioner_idler_gap_depth(), tensioner_width(), tensioner_width()]);
		// minus the hole to mount the idler
		translate([-tensioner_depth()/2 - epsilon(), 0, -bearing_f623_outer_diameter()/2])
			rotate([0, 90, 0])
				cylinder(d = M3, h = tensioner_depth() + 2 * epsilon(), $fn = frame_screw_hole_resolution());
	}
}

/**
 * Creates the upper part of the tensioner that holds the vertical screw.
 */
module _tensioner_screw_bracket() {
	difference() {
		union() {
			// the "front" wall
			translate([tensioner_depth()/2 - frame_wall_thickness(), -tensioner_width()/2, _tensioner_screw_bracket_base_z()])
				cube([frame_wall_thickness(), tensioner_width(), tensioner_screw_bracket_inner_height()]);
			// the "back" wall
			translate([-tensioner_depth()/2, -tensioner_width()/2, _tensioner_screw_bracket_base_z()])
				cube([frame_wall_thickness(), tensioner_width(), tensioner_screw_bracket_inner_height()]);
			// the top plate
			translate([-tensioner_depth()/2, -tensioner_width()/2, _tensioner_screw_bracket_base_z() + tensioner_screw_bracket_inner_height()])
				cube([tensioner_depth(), tensioner_width(), frame_wall_thickness()]);
		}
		// minus the screw hole in the top plate
		translate([0, 0, _tensioner_screw_bracket_base_z() + tensioner_screw_bracket_inner_height() - epsilon()])
			cylinder(d = M4, h = frame_wall_thickness() + 2 * epsilon(), $fn = frame_screw_hole_resolution());
		// minus a recess to hold the screw in place
		translate([0, 0, _tensioner_screw_fastener_nut_z()])
			rotate([0, 90, 0])
				nut_recess(M4);
	}
}

/**
 * Creates the tensioner assembly by rendering it from scratch. This module is not to be called externally, use 
 * tensioner() instead.
 */
module _render_tensioner() {
	color_printed_tensioner()
		render() {
			// the lower part that holds the idler
			_tensioner_idler_bracket();
			// the upper part that holds the vertical screw
			_tensioner_screw_bracket();
		} 
}

/**
 * Main module to use the pre-rendered tensioner. The tensioner is upright, its direction of motion aligned with the 
 * Z axis. It is placed so that the upper center of the idler surface is aligned with the origin, the axle pointing 
 * along the X axis.
 */
module tensioner() {
	bom_entry(section = "Printed Parts", description = "Small Parts", size = "Belt Tensioner");
	color_printed_tensioner()
		import(file = "tensioner.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 * The parameter screw_position determines how far the screw will be moved outwards - with screw_position = 0,
 * the screw and washer will lie exactly flush with the upper surface of the tensioner. In reality, that will never 
 * happen - screw_position should always be at least frame_wall_thickness().
 */
module tensioner_hardware(screw_position = 15) {

	// the idler parts
	translate([0, 0, -bearing_f623_outer_diameter()/2]) {

		_screw_length = 2 * bearing_f623_width() +
		                4 * washer_thickness(M3) +
	    	            2 * frame_wall_thickness() + 
	        	        nut_thickness(M3);

		// the two ball bearings that make up the idler
		translate([-bearing_f623_width(), 0, 0])
			bearing(size = "F623");
		translate([bearing_f623_width(), 0, 0])
			rotate([0, 0, 180])
				bearing(size = "F623");

		// a washer on either side
		translate([-bearing_f623_width() - epsilon() - washer_thickness(M3), 0, 0])
			washer(M3);	
		translate([bearing_f623_width() + epsilon(), 0, 0])
			washer(M3);

		// the washers on the outer side of the printed part
		translate([-bearing_f623_width() - epsilon() - 
			       washer_thickness(M3) - epsilon() - 
			       frame_wall_thickness() - epsilon() - washer_thickness(M3), 0, 0])
			washer(M3);	
		translate([bearing_f623_width() + epsilon() +
			       washer_thickness(M3) + epsilon() + 
			       frame_wall_thickness() + epsilon(), 0, 0])
			washer(M3);	

		// the screw (front to back in this case)
		translate([bearing_f623_width() + epsilon() + 
			       washer_thickness(M3) + epsilon() + 
			       frame_wall_thickness() + epsilon() + washer_thickness(M3), 0, 0])
			rotate([0, 0, 180])
				screw(size = M3, min_length = _screw_length);

		// the nut to hold it 				
		translate([-bearing_f623_width() - epsilon() - 
			       washer_thickness(M3) - epsilon() - 
			       frame_wall_thickness() - epsilon() - 
			       washer_thickness(M3) - epsilon() - nut_thickness(M3), 0, 0])
			nut(M3);	
	}

	// the vertical screw parts

	// the fastener nut: fixed position
	translate([0, 0, _tensioner_screw_fastener_nut_z()])
		rotate([0, 90, 0])
			nut(M4);

	// the screw: variable position
	translate([0, 0, screw_position]) {
		_screw_base_z = _tensioner_screw_bracket_base_z() + tensioner_screw_bracket_inner_height() + frame_wall_thickness() + epsilon();
		translate([0, 0, _screw_base_z + epsilon() + washer_thickness(M4)])
			rotate([0, 90, 0])
				washer(size = M4);
		translate([0, 0, _screw_base_z + epsilon() + washer_thickness(M4) + epsilon()])
			rotate([0, 90, 0])
				screw(size = M4, length = tensioner_vertical_screw_length());
	}


}

_render_tensioner();
echo(tensioner_vertical_screw_min_length = tensioner_vertical_screw_min_length());
echo(tensioner_vertical_screw_length = tensioner_vertical_screw_length());
echo(tensioner_screw_bracket_inner_height = tensioner_screw_bracket_inner_height());
