/**********************************************************************************************************************
 **
 ** parts/sheets/enclosure_long_side.scad
 **
 ** This file generates the intransparent parts of the enclosure that are mounted opposite to the A and B rails.
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
module enclosure_long_side_plate() {
	bom_entry(section = "Sheet / Multiplex Plywood", 
		      description = "Enclosure Long Side Plate", 
		      size = str(enclosure_long_side_width(), " x ", enclosure_long_side_height(), " x ", enclosure_long_side_thickness(), "  mm"));
	color_enclosure_solid()
		import(file = "enclosure_long_side.stl"); 
}

/**
 * Renders a screw hole.
 */
module _enclosure_long_side_screw_hole() {
	translate([-epsilon(), 0, 0])	
		rotate([0, 90, 0])
			cylinder(d = frame_screw_size(), 
				     h = enclosure_long_side_thickness() + 2 * epsilon(), 
			     	 $fn = enclosure_hole_resolution());	
}

/**
 * Renders a screw and washer.
 */
module _enclosure_long_side_screw() {
	translate([-washer_thickness(frame_screw_size()) - epsilon(), 0, 0]) 
		washer(frame_screw_size());
	translate([-washer_thickness(frame_screw_size()) - 2 * epsilon(), 0, 0]) 
		screw(size = frame_screw_size(), min_length = 8 + enclosure_long_side_thickness() + enclosure_insulation_thickness());
	nut_tslot(frame_screw_size());	
}

/** 
 * Renders the plate. This module is not intended to be called outside of this file.
 */
module _render_enclosure_long_side_plate() {
	difference() {
		// the base plate
		translate([0, -enclosure_long_side_width()/2, 0])
			cube([enclosure_long_side_thickness(), enclosure_long_side_width(), enclosure_long_side_height()]);

		// minus the mounting holes through the head bracket
		translate([0, -enclosure_long_side_hole_offset(), head_horizontal_extrusion_center_height()])
			_enclosure_long_side_screw_hole();
		translate([0, enclosure_long_side_hole_offset(), head_horizontal_extrusion_center_height()])
			_enclosure_long_side_screw_hole();

		// minus the mounting holes through the bed bracket
		translate([0, -enclosure_long_side_hole_offset(), bed_horizontal_extrusion_center_height()])
			_enclosure_long_side_screw_hole();
		translate([0, enclosure_long_side_hole_offset(), bed_horizontal_extrusion_center_height()])
			_enclosure_long_side_screw_hole();
		
		// minus the mounting holes through the footer bracket
		translate([0, -enclosure_long_side_hole_offset(), foot_horizontal_extrusion_center_height()])
			_enclosure_long_side_screw_hole();
		translate([0, enclosure_long_side_hole_offset(), foot_horizontal_extrusion_center_height()])
			_enclosure_long_side_screw_hole();
		
	}
}

/**
 * Provides the hardware to mount the plate.
 */
module enclosure_long_side_plate_hardware() {

	// the mounting screws through the head bracket
	translate([0, -enclosure_long_side_hole_offset(), head_horizontal_extrusion_center_height()])
		_enclosure_long_side_screw();
	translate([0, enclosure_long_side_hole_offset(), head_horizontal_extrusion_center_height()])
		_enclosure_long_side_screw();

	// the mounting screws through the bed bracket
	translate([0, -enclosure_long_side_hole_offset(), bed_horizontal_extrusion_center_height()])
		_enclosure_long_side_screw();
	translate([0, enclosure_long_side_hole_offset(), bed_horizontal_extrusion_center_height()])
		_enclosure_long_side_screw();

	// the mounting screws through the footer bracket
	if (foot_with_rail()) {
		translate([0, -enclosure_long_side_hole_offset(), foot_horizontal_extrusion_center_height()])
			_enclosure_long_side_screw();
		translate([0, enclosure_long_side_hole_offset(), foot_horizontal_extrusion_center_height()])
			_enclosure_long_side_screw();
	}

}

_render_enclosure_long_side_plate();
