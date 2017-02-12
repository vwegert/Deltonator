/**********************************************************************************************************************
 **
 ** parts/printed/foot_rail.scad
 **
 ** This file constructs the version of the foot of the printer frame that holds a horizontal rail. To assemble the 
 ** printer, you need three of these parts.
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
function _foot_rail_horizontal_height() = vslot_2020_depth() + frame_wall_thickness();
function _foot_rail_horizontal_width()  = vslot_2020_width() + frame_wall_thickness();
function _foot_rail_horizontal_depth()  = horizontal_extrusion_offset() + horizontal_recess_depth();
function _foot_rail_horizontal_left_y_offset() = -frame_wall_thickness() + horizontal_extrusion_outward_offset();
function _foot_rail_horizontal_right_y_offset() = -_foot_rail_horizontal_width() - horizontal_extrusion_outward_offset() + frame_wall_thickness();

// The dimensions of the vertical part that holds the MakerSlide extrusion.
function _foot_rail_vertical_height() = foot_rail_makerslide_recess_depth();
function _foot_rail_vertical_width()  = frame_wall_thickness() + makerslide_width() + frame_wall_thickness();
function _foot_rail_vertical_depth()  = frame_wall_thickness() + makerslide_depth() + frame_wall_thickness();
function _foot_rail_vertical_side_screw_height() = _foot_rail_horizontal_height()/2; // align with other screw
function _foot_rail_vertical_side_screw_y_offset() = _foot_rail_vertical_width()/2 + 1;

function _foot_rail_t_slot_nut_holder_height() = (foot_rail_makerslide_recess_depth() - t_slot_nut_length()) / 2 
                                                 - t_slot_nut_clearance();

/**
 * Auxiliary module that creates one of the vertical legs. Not to be used outside of this file.
 */
module _foot_rail_horizontal_leg(right = false) { 
	difference() {
		// the basic shape of the leg
		cube([_foot_rail_horizontal_depth(), _foot_rail_horizontal_width(), _foot_rail_horizontal_height()]);
		// minus the recess for the horizontal extrusion
		translate([horizontal_extrusion_offset(), right ? 0 : frame_wall_thickness(), vslot_2020_depth()])
			rotate([0, 90, 0])
				vslot_2020_punch(horizontal_recess_depth());
		// minus the screw hole on the inside
		_screw_x = _foot_rail_horizontal_depth() - horizontal_screw_distance();
		translate([_screw_x, _foot_rail_horizontal_width()/2, vslot_2020_depth()/2])
			rotate([90, 0, 0])
				cylinder(d = frame_screw_size(), h = _foot_rail_horizontal_width(), 
		                 center = true, $fn = frame_screw_hole_resolution());
		// minus the screw hole on the top side
		translate([_screw_x, vslot_2020_depth()/2 + (right ? 0 : frame_wall_thickness()), _foot_rail_horizontal_height() - frame_wall_thickness()])
				cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
		                 center = true, $fn = frame_screw_hole_resolution());
	}
}

/**
 * Auxiliary module that creates the hardware for one of the vertical legs. Not to be used outside of this file.
 */
module _foot_rail_horizontal_leg_hardware(right = false, side_screws = true, top_screws = false) { 
	_screw_x = _foot_rail_horizontal_depth()-horizontal_screw_distance();
	
	if (side_screws) {
		// inner screw
		translate([_screw_x, 
			       right ? _foot_rail_horizontal_width() + epsilon() + washer_thickness(M4) 
		    	         : -epsilon() - washer_thickness(M4), 
			       vslot_2020_depth()/2])
			rotate([0, 0, right ? -90 : 90]) {
				washer(M4);
			}
		translate([_screw_x, 
			       right ? _foot_rail_horizontal_width() + epsilon() + washer_thickness(M4) + epsilon() 
		    	         : -epsilon() - washer_thickness(M4) - epsilon(), 
			       vslot_2020_depth()/2])
			rotate([0, 0, right ? -90 : 90]) {
				screw(size = M4, length = 8);
				nut_tslot(M4);
			}
	}

