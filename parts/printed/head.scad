/**********************************************************************************************************************
 **
 ** parts/printed/head.scad
 **
 ** This file constructs the head of the printer frame. To assemble the printer, you need three of these parts.
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
function _head_horizontal_height() = vslot_2020_depth() + frame_wall_thickness();
function _head_horizontal_width()  = vslot_2020_width() + frame_wall_thickness();
function _head_horizontal_depth()  = horizontal_extrusion_offset() + horizontal_recess_depth();
function _head_horizontal_left_y_offset()  = -frame_wall_thickness() + horizontal_extrusion_outward_offset();
function _head_horizontal_right_y_offset() = -_head_horizontal_width() - horizontal_extrusion_outward_offset() + frame_wall_thickness();
function _head_horizontal_z_offset()  = vertical_recess_depth() - frame_wall_thickness() - vslot_2020_width();

// The dimensions of the vertical part that holds the MakerSlide extrusion.
function _head_vertical_height() = vertical_recess_depth();
function _head_vertical_width()  = frame_wall_thickness() + makerslide_width() + frame_wall_thickness();
function _head_vertical_depth()  = frame_wall_thickness() + makerslide_depth() + frame_wall_thickness();
function _head_vertical_back_screw_height() = vertical_recess_depth()/2;
function _head_vertical_side_screw_height() = _head_vertical_height() - _head_horizontal_height()/2; // align with other screw
function _head_vertical_side_screw_y_offset() = _head_vertical_width()/2 + 1;

// TODO add some holes to screw the head to a flat surface

/**
 * Auxiliary module that creates one of the vertical legs. Not to be used outside of this file.
 */
module _head_horizontal_leg(right = false) { 
	difference() {
		// the basic shape of the leg
		cube([_head_horizontal_depth(), _head_horizontal_width(), _head_horizontal_height()]);
		// minus the recess for the horizontal extrusion
		translate([horizontal_extrusion_offset(), 
			       right ? 0 : frame_wall_thickness(), 
			       vslot_2020_depth() + frame_wall_thickness()])
			rotate([0, 90, 0])
				vslot_2020_punch(horizontal_recess_depth());
		// minus the screw hole on the inside
		_screw_x = _head_horizontal_depth()-horizontal_screw_distance();
		translate([_screw_x, _head_horizontal_width()/2, vslot_2020_depth()/2 + frame_wall_thickness()])
			rotate([90, 0, 0])
				cylinder(d = frame_screw_size(), h = _head_horizontal_width(), 
		                 center = true, $fn = frame_screw_hole_resolution());
		// minus the screw hole on the bottom side
		translate([_screw_x, 
			       vslot_2020_depth()/2 + (right ? 0 : frame_wall_thickness()), 
			       _head_horizontal_height() - vslot_2020_depth() - frame_wall_thickness()])
				cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
		                 center = true, $fn = frame_screw_hole_resolution());
	}
}

/**
 * Auxiliary module that creates the hardware for one of the vertical legs. Not to be used outside of this file.
 */
module _head_horizontal_leg_hardware(right = false) { 
	_screw_x = _head_horizontal_depth()-horizontal_screw_distance();
	// inner screw
	translate([_screw_x, 
		       right ? _head_horizontal_width() + epsilon() + washer_thickness(M4) 
		             : -epsilon() - washer_thickness(M4), 
		       _head_horizontal_z_offset() + frame_wall_thickness() + vslot_2020_depth()/2])
		rotate([0, 0, right ? -90 : 90]) {
			washer(M4);
		}
	translate([_screw_x, 
		       right ? _head_horizontal_width() + epsilon() + washer_thickness(M4) + epsilon() 
		             : -epsilon() - washer_thickness(M4) - epsilon(), 
		       _head_horizontal_z_offset() + frame_wall_thickness() + vslot_2020_depth()/2])
		rotate([0, 0, right ? -90 : 90]) {
			screw(size = M4, length = 8);
			nut_tslot(M4);
		}
	// bottom screw
	translate([_screw_x, 
		       vslot_2020_depth()/2 + (right ? 0 : frame_wall_thickness()), 
		       _head_horizontal_z_offset() - epsilon() - washer_thickness(M4) ])
		rotate([0, -90, 0]) {
			washer(size = M4);
		}
	translate([_screw_x, 
		       vslot_2020_depth()/2 + (right ? 0 : frame_wall_thickness()), 
		       _head_horizontal_z_offset() - epsilon() - washer_thickness(M4) - epsilon()])
		rotate([0, -90, 0]) {
			screw(size = M4, length = 8);
			nut_tslot(M4);
		}
}

/**
 * Creates the lower head assembly by rendering it from scratch. This module is not to be called externally, use 
 * head() instead.
 */
