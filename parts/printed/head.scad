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
use <../../parts/printed/tensioner.scad>
use <../../parts/vitamins/vitamins.scad>

// set this to true to show the tensioner for positioning - set to false to render the part only
_DEBUG_HEAD_TENSIONER = false;

// The dimensions of the horizontal parts that hold the V-Slot extrusions.
function _head_horizontal_height() = vslot_2020_depth() + frame_wall_thickness();
function _head_horizontal_width()  = vslot_2020_width() + frame_wall_thickness();
function _head_horizontal_depth()  = horizontal_extrusion_offset() + horizontal_recess_depth();
function _head_horizontal_left_y_offset()  = -frame_wall_thickness() + horizontal_extrusion_outward_offset();
function _head_horizontal_right_y_offset() = -_head_horizontal_width() - horizontal_extrusion_outward_offset() + frame_wall_thickness();
function _head_horizontal_z_offset()  = head_makerslide_recess_depth() - frame_wall_thickness() - vslot_2020_width();

// The dimensions of the vertical part that holds the MakerSlide extrusion.
function _head_vertical_height() = head_makerslide_recess_depth();
function _head_vertical_width()  = frame_wall_thickness() + makerslide_width() + frame_wall_thickness();
function _head_vertical_depth()  = frame_wall_thickness() + tensioner_x_offset() - tensioner_depth()/2;
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
module _head_horizontal_leg_hardware(right = false, side_screw = true, bottom_screw = false) { 
	_screw_x = _head_horizontal_depth()-horizontal_screw_distance();

	if (side_screw) {
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
	}

	if (bottom_screw) {
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
}

/**
 * Creates the vertical guides to the left an right of the tensioner and the end switch bracket.
 */
module _head_guides() {
	_guide_x = _head_vertical_depth() - frame_wall_thickness();
	_left_guide_y = -tensioner_width()/2 - head_guide_width() - head_guide_clearance();
	_center_guide_y = tensioner_width()/2 + head_guide_clearance();
	_right_guide_y = tensioner_width()/2 + 3*head_guide_clearance() + head_guide_width() + end_switch_bracket_top_width();

	translate([_guide_x, _left_guide_y, 0])
		cube([head_guide_depth(), head_guide_width(), _head_vertical_height()]);

	translate([_guide_x, _center_guide_y, 0])
		cube([head_guide_depth(), head_guide_width(), _head_vertical_height()]);

	translate([_guide_x, _right_guide_y, 0])
		cube([head_guide_depth(), head_guide_width(), _head_vertical_height()]);

}

/**
 * Creates the head plate that the tensioner screw and the top screws will feed through.
 */
module _head_top_plate() {

	_base_width = makerslide_width();	
	_plate_depth = tensioner_depth() + frame_wall_thickness();
	_edge_width = _base_width + 2 * (_plate_depth * tan(30));
	translate([_head_vertical_depth() - frame_wall_thickness(), 
		       0, 
		       _head_vertical_height() - frame_wall_thickness()]) {
		difference() {
			// the plate itself
			linear_extrude(height = frame_wall_thickness(), center = false) {
				polygon(points = [
					[ 0, -_base_width/2],
					[ 0, _base_width/2],
					[ _plate_depth, _edge_width/2],
					[ _plate_depth, -_edge_width/2]
				]);
			}
			// minus the screw hole for the tensioner
			translate([tensioner_depth()/2, 0, 0])
				cylinder(d = M4, h = frame_wall_thickness() + 2 * epsilon(), $fn = frame_screw_hole_resolution());

			// minus the screw hole for the end switch bracket
			translate([end_switch_bracket_top_depth()/2,
				       end_switch_bracket_y_offset() + end_switch_bracket_top_width()/2,
				       -epsilon()])
				cylinder(d = M3, h = frame_wall_thickness() + 2 * epsilon(), $fn = frame_screw_hole_resolution());

	 	}
	}

}

/**
 * Adds the blocks that hold the T-Slot nuts in place.
 */
module _head_t_slot_nut_holders() {

	// arbitrarily chosen, no special reason for this value
	_t_slot_nut_holder_height = t_slot_nut_holder_width();

	_t_slot_nut_holder_z_offset_side = _head_vertical_side_screw_height() 
	                                   - _t_slot_nut_holder_height
	                                   - frame_screw_size()/2
	                                   - t_slot_nut_length()/2 
	                                   - t_slot_nut_clearance();
	_t_slot_nut_holder_z_offset_back = head_back_screw_z_offset() 
	                                   - _t_slot_nut_holder_height
	                                   - frame_screw_size()/2
	                                   - t_slot_nut_length()/2 
	                                   - t_slot_nut_clearance();

