/**********************************************************************************************************************
 **
 ** parts/printed/foot.scad
 **
 ** This file constructs the lower foot of the printer frame. To assemble the printer, you need three of these parts.
 **
 **********************************************************************************************************************/

use <../../bom/bom.scad>
use <../../conf/colors.scad>
use <../../conf/derived_sizes.scad>
use <../../conf/part_sizes.scad>
use <../../parts/extrusions/makerslide.scad>
use <../../parts/extrusions/vslot_2020.scad>
use <../../parts/vitamins/screws.scad>
use <../../parts/vitamins/steppers.scad>

// The dimensions of the horizontal parts that hold the V-Slot extrusions.
function _foot_horizontal_height() = vslot_2020_depth() + frame_wall_thickness();
function _foot_horizontal_width()  = vslot_2020_width() + frame_wall_thickness();
function _foot_horizontal_depth()  = horizontal_extrusion_offset() + horizontal_recess_depth();
function _foot_horizontal_left_y_offset() = -frame_wall_thickness() + horizontal_extrusion_outward_offset();
function _foot_horizontal_right_y_offset() = -_foot_horizontal_width() - horizontal_extrusion_outward_offset() + frame_wall_thickness();

// The dimensions of the vertical part that holds the MakerSlide extrusion.
function _foot_vertical_height() = vertical_recess_depth();
function _foot_vertical_width()  = frame_wall_thickness() + makerslide_width() + frame_wall_thickness();
function _foot_vertical_depth()  = frame_wall_thickness() + makerslide_depth() + frame_wall_thickness();
function _foot_vertical_back_screw_height() = frame_wall_thickness() + vertical_recess_depth()/2;
function _foot_vertical_side_screw_height() = _foot_horizontal_height()/2; // align with other screw
function _foot_vertical_side_screw_y_offset() = _foot_vertical_width()/2 + 1;

// TODO add some holes to screw the foot to a flat surface
// TODO add the possibility to add a variable foot for height adjustment / leveling

/**
 * Auxiliary module that creates one of the vertical legs. Not to be used outside of this file.
 */
module _foot_horizontal_leg(right = false) { 
	difference() {
		// the basic shape of the leg
		cube([_foot_horizontal_depth(), _foot_horizontal_width(), _foot_horizontal_height()]);
		// minus the recess for the horizontal extrusion
		translate([horizontal_extrusion_offset(), right ? 0 : frame_wall_thickness(), vslot_2020_depth()])
			rotate([0, 90, 0])
				vslot_2020_punch(horizontal_recess_depth());
		// minus the screw hole on the inside
		_screw_x = _foot_horizontal_depth()-horizontal_screw_distance();
		translate([_screw_x, _foot_horizontal_width()/2, vslot_2020_depth()/2])
			rotate([90, 0, 0])
				cylinder(d = frame_screw_size(), h = _foot_horizontal_width(), 
		                 center = true, $fn = frame_screw_hole_resolution());
		// minus the screw hole on the top side
		translate([_screw_x, vslot_2020_depth()/2 + (right ? 0 : frame_wall_thickness()), _foot_horizontal_height() - frame_wall_thickness()])
				cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
		                 center = true, $fn = frame_screw_hole_resolution());
	}
}

/**
 * Auxiliary module that creates the hardware for one of the vertical legs. Not to be used outside of this file.
 */
module _foot_horizontal_leg_hardware(right = false) { 
	_screw_x = _foot_horizontal_depth()-horizontal_screw_distance();
	// inner screw
	translate([_screw_x, right ? _foot_horizontal_width() : 0, vslot_2020_depth()/2])
		rotate([0, 0, right ? -90 : 90]) {
			screw_m5(8);
			nut_tslot_m5();
		}
	// top screw
	translate([_screw_x, vslot_2020_depth()/2 + (right ? 0 : frame_wall_thickness()), _foot_horizontal_height()])
		rotate([0, 90, 0]) {
			screw_m5(8);
			nut_tslot_m5();
		}
}

/**
 * Creates the lower foot assembly by rendering it from scratch. This module is not to be called externally, use 
 * foot() instead.
 */