	if (top_screws) {
		// top screw
		translate([_screw_x, 
			       vslot_2020_depth()/2 + (right ? 0 : frame_wall_thickness()), 
			       _foot_rail_horizontal_height() + epsilon() + washer_thickness(M4) ])
			rotate([0, 90, 0]) {
				washer(size = M4);
			}
		translate([_screw_x, 
			       vslot_2020_depth()/2 + (right ? 0 : frame_wall_thickness()), 
			       _foot_rail_horizontal_height() + epsilon() + washer_thickness(M4) + epsilon()])
			rotate([0, 90, 0]) {
				screw(size = M4, length = 8);
				nut_tslot(M4);
			}
	}
}

/**
 * Creates the bottom plate that the foot screw will screw into
 */
module _foot_rail_bottom_plate() {
	_base_width = makerslide_width();	
	_edge_width = _base_width + 2 * (foot_rail_plate_depth() * tan(30));
	translate([_foot_rail_vertical_depth() - frame_wall_thickness(), 0, 0]) { 
		difference() {
			// the plate itself
			linear_extrude(height = foot_rail_plate_height(), center = false) {
				polygon(points = [
					[ 0, -_base_width/2],
					[ 0, _base_width/2],
					[ foot_rail_plate_depth(), _edge_width/2],
					[ foot_rail_plate_depth(), -_edge_width/2]
				]);
			}
			// minus the screw hole for the external foot
			translate([foot_rail_plate_depth()/2, 0, -epsilon()])
				cylinder(d = tap_base_diameter(foot_plate_screw_size()), 
					     h = foot_rail_plate_height() + 2 * epsilon(), 
					     $fn = frame_screw_hole_resolution());
	 	}
	}
}

/**
 * Creates the lower foot assembly by rendering it from scratch. This module is not to be called externally, use 
 * foot() instead.
 */
module _render_foot_rail() {
	color_printed_outer_frame()
		render() {
			difference() {
				union() {
					// add a block to hold the MakerSlide extrusion, but without the holes for now
					translate([-frame_wall_thickness(), -_foot_rail_vertical_width()/2, 0])
						cube([_foot_rail_vertical_depth(), _foot_rail_vertical_width(), _foot_rail_vertical_height()]);
					// add blocks to hold the V-Slot extrusions, restricted to the specified wall depth in negative Y
					difference() {
						union() {
							rotate([0, 0, 30])
								translate([0, _foot_rail_horizontal_left_y_offset(), 0])
									_foot_rail_horizontal_leg(right = false);
							rotate([0, 0, -30])
								translate([0, _foot_rail_horizontal_right_y_offset(), 0])
									_foot_rail_horizontal_leg(right = true);
						}
						translate([-vslot_2020_depth()-frame_wall_thickness(), -makerslide_width(), 0])
							cube([vslot_2020_depth(), 2*makerslide_width(), _foot_rail_horizontal_height()]);
					}
				}

				// minus the hole for the MakerSlide extrusion
				makerslide_punch(foot_rail_makerslide_recess_depth());

				// minus the screw holes on the back
				translate([-frame_wall_thickness()/2, -makerslide_slot_offset(), foot_rail_vertical_back_screw_height()])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
								 center = true, $fn = frame_screw_hole_resolution());
				translate([-frame_wall_thickness()/2, makerslide_slot_offset(), foot_rail_vertical_back_screw_height()])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
								 center = true, $fn = frame_screw_hole_resolution());

