/**********************************************************************************************************************
 **
 ** parts/printed/bed_bracket.scad
 **
 ** This file constructs the bed_bracket of the printer frame. To assemble the printer, you need three of these parts.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/extrusions/makerslide.scad>
use <../../parts/extrusions/vslot_2020.scad>
use <../../parts/vitamins/vitamins.scad>

// The dimensions of the horizontal parts that hold the V-Slot extrusions.
function _bed_bracket_horizontal_height() = vslot_2020_depth() + frame_wall_thickness();
function _bed_bracket_horizontal_width()  = vslot_2020_width() + frame_wall_thickness();
function _bed_bracket_horizontal_depth()  = horizontal_extrusion_offset() + horizontal_recess_depth();
function _bed_bracket_horizontal_left_y_offset() = -frame_wall_thickness() + horizontal_extrusion_outward_offset();
function _bed_bracket_horizontal_right_y_offset() = -_bed_bracket_horizontal_width() - horizontal_extrusion_outward_offset() + frame_wall_thickness();
function _bed_bracket_horizontal_z_offset()  = bed_bracket_height() - frame_wall_thickness() - vslot_2020_width();

// The dimensions of the vertical part that holds the MakerSlide extrusion.
function _bed_bracket_vertical_height() = bed_bracket_height();
function _bed_bracket_vertical_width()  = frame_wall_thickness() + makerslide_width() + frame_wall_thickness();
function _bed_bracket_vertical_depth()  = frame_wall_thickness() + makerslide_depth() + frame_wall_thickness();
function _bed_bracket_vertical_side_screw_height() = _bed_bracket_vertical_height() - _bed_bracket_horizontal_height()/2; // align with other screw
function _bed_bracket_vertical_side_screw_y_offset() = _bed_bracket_vertical_width()/2 + 1;

/**
 * Auxiliary module that creates one of the vertical legs. Not to be used outside of this file.
 */
module _bed_bracket_horizontal_leg(right = false) { 
	difference() {
		// the basic shape of the leg
		cube([_bed_bracket_horizontal_depth(), _bed_bracket_horizontal_width(), _bed_bracket_horizontal_height()]);
		// minus the recess for the horizontal extrusion
		translate([horizontal_extrusion_offset(), 
			       right ? 0 : frame_wall_thickness(), 
			       vslot_2020_depth() + frame_wall_thickness()])
			rotate([0, 90, 0])
				vslot_2020_punch(horizontal_recess_depth());
		// minus the screw hole on the inside
		_screw_x = _bed_bracket_horizontal_depth()-horizontal_screw_distance();
		translate([_screw_x, _bed_bracket_horizontal_width()/2, vslot_2020_depth()/2 + frame_wall_thickness()])
			rotate([90, 0, 0])
				cylinder(d = frame_screw_size(), h = _bed_bracket_horizontal_width(), 
		                 center = true, $fn = frame_screw_hole_resolution());
		// minus the screw hole on the top side
		translate([_screw_x, 
			       vslot_2020_depth()/2 + (right ? 0 : frame_wall_thickness()), 
			       _bed_bracket_horizontal_height() - vslot_2020_depth() - frame_wall_thickness()])
				cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
		                 center = true, $fn = frame_screw_hole_resolution());
	}
}

/**
 * Auxiliary module that creates the hardware for one of the vertical legs. Not to be used outside of this file.
 */
module _bed_bracket_horizontal_leg_hardware(right = false, side_screw = true, bottom_screw = false) { 
	_screw_x = _bed_bracket_horizontal_depth()-horizontal_screw_distance();

	if (side_screw) {
		// inner screw
		translate([_screw_x, 
			       right ? _bed_bracket_horizontal_width() + epsilon() + washer_thickness(M4) 
			             : -epsilon() - washer_thickness(M4), 
			       vslot_2020_depth()/2])
			rotate([0, 0, right ? -90 : 90]) {
				washer(M4);
			}
		translate([_screw_x, 
			       right ? _bed_bracket_horizontal_width() + epsilon() + washer_thickness(M4) + epsilon() 
			             : -epsilon() - washer_thickness(M4) - epsilon(), 
			       vslot_2020_depth()/2])
			rotate([0, 0, right ? -90 : 90]) {
				screw(size = M4, length = 8);
				nut_tslot(M4);
			}
	}

	if (bottom_screw) {
		// bottom screw
		translate([_screw_x, 
			       vslot_2020_depth()/2 + (right ? 0 : frame_wall_thickness()), 
			       _bed_bracket_horizontal_z_offset() - epsilon() - washer_thickness(M4) ])
			rotate([0, -90, 0]) {
				washer(size = M4);
			}
		translate([_screw_x, 
			       vslot_2020_depth()/2 + (right ? 0 : frame_wall_thickness()), 
			       _bed_bracket_horizontal_z_offset() - epsilon() - washer_thickness(M4) - epsilon()])
			rotate([0, -90, 0]) {
				screw(size = M4, length = 8);
				nut_tslot(M4);
			}
	}
}

/**
 * Creates the lower bed bracket assembly by rendering it from scratch. This module is not to be called externally, use 
 * bed_bracket() instead.
 */