module _render_foot() {
	color_printed_outer_frame()
		render() {
			difference() {
				union() {
					// add a block to hold the MakerSlide extrusion, but without the holes for now
					translate([-frame_wall_thickness(), -_foot_vertical_width()/2, 0])
						cube([_foot_vertical_depth(), _foot_vertical_width(), _foot_vertical_height()]);
					// add blocks to hold the V-Slot extrusions, restricted to the specified wall depth in negative Y
					difference() {
						union() {
							rotate([0, 0, 30])
								translate([0, _foot_horizontal_left_y_offset(), 0])
									_foot_horizontal_leg(right = false);
							rotate([0, 0, -30])
								translate([0, _foot_horizontal_right_y_offset(), 0])
									_foot_horizontal_leg(right = true);
						}
						translate([-vslot_2020_depth()-frame_wall_thickness(), -makerslide_width(), 0])
							cube([vslot_2020_depth(), 2*makerslide_width(), _foot_horizontal_height()]);
					}
				}
				// minus the hole for the MakerSlide extrusion
				makerslide_punch(vertical_recess_depth());
				// minus the screw holes on the back
				translate([-frame_wall_thickness()/2, -makerslide_slot_offset(), _foot_vertical_back_screw_height()])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
								 center = true, $fn = frame_screw_hole_resolution());
				translate([-frame_wall_thickness()/2, makerslide_slot_offset(), _foot_vertical_back_screw_height()])
					rotate([0, 90, 0])
						cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
								 center = true, $fn = frame_screw_hole_resolution());
				// minus the screw holes on the side
				translate([makerslide_slot_offset(), 0, _foot_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_size(), h = 2*_foot_vertical_width(), 
								 center = true, $fn = frame_screw_hole_resolution());
				// minus an additional inset so that the side screws can rest on a perpendicular surface
				_inset_depth = 100;
				translate([makerslide_slot_offset(), _foot_vertical_side_screw_y_offset() + _inset_depth/2, _foot_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_head_size(), h = _inset_depth, 
								 center = true, $fn = frame_screw_hole_resolution());
				translate([makerslide_slot_offset(), -_foot_vertical_side_screw_y_offset() - _inset_depth/2, _foot_vertical_side_screw_height()])
					rotate([90, 0, 0])
						cylinder(d = frame_screw_head_size(), h = _inset_depth, 
								 center = true, $fn = frame_screw_hole_resolution());				
			}
		} 
}

/**
 * Main module to use the pre-rendered lower foot. The assembly is centered on the Z axis in Y direction for easier 
 * manipulation, similar to the MakerSlide extrusion. 
 */
module foot() {
	bom_entry(section = "Printed Parts", description = "Frame", size = "Foot");
	color_printed_outer_frame()
		import(file = "foot.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module foot_hardware() {

	// vertical MakerSlide rail -- back 
	translate([-frame_wall_thickness(), -makerslide_slot_offset(), _foot_vertical_back_screw_height()]) {
		screw_m5(8);
		nut_tslot_m5();
	}
	translate([-frame_wall_thickness(), makerslide_slot_offset(), _foot_vertical_back_screw_height()]) {
		screw_m5(8);
		nut_tslot_m5();
	}

	// vertical MakerSlide rail -- sides
	_side_screw_y = _foot_vertical_side_screw_y_offset();
	translate([makerslide_slot_offset(), _side_screw_y, _foot_vertical_side_screw_height()]) 
		rotate([0, 0, -90]) {
			screw_m5(12);
			nut_tslot_m5();
		}
	translate([makerslide_slot_offset(), -_side_screw_y, _foot_vertical_side_screw_height()]) 
		rotate([0, 0, 90]) {
			screw_m5(12);
			nut_tslot_m5();
		}

	// left horizontal leg
	rotate([0, 0, 30])
		translate([0, _foot_horizontal_left_y_offset(), 0])
			_foot_horizontal_leg_hardware(right = false);


	// right horizontal leg
	rotate([0, 0, -30])
		translate([0, _foot_horizontal_right_y_offset(), 0])
			_foot_horizontal_leg_hardware(right = true);

}

_render_foot();