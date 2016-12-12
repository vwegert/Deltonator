/**********************************************************************************************************************
 **
 ** parts/sheets/enclosure_short_side.scad
 **
 ** This file generates the intransparent parts of the enclosure that mount to the vertical rails.
 ** This file is intended to be included by other files down the line.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>

use <../../parts/vitamins/vitamins.scad>

/**
 * Provides the pre-rendered plate. 
 */
module enclosure_short_side_plate() {
	bom_entry(section = "Sheet / Multiplex Plywood", 
		      description = "Enclosure Short Side Plate", 
		      size = str(enclosure_short_side_width(), " x ", enclosure_short_side_height(), " x ", enclosure_short_side_thickness(), "  mm"));
	color_enclosure_solid()
		import(file = "enclosure_short_side.stl"); 
}

/**
 * Renders a screw hole.
 */
module _enclosure_short_side_screw_hole() {
	translate([-epsilon(), 0, 0])	
		rotate([0, 90, 0])
			cylinder(d = frame_screw_size(), 
				     h = enclosure_short_side_thickness() + 2 * epsilon(), 
			     	 $fn = enclosure_hole_resolution());	
}

/**
 * Renders a screw and washer.
 */
module _enclosure_short_side_screw() {
	translate([-washer_thickness(frame_screw_size()) - epsilon(), 0, 0]) 
		washer(frame_screw_size());
	translate([-washer_thickness(frame_screw_size()) - 2 * epsilon(), 0, 0]) 
		screw(size = frame_screw_size(), length = 8 + enclosure_short_side_thickness());
	nut_tslot(frame_screw_size());	
}

/** 
 * Renders the plate. This module is not intended to be called outside of this file.
 */
module _render_enclosure_short_side_plate() {
	difference() {
		// the base plate
		translate([0, -enclosure_short_side_width()/2, 0])
			cube([enclosure_short_side_thickness(), enclosure_short_side_width(), enclosure_short_side_height()]);

		// minus the mounting holes through the foot
		translate([0, -makerslide_slot_offset(), foot_vertical_back_screw_height()])
			_enclosure_short_side_screw_hole();
		translate([0, makerslide_slot_offset(), foot_vertical_back_screw_height()])
			_enclosure_short_side_screw_hole();

		// minus the mounting holes through the motor bracket
		translate([0, -makerslide_slot_offset(), motor_bracket_screw_height()])
			_enclosure_short_side_screw_hole();
		translate([0, makerslide_slot_offset(), motor_bracket_screw_height()])
			_enclosure_short_side_screw_hole();

		// minus the mounting holes through the bed bracket
		translate([0, -makerslide_slot_offset(), bed_bracket_back_screw_height()])
			_enclosure_short_side_screw_hole();
		translate([0, makerslide_slot_offset(), bed_bracket_back_screw_height()])
			_enclosure_short_side_screw_hole();

		// minus the mounting holes through the head
		translate([0, -makerslide_slot_offset(), head_back_screw_height()])
			_enclosure_short_side_screw_hole();
		translate([0, makerslide_slot_offset(), head_back_screw_height()])
			_enclosure_short_side_screw_hole();

	}
}

/**
 * Provides the hardware to mount the plate.
 */
module enclosure_short_side_plate_hardware() {
		// the mounting screws through the foot
		translate([0, -makerslide_slot_offset(), foot_vertical_back_screw_height()])
			_enclosure_short_side_screw();
		translate([0, makerslide_slot_offset(), foot_vertical_back_screw_height()])
			_enclosure_short_side_screw();

		// the mounting screws through the motor bracket
		// translate([0, -makerslide_slot_offset(), motor_bracket_screw_height()])
		// 	_enclosure_short_side_screw();
		// translate([0, makerslide_slot_offset(), motor_bracket_screw_height()])
		// 	_enclosure_short_side_screw();

		// the mounting screws through the bed bracket
		translate([0, -makerslide_slot_offset(), bed_bracket_back_screw_height()])
			_enclosure_short_side_screw();
		translate([0, makerslide_slot_offset(), bed_bracket_back_screw_height()])
			_enclosure_short_side_screw();

		// the mounting screws through the head
		translate([0, -makerslide_slot_offset(), head_back_screw_height()])
			_enclosure_short_side_screw();
		translate([0, makerslide_slot_offset(), head_back_screw_height()])
			_enclosure_short_side_screw();
}

_render_enclosure_short_side_plate();