	// plus the blocks to hold the T-Slot nut on the outer sides
	translate([(makerslide_base_depth() - t_slot_nut_holder_width()) / 2, 
		       makerslide_base_width() / 2 - t_slot_nut_holder_depth() + makerslide_clearance(), 
		       _t_slot_nut_holder_z_offset_side])
		cube([t_slot_nut_holder_width(), t_slot_nut_holder_depth(), _t_slot_nut_holder_height]);
	translate([(makerslide_base_depth() - t_slot_nut_holder_width()) / 2, 
		       -makerslide_base_width() / 2 - makerslide_clearance(), 
		       _t_slot_nut_holder_z_offset_side])
		cube([t_slot_nut_holder_width(), t_slot_nut_holder_depth(), _t_slot_nut_holder_height]);

	// plus the blocks to hold the T-Slot nut on the back sides
	translate([-makerslide_clearance(), 
		       -makerslide_slot_offset() - t_slot_nut_holder_width()/2, 
		       _t_slot_nut_holder_z_offset_back])
		cube([t_slot_nut_holder_depth(), t_slot_nut_holder_width(), _t_slot_nut_holder_height]);
	translate([-makerslide_clearance(), 
		       +makerslide_slot_offset() - t_slot_nut_holder_width()/2,
		       _t_slot_nut_holder_z_offset_back])
		cube([t_slot_nut_holder_depth(), t_slot_nut_holder_width(), _t_slot_nut_holder_height]);

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
					translate([-frame_wall_thickness(), -_head_vertical_width()/2, 0])
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
				makerslide_punch(head_makerslide_recess_depth());

				// minus the groove for the tensioner axle nut
				translate([_head_vertical_depth() - frame_wall_thickness() - head_tensioner_groove_depth(), 
					       -head_tensioner_groove_width()/2, 0])
					cube([head_tensioner_groove_depth(), head_tensioner_groove_width(), head_tensioner_groove_height()]);

				// minus the screw holes on the back
				translate([-frame_wall_thickness()/2, -makerslide_slot_offset(), head_back_screw_z_offset()])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
								 center = true, $fn = frame_screw_hole_resolution());
				translate([-frame_wall_thickness()/2, makerslide_slot_offset(), head_back_screw_z_offset()])
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

			// add the T-Slot nut holders
			_head_t_slot_nut_holders();

			// add the vertical guide blocks for the tensioner and bracket
			_head_guides();
			
			// add the top plate
			_head_top_plate();
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
module head_hardware(vertical_side_screws = true, vertical_back_screws = false, horizontal_side_screws = true, horizontal_bottom_screws = false) {

	if (vertical_back_screws) {
		// vertical MakerSlide rail -- back 
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4), 
			       -makerslide_slot_offset(), 
			       head_back_screw_z_offset()]) {
			washer(size = M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4) - epsilon(), 
			       -makerslide_slot_offset(), 
			       head_back_screw_z_offset()]) {
			screw(size = M4, length = 8);
			nut_tslot(M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4),
		           makerslide_slot_offset(), 
		           head_back_screw_z_offset()]) {
			washer(size = M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4) - epsilon(),
		           makerslide_slot_offset(), 
		           head_back_screw_z_offset()]) {
			screw(size = M4, length = 8);
			nut_tslot(M4);
		}
	}

	if (vertical_side_screws) {
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
	}

	// left horizontal leg
	rotate([0, 0, 30])
		translate([0, _head_horizontal_left_y_offset(), 0])
			_head_horizontal_leg_hardware(right = false, 
				                          side_screw = horizontal_side_screws, 
				                          bottom_screw = horizontal_bottom_screws);


	// right horizontal leg
	rotate([0, 0, -30])
		translate([0, _head_horizontal_right_y_offset(), 0])
			_head_horizontal_leg_hardware(right = true, 
				                          side_screw = horizontal_side_screws, 
				                          bottom_screw = horizontal_bottom_screws);

}

_render_head();
if (_DEBUG_HEAD_TENSIONER) {
	translate([tensioner_x_offset(), 0, _head_vertical_height() - tensioner_z_offset()]) {
		tensioner();
		tensioner_hardware(screw_position = tensioner_screw_position());
	}
}