module _render_head() {
	color_printed_outer_frame()
		render() {
			difference() {
				union() {
					// add a block to hold the MakerSlide extrusion, but without the holes for now
					translate([-frame_wall_thickness(), -_head_vertical_width()/2, ])
						cube([_head_vertical_depth(), _head_vertical_width(), _head_vertical_height()]);
					// add blocks to hold the V-Slot extrusions, restricted to the specified wall depth in negative Y
					difference() {
						union() {
							rotate([0, 0, 30])
								translate([0, _head_horizontal_left_y_offset(), _head_horizontal_z_offset()])
									_head_horizontal_leg(right = false);
							rotate([0, 0, -30])
								translate([0, _head_horizontal_right_y_offset(), _head_horizontal_z_offset()])
									_head_horizontal_leg(right = true);
						}
						translate([-vslot_2020_depth()-frame_wall_thickness(), -makerslide_width(), _head_horizontal_z_offset()])
							cube([vslot_2020_depth(), 2*makerslide_width(), _head_horizontal_height()]);
					}
				}
				// minus the hole for the MakerSlide extrusion
				makerslide_punch(vertical_recess_depth());
				// minus the screw holes on the back
				translate([-frame_wall_thickness()/2, -makerslide_slot_offset(), _head_vertical_back_screw_height()])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
								 center = true, $fn = frame_screw_hole_resolution());
				translate([-frame_wall_thickness()/2, makerslide_slot_offset(), _head_vertical_back_screw_height()])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
								 center = true, $fn = frame_screw_hole_resolution());
				// minus the screw holes on the side
				translate([makerslide_slot_offset(), 0, _head_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_size(), h = 2*_head_vertical_width(), 
								 center = true, $fn = frame_screw_hole_resolution());
				// minus an additional inset so that the side screws can rest on a perpendicular surface
				_inset_depth = 100;
				translate([makerslide_slot_offset(), _head_vertical_side_screw_y_offset() + _inset_depth/2, _head_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_head_size(), h = _inset_depth, 
								 center = true, $fn = frame_screw_hole_resolution());
				translate([makerslide_slot_offset(), -_head_vertical_side_screw_y_offset() - _inset_depth/2, _head_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_head_size(), h = _inset_depth, 
								 center = true, $fn = frame_screw_hole_resolution());				
			}
		} 
}

/**
 * Main module to use the pre-rendered lower head. The assembly is centered on the Z axis in Y direction for easier 
 * manipulation, similar to the MakerSlide extrusion. 
 */
module head() {
	bom_entry(section = "Printed Parts", description = "Frame", size = "Head");
	color_printed_outer_frame()
		import(file = "head.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module head_hardware() {

	// vertical MakerSlide rail -- back 
	translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4), 
		       -makerslide_slot_offset(), 
		       _head_vertical_back_screw_height()]) {
		washer(size = M4);
	}
	translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4) - epsilon(), 
		       -makerslide_slot_offset(), 
		       _head_vertical_back_screw_height()]) {
		screw(size = M4, length = 8);
		nut_tslot(M4);
	}
	translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4),
	           makerslide_slot_offset(), 
	           _head_vertical_back_screw_height()]) {
		washer(size = M4);
	}
	translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4) - epsilon(),
	           makerslide_slot_offset(), 
	           _head_vertical_back_screw_height()]) {
		screw(size = M4, length = 8);
		nut_tslot(M4);
	}

	// vertical MakerSlide rail -- sides
	_side_screw_y = _head_vertical_side_screw_y_offset() + epsilon();
	translate([makerslide_slot_offset(), 
		       _side_screw_y + washer_thickness(M4), 
		       _head_vertical_side_screw_height()]) 
		rotate([0, 0, -90]) {
			washer(size = M4);
		}
	translate([makerslide_slot_offset(), 
		       _side_screw_y + washer_thickness(M4) + epsilon(), 
		       _head_vertical_side_screw_height()]) 
		rotate([0, 0, -90]) {
			screw(size = M4, length = 12);
			nut_tslot(M4);
		}
	translate([makerslide_slot_offset(), 
		       -_side_screw_y - washer_thickness(M4) - epsilon(), 
		       _head_vertical_side_screw_height()]) 
		rotate([0, 0, 90]) {
			screw(size = M4, length = 12);
			nut_tslot(M4);
		}
	translate([makerslide_slot_offset(), 
		       -_side_screw_y - washer_thickness(M4), 
		       _head_vertical_side_screw_height()]) 
		rotate([0, 0, 90]) {
			washer(size = M4);
		}

	// left horizontal leg
	rotate([0, 0, 30])
		translate([0, _head_horizontal_left_y_offset(), 0])
			_head_horizontal_leg_hardware(right = false);


	// right horizontal leg
	rotate([0, 0, -30])
		translate([0, _head_horizontal_right_y_offset(), 0])
			_head_horizontal_leg_hardware(right = true);

}

_render_head();