module _render_bed_bracket() {
	color_printed_outer_frame()
		render() {
			difference() {
				union() {
					// add a block to hold the MakerSlide extrusion, but without the holes for now
					translate([-frame_wall_thickness(), -_bed_bracket_vertical_width()/2, 0])
						cube([_bed_bracket_vertical_depth(), _bed_bracket_vertical_width(), _bed_bracket_vertical_height()]);
					// add blocks to hold the V-Slot extrusions, restricted to the specified wall depth in negative Y
					difference() {
						union() {
							rotate([0, 0, 30])
								translate([0, _bed_bracket_horizontal_left_y_offset(), _bed_bracket_horizontal_z_offset()])
									_bed_bracket_horizontal_leg(right = false);
							rotate([0, 0, -30])
								translate([0, _bed_bracket_horizontal_right_y_offset(), _bed_bracket_horizontal_z_offset()])
									_bed_bracket_horizontal_leg(right = true);
						}
						translate([-vslot_2020_depth()-frame_wall_thickness(), -makerslide_width(), _bed_bracket_horizontal_z_offset()])
							cube([vslot_2020_depth(), 2*makerslide_width(), _bed_bracket_horizontal_height()]);
					}
				}

				// minus the hole for the MakerSlide extrusion
				makerslide_punch(bed_bracket_height());

				// minus the screw holes on the back
				translate([-frame_wall_thickness()/2, -makerslide_slot_offset(), bed_bracket_back_screw_z_offset()])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
								 center = true, $fn = frame_screw_hole_resolution());
				translate([-frame_wall_thickness()/2, makerslide_slot_offset(), bed_bracket_back_screw_z_offset()])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
								 center = true, $fn = frame_screw_hole_resolution());

				// minus the screw holes on the side
				translate([makerslide_slot_offset(), 0, _bed_bracket_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_size(), h = 2*_bed_bracket_vertical_width(), 
								 center = true, $fn = frame_screw_hole_resolution());
						
				// minus an additional inset so that the side screws can rest on a perpendicular surface
				_inset_depth = 100;
				translate([makerslide_slot_offset(), _bed_bracket_vertical_side_screw_y_offset() + _inset_depth/2, _bed_bracket_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_head_size(), h = _inset_depth, 
								 center = true, $fn = frame_screw_hole_resolution());
				translate([makerslide_slot_offset(), -_bed_bracket_vertical_side_screw_y_offset() - _inset_depth/2, _bed_bracket_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_head_size(), h = _inset_depth, 
								 center = true, $fn = frame_screw_hole_resolution());				
			}
		} 
}

/**
 * Main module to use the pre-rendered lower bed bracket. The assembly is centered on the Z axis in Y direction for easier 
 * manipulation, similar to the MakerSlide extrusion. 
 */
module bed_bracket() {
	bom_entry(section = "Printed Parts", description = "Frame", size = "Bed Bracket");
	color_printed_outer_frame()
		import(file = "bed_bracket.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module bed_bracket_hardware(vertical_side_screws = true, vertical_back_screws = false, horizontal_side_screws = true, horizontal_bottom_screws = false) {

	if (vertical_back_screws) {
		// vertical MakerSlide rail -- back 
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4), 
			       -makerslide_slot_offset(), 
			       bed_bracket_back_screw_z_offset()]) {
			washer(size = M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4) - epsilon(), 
			       -makerslide_slot_offset(), 
			       bed_bracket_back_screw_z_offset()]) {
			screw(size = M4, length = 8);
			nut_tslot(M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4),
		           makerslide_slot_offset(), 
		           bed_bracket_back_screw_z_offset()]) {
			washer(size = M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4) - epsilon(),
		           makerslide_slot_offset(), 
		           bed_bracket_back_screw_z_offset()]) {
			screw(size = M4, length = 8);
			nut_tslot(M4);
		}
	}

	if (vertical_side_screws) {
		// vertical MakerSlide rail -- sides
		_side_screw_y = _bed_bracket_vertical_side_screw_y_offset() + epsilon();
		translate([makerslide_slot_offset(), 
			       _side_screw_y + washer_thickness(M4), 
			       _bed_bracket_vertical_side_screw_height()]) 
			rotate([0, 0, -90]) {
				washer(size = M4);
			}
		translate([makerslide_slot_offset(), 
			       _side_screw_y + washer_thickness(M4) + epsilon(), 
			       _bed_bracket_vertical_side_screw_height()]) 
			rotate([0, 0, -90]) {
				screw(size = M4, length = 12);
				nut_tslot(M4);
			}
		translate([makerslide_slot_offset(), 
			       -_side_screw_y - washer_thickness(M4) - epsilon(), 
			       _bed_bracket_vertical_side_screw_height()]) 
			rotate([0, 0, 90]) {
				screw(size = M4, length = 12);
				nut_tslot(M4);
			}
		translate([makerslide_slot_offset(), 
			       -_side_screw_y - washer_thickness(M4), 
			       _bed_bracket_vertical_side_screw_height()]) 
			rotate([0, 0, 90]) {
				washer(size = M4);
			}
	}

	// left horizontal leg
	rotate([0, 0, 30])
		translate([0, _bed_bracket_horizontal_left_y_offset(), 0])
			_bed_bracket_horizontal_leg_hardware(right = false, 
				                                 side_screw = horizontal_side_screws, 
				                                 bottom_screw = horizontal_bottom_screws);

	// right horizontal leg
	rotate([0, 0, -30])
		translate([0, _bed_bracket_horizontal_right_y_offset(), 0])
			_bed_bracket_horizontal_leg_hardware(right = true, 
				                                 side_screw = horizontal_side_screws, 
				                                 bottom_screw = horizontal_bottom_screws);

}

_render_bed_bracket();