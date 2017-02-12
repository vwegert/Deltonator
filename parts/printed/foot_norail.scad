/**********************************************************************************************************************
 **
 ** parts/printed/foot_norail.scad
 **
 ** This file constructs the version of the foot of the printer frame that does not hold horizontal rail. To assemble 
 ** the printer, you need three of these parts.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/extrusions/makerslide.scad>
use <../../parts/extrusions/vslot_2020.scad>
use <../../parts/vitamins/vitamins.scad>

// The dimensions of the horizontal parts. Although this foot does not hold any extrusions here, the same dimensions
// are used to keep up the symmetry of the construction.
function _foot_norail_horizontal_height() = washer_diameter(M4) + 2 * frame_wall_thickness();
function _foot_norail_horizontal_width()  = vslot_2020_width() + frame_wall_thickness();
function _foot_norail_horizontal_depth()  = horizontal_extrusion_offset() + horizontal_recess_depth();
function _foot_norail_horizontal_left_y_offset() = -frame_wall_thickness() + horizontal_extrusion_outward_offset();
function _foot_norail_horizontal_right_y_offset() = -_foot_norail_horizontal_width() - horizontal_extrusion_outward_offset() + frame_wall_thickness();

// The dimensions of the vertical part that holds the MakerSlide extrusion.
function _foot_norail_vertical_height() = foot_norail_makerslide_recess_depth();
function _foot_norail_vertical_width()  = frame_wall_thickness() + makerslide_width() + frame_wall_thickness();
function _foot_norail_vertical_depth()  = frame_wall_thickness() + makerslide_depth() + frame_wall_thickness();
function _foot_norail_vertical_side_screw_height() = _foot_norail_horizontal_height()/2; // align with other screw
function _foot_norail_vertical_side_screw_y_offset() = _foot_norail_vertical_width()/2 + 1;

function _foot_norail_t_slot_nut_holder_height() = (foot_norail_makerslide_recess_depth() - t_slot_nut_length()) / 2 
                                                 - t_slot_nut_clearance();

/**
 * Auxiliary module that creates one of the vertical legs. Not to be used outside of this file.
 */
module _foot_norail_horizontal_leg(right = false) { 
	difference() {
		// the basic shape of the leg
		cube([_foot_norail_horizontal_depth(), _foot_norail_horizontal_width(), _foot_norail_horizontal_height()]);
		// minus the inner recess to save some material
		translate([horizontal_extrusion_offset(), right ? frame_wall_thickness() : 0, frame_wall_thickness()])
			cube([horizontal_recess_depth(), vslot_2020_width(), _foot_norail_horizontal_height()]);
		// minus the screw hole on the bottom side
		_screw_x = _foot_norail_horizontal_depth() - horizontal_screw_distance();
		translate([_screw_x, vslot_2020_depth()/2 + (right ? frame_wall_thickness() : 0), frame_wall_thickness()/2 + epsilon()])
				cylinder(d = foot_plate_screw_size(), h = frame_wall_thickness() + 2 * epsilon(), 
		                 center = true, $fn = frame_screw_hole_resolution());
	}
}

/**
 * Creates the lower foot assembly by rendering it from scratch. This module is not to be called externally, use 
 * foot() instead.
 */
module _render_foot_norail() {
	color_printed_outer_frame()
		render() {
			difference() {
				union() {
					// add a block to hold the MakerSlide extrusion, but without the holes for now
					translate([-frame_wall_thickness(), -_foot_norail_vertical_width()/2, 0])
						cube([_foot_norail_vertical_depth(), _foot_norail_vertical_width(), _foot_norail_vertical_height()]);
					// add blocks to hold the V-Slot extrusions, restricted to the specified wall depth in negative Y
					difference() {
						union() {
							rotate([0, 0, 30])
								translate([0, _foot_norail_horizontal_left_y_offset(), 0])
									_foot_norail_horizontal_leg(right = false);
							rotate([0, 0, -30])
								translate([0, _foot_norail_horizontal_right_y_offset(), 0])
									_foot_norail_horizontal_leg(right = true);
						}
						translate([-vslot_2020_depth()-frame_wall_thickness(), -makerslide_width(), 0])
							cube([vslot_2020_depth(), 2*makerslide_width(), _foot_norail_horizontal_height()]);
					}
				}

				// minus the hole for the MakerSlide extrusion
				makerslide_punch(foot_norail_makerslide_recess_depth());

				// minus the screw holes on the back
				translate([-frame_wall_thickness()/2, -makerslide_slot_offset(), foot_norail_vertical_back_screw_height()])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
								 center = true, $fn = frame_screw_hole_resolution());
				translate([-frame_wall_thickness()/2, makerslide_slot_offset(), foot_norail_vertical_back_screw_height()])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
								 center = true, $fn = frame_screw_hole_resolution());

				// minus the screw holes on the side
				translate([makerslide_slot_offset(), 0, _foot_norail_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_size(), h = 2*_foot_norail_vertical_width(), 
								 center = true, $fn = frame_screw_hole_resolution());

				// minus an additional inset so that the side screws can rest on a perpendicular surface
				_inset_depth = 100;
				translate([makerslide_slot_offset(), _foot_norail_vertical_side_screw_y_offset() + _inset_depth/2, _foot_norail_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_head_size(), h = _inset_depth, 
								 center = true, $fn = frame_screw_hole_resolution());
				translate([makerslide_slot_offset(), -_foot_norail_vertical_side_screw_y_offset() - _inset_depth/2, _foot_norail_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_head_size(), h = _inset_depth, 
								 center = true, $fn = frame_screw_hole_resolution());				
			}

			// plus the blocks to hold the T-Slot nut on the outer sides
			translate([(makerslide_base_depth() - t_slot_nut_holder_width()) / 2, 
				       makerslide_base_width() / 2 - t_slot_nut_holder_depth() + makerslide_clearance(), 
				       0])
				cube([t_slot_nut_holder_width(), t_slot_nut_holder_depth(), _foot_norail_t_slot_nut_holder_height()]);
			translate([(makerslide_base_depth() - t_slot_nut_holder_width()) / 2, 
				       -makerslide_base_width() / 2 - makerslide_clearance(), 
				       0])
				cube([t_slot_nut_holder_width(), t_slot_nut_holder_depth(), _foot_norail_t_slot_nut_holder_height()]);
	
			// plus the blocks to hold the T-Slot nut on the back sides
			translate([-makerslide_clearance(), 
				       -makerslide_slot_offset() - t_slot_nut_holder_width()/2, 
				       0])
				cube([t_slot_nut_holder_depth(), t_slot_nut_holder_width(), _foot_norail_t_slot_nut_holder_height()]);
			translate([-makerslide_clearance(), 
				       +makerslide_slot_offset() - t_slot_nut_holder_width()/2,
				       0])
				cube([t_slot_nut_holder_depth(), t_slot_nut_holder_width(), _foot_norail_t_slot_nut_holder_height()]);
	
		} 
}

/**
 * Main module to use the pre-rendered lower foot. The assembly is centered on the Z axis in Y direction for easier 
 * manipulation, similar to the MakerSlide extrusion. 
 */
module foot_norail() {
	bom_entry(section = "Printed Parts", description = "Frame", size = "Foot (No-Rail Version)");
	color_printed_outer_frame()
		import(file = "foot_norail.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module foot_norail_hardware(vertical_side_screws = true, vertical_back_screws = false) {

	if (vertical_back_screws) {
		// vertical MakerSlide rail -- back 
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4), 
			       -makerslide_slot_offset(), 
			       foot_norail_vertical_back_screw_height()]) {
			washer(size = M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4) - epsilon(), 
			       -makerslide_slot_offset(), 
			       foot_norail_vertical_back_screw_height()]) {
			screw(size = M4, length = 8);
			nut_tslot(M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4),
		           makerslide_slot_offset(), 
		           foot_norail_vertical_back_screw_height()]) {
			washer(size = M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4) - epsilon(),
		           makerslide_slot_offset(), 
		           foot_norail_vertical_back_screw_height()]) {
			screw(size = M4, length = 8);
			nut_tslot(M4);
		}
	}

	if (vertical_side_screws) {
		// vertical MakerSlide rail -- sides
		_side_screw_y = _foot_norail_vertical_side_screw_y_offset() + epsilon();
		translate([makerslide_slot_offset(), 
			       _side_screw_y + washer_thickness(M4), 
			       _foot_norail_vertical_side_screw_height()]) 
			rotate([0, 0, -90]) {
				washer(size = M4);
			}
		translate([makerslide_slot_offset(), 
			       _side_screw_y + washer_thickness(M4) + epsilon(), 
			       _foot_norail_vertical_side_screw_height()]) 
			rotate([0, 0, -90]) {
				screw(size = M4, length = 12);
				nut_tslot(M4);
			}
		translate([makerslide_slot_offset(), 
			       -_side_screw_y - washer_thickness(M4) - epsilon(), 
			       _foot_norail_vertical_side_screw_height()]) 
			rotate([0, 0, 90]) {
				screw(size = M4, length = 12);
				nut_tslot(M4);
			}
		translate([makerslide_slot_offset(), 
			       -_side_screw_y - washer_thickness(M4), 
			       _foot_norail_vertical_side_screw_height()]) 
			rotate([0, 0, 90]) {
				washer(size = M4);
			}
	}

}

_render_foot_norail();