				// minus the screw holes on the side
				translate([makerslide_slot_offset(), 0, _foot_rail_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_size(), h = 2*_foot_rail_vertical_width(), 
								 center = true, $fn = frame_screw_hole_resolution());

				// minus an additional inset so that the side screws can rest on a perpendicular surface
				_inset_depth = 100;
				translate([makerslide_slot_offset(), _foot_rail_vertical_side_screw_y_offset() + _inset_depth/2, _foot_rail_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_head_size(), h = _inset_depth, 
								 center = true, $fn = frame_screw_hole_resolution());
				translate([makerslide_slot_offset(), -_foot_rail_vertical_side_screw_y_offset() - _inset_depth/2, _foot_rail_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_head_size(), h = _inset_depth, 
								 center = true, $fn = frame_screw_hole_resolution());				
			}

			// plus the foot plate
			_foot_rail_bottom_plate();

			// plus the blocks to hold the T-Slot nut on the outer sides
			translate([(makerslide_base_depth() - t_slot_nut_holder_width()) / 2, 
				       makerslide_base_width() / 2 - t_slot_nut_holder_depth() + makerslide_clearance(), 
				       0])
				cube([t_slot_nut_holder_width(), t_slot_nut_holder_depth(), _foot_rail_t_slot_nut_holder_height()]);
			translate([(makerslide_base_depth() - t_slot_nut_holder_width()) / 2, 
				       -makerslide_base_width() / 2 - makerslide_clearance(), 
				       0])
				cube([t_slot_nut_holder_width(), t_slot_nut_holder_depth(), _foot_rail_t_slot_nut_holder_height()]);
	
			// plus the blocks to hold the T-Slot nut on the back sides
			translate([-makerslide_clearance(), 
				       -makerslide_slot_offset() - t_slot_nut_holder_width()/2, 
				       0])
				cube([t_slot_nut_holder_depth(), t_slot_nut_holder_width(), _foot_rail_t_slot_nut_holder_height()]);
			translate([-makerslide_clearance(), 
				       +makerslide_slot_offset() - t_slot_nut_holder_width()/2,
				       0])
				cube([t_slot_nut_holder_depth(), t_slot_nut_holder_width(), _foot_rail_t_slot_nut_holder_height()]);
	
		} 
}

/**
 * Main module to use the pre-rendered lower foot. The assembly is centered on the Z axis in Y direction for easier 
 * manipulation, similar to the MakerSlide extrusion. 
 */
module foot_rail() {
	bom_entry(section = "Printed Parts", description = "Frame", size = "Foot (Rail Version)");
	color_printed_outer_frame()
		import(file = "foot_rail.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module foot_rail_hardware(vertical_side_screws = true, vertical_back_screws = false, horizontal_side_screws = true, horizontal_top_screws = false) {

	// vertical MakerSlide rail -- back 
	if (vertical_back_screws) {
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4), 
			       -makerslide_slot_offset(), 
			       foot_rail_vertical_back_screw_height()]) {
			washer(size = M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4) - epsilon(), 
			       -makerslide_slot_offset(), 
			       foot_rail_vertical_back_screw_height()]) {
			screw(size = M4, length = 8);
			nut_tslot(M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4),
		           makerslide_slot_offset(), 
		           foot_rail_vertical_back_screw_height()]) {
			washer(size = M4);
		}
		translate([-frame_wall_thickness() - epsilon() - washer_thickness(M4) - epsilon(),
		           makerslide_slot_offset(), 
		           foot_rail_vertical_back_screw_height()]) {
			screw(size = M4, length = 8);
			nut_tslot(M4);
		}
	}

	// vertical MakerSlide rail -- sides
	if (vertical_side_screws) {
		_side_screw_y = _foot_rail_vertical_side_screw_y_offset() + epsilon();
		translate([makerslide_slot_offset(), 
			       _side_screw_y + washer_thickness(M4), 
			       _foot_rail_vertical_side_screw_height()]) 
			rotate([0, 0, -90]) {
				washer(size = M4);
			}
		translate([makerslide_slot_offset(), 
			       _side_screw_y + washer_thickness(M4) + epsilon(), 
			       _foot_rail_vertical_side_screw_height()]) 
			rotate([0, 0, -90]) {
				screw(size = M4, length = 12);
				nut_tslot(M4);
			}
		translate([makerslide_slot_offset(), 
			       -_side_screw_y - washer_thickness(M4) - epsilon(), 
			       _foot_rail_vertical_side_screw_height()]) 
			rotate([0, 0, 90]) {
				screw(size = M4, length = 12);
				nut_tslot(M4);
			}
		translate([makerslide_slot_offset(), 
			       -_side_screw_y - washer_thickness(M4), 
			       _foot_rail_vertical_side_screw_height()]) 
			rotate([0, 0, 90]) {
				washer(size = M4);
			}
	}

	// left horizontal leg
	rotate([0, 0, 30])
		translate([0, _foot_rail_horizontal_left_y_offset(), 0])
			_foot_rail_horizontal_leg_hardware(right = false, 
				                               side_screw = horizontal_side_screws, 
				                               top_screw = horizontal_top_screws);


	// right horizontal leg
	rotate([0, 0, -30])
		translate([0, _foot_rail_horizontal_right_y_offset(), 0])
			_foot_rail_horizontal_leg_hardware(right = true, 
				                               side_screw = horizontal_side_screws, 
				                               top_screw = horizontal_top_screws);

}

_render_foot_rail();