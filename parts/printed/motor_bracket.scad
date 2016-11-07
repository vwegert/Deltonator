/**********************************************************************************************************************
 **
 ** parts/printed/motor_bracket.scad
 **
 ** This file constructs the bracket that holds the axis stepper motors to the vertical extrusions.
 ** To assemble the printer, you need three of these parts.
 **
 **********************************************************************************************************************/

use <../../bom/bom.scad>
use <../../conf/colors.scad>
use <../../conf/derived_sizes.scad>
use <../../conf/part_sizes.scad>
use <../../lib/nutsnbolts/nutsnbolts.scad>
use <../../lib/MCAD/MCAD.scad>
use <../../parts/extrusions/makerslide.scad>

/**
 * The dimensions of the bracket part that fits onto the MakerSlide extrusion.
 */
function _motor_bracket_outer_height() = motor_bracket_height();
function _motor_bracket_outer_width()  = frame_wall_thickness() + makerslide_width() + frame_wall_thickness();
function _motor_bracket_outer_depth()  = frame_wall_thickness() + makerslide_depth() + frame_wall_thickness();

/**
 * The position of the plate that holds the motor.
 */
function _motor_bracket_plate_x() = makerslide_depth() + vmotor_rail_distance() - frame_wall_thickness();
function _motor_bracket_plate_y() = -vmotor_width() / 2;
function _motor_bracket_plate_z() = -abs((vmotor_height() - motor_bracket_height())) / 2;

function _motor_bracket_plate_screw_dist_y() = (vmotor_width() - vmotor_screw_distance()) / 2;
function _motor_bracket_plate_screw_dist_z() = (vmotor_height() - vmotor_screw_distance()) / 2;

/**
 * Some internal screw positions.
 */
function _motor_bracket_screw_z() = _motor_bracket_outer_height()/2;

/**
 * Renders a block that can be fixed to the vertical MakerSlide extrusion. 
 * Not to be used outside of this file.
 */
module _motor_bracket_rail_fixture() {
	difference() {
		// a block to hold the MakerSlide extrusion
		translate([-frame_wall_thickness(), -_motor_bracket_outer_width()/2, 0])
			cube([_motor_bracket_outer_depth(), _motor_bracket_outer_width(), _motor_bracket_outer_height()]);
		// minus the hole for the MakerSlide extrusion
		makerslide_punch(_motor_bracket_outer_height());
		// minus the screw holes on the back
		translate([-frame_wall_thickness()/2, -makerslide_slot_offset(), _motor_bracket_screw_z()])
			rotate([0, 90, 0])
				cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
						 center = true, $fn = frame_screw_hole_resolution());
		translate([-frame_wall_thickness()/2, makerslide_slot_offset(), _motor_bracket_screw_z()])
			rotate([0, 90, 0])
				cylinder(d = frame_screw_size(), h = 2*frame_wall_thickness(), 
						 center = true, $fn = frame_screw_hole_resolution());
		// minus the screw holes on the side
		translate([makerslide_slot_offset(), 0, _motor_bracket_screw_z()])
			rotate([90, 0, 0])
				cylinder(d = frame_screw_size(), h = 2*_motor_bracket_outer_width(), 
						 center = true, $fn = frame_screw_hole_resolution());
	}
}

/**
 * Renders the plate that the motor is fixed to.
 * Not to be used outside of this file.
 */
module _motor_bracket_plate() {
	difference() {
		// the base plate itself 
		hull() {
			translate([0, motor_bracket_edge_radius(), motor_bracket_edge_radius()])
				rotate([0, 90, 0])
					cylinder(r = motor_bracket_edge_radius(), h = frame_wall_thickness(), 
						$fn = motor_bracket_edge_resolution());
			translate([0, vmotor_width() - motor_bracket_edge_radius(), motor_bracket_edge_radius()])
				rotate([0, 90, 0])
					cylinder(r = motor_bracket_edge_radius(), h = frame_wall_thickness(), 
						$fn = motor_bracket_edge_resolution());
			translate([0, motor_bracket_edge_radius(), vmotor_height() - motor_bracket_edge_radius()])
				rotate([0, 90, 0])
					cylinder(r = motor_bracket_edge_radius(), h = frame_wall_thickness(), 
						$fn = motor_bracket_edge_resolution());
			translate([0, vmotor_width() - motor_bracket_edge_radius(), vmotor_height() - motor_bracket_edge_radius()])
				rotate([0, 90, 0])
					cylinder(r = motor_bracket_edge_radius(), h = frame_wall_thickness(), 
						$fn = motor_bracket_edge_resolution());
		}
		// minus the hole in the center 
		translate([0, vmotor_width()/2, vmotor_height()/2])
			rotate([0, 90, 0])
				cylinder(d = vmotor_mounting_hole_diameter(), h = frame_wall_thickness() + 1, // artifact removal
					$fn = vmotor_mounting_hole_resolution());
		// minus the screw holes
		translate([0, _motor_bracket_plate_screw_dist_y(), _motor_bracket_plate_screw_dist_z()])
			rotate([0, 90, 0])
				cylinder(d = vmotor_screw_size(), h = frame_wall_thickness() + 1, // artifact removal
					$fn = frame_screw_hole_resolution());
		translate([0, vmotor_width() - _motor_bracket_plate_screw_dist_y(), _motor_bracket_plate_screw_dist_z()])
			rotate([0, 90, 0])
				cylinder(d = vmotor_screw_size(), h = frame_wall_thickness() + 1, // artifact removal
					$fn = frame_screw_hole_resolution());
		translate([0, _motor_bracket_plate_screw_dist_y(), vmotor_height() - _motor_bracket_plate_screw_dist_z()])
			rotate([0, 90, 0])
				cylinder(d = vmotor_screw_size(), h = frame_wall_thickness() + 1, // artifact removal
					$fn = frame_screw_hole_resolution());
		translate([0, vmotor_width() - _motor_bracket_plate_screw_dist_y(), vmotor_height() - _motor_bracket_plate_screw_dist_z()])
			rotate([0, 90, 0])
				cylinder(d = vmotor_screw_size(), h = frame_wall_thickness() + 1, // artifact removal
					$fn = frame_screw_hole_resolution());

	}
}

/**
 * Renders a solid part that connects the rail fixture and the motor plate.
 * Not to be used outside of this file.
 */
module _motor_bracket_plate_connector() {
	_connector_width  = frame_wall_thickness();
	_connector_height = min(_motor_bracket_outer_height(), vmotor_height() - 2*motor_bracket_edge_radius());
	_connector_depth  = vmotor_rail_distance() - frame_wall_thickness();
	translate([0, -_connector_width/2, 0])
		cube([_connector_depth, _connector_width, _connector_height]);
}

/**
 * Creates the motor bracket assembly by rendering it from scratch. This module is not to be called externally, use 
 * motor_bracket() instead.
 */
module _render_motor_bracket() {
	color_printed_inner_frame()
		render() {
			// add the part of the bracket that is fixed to the vertical axis
			_motor_bracket_rail_fixture();
			// add the plate that will hold the NEMA17 stepper motor
			translate([_motor_bracket_plate_x(), _motor_bracket_plate_y(), _motor_bracket_plate_z()])
				_motor_bracket_plate();
			// add the connectors between the bracket and the plate#
			_connector_x = makerslide_depth() + frame_wall_thickness();
			_connector_offset_y = vmotor_width() / 2 - frame_wall_thickness() / 2;
			translate([_connector_x, _connector_offset_y, 0])
				_motor_bracket_plate_connector();
			translate([_connector_x, -_connector_offset_y, 0])
				_motor_bracket_plate_connector();
		}
}

/**
 * Main module to use the pre-rendered motor bracket . The assembly is centered on the Z axis in Y direction for easier 
 * manipulation, similar to the MakerSlide extrusion. 
 */
module motor_bracket(render = false) {
	bom_entry(section = "Printed Parts", description = "Frame", size = "Motor Bracket");
	color_printed_inner_frame()
		import(file = "motor_bracket.stl");
}

/**
 * Places the stepper motor and - if requested - the pulley in the correct position.
 */
module motor_bracket_stepper(with_pulley = true) {
	translate([makerslide_depth() + vmotor_rail_distance(), 0, motor_bracket_height() / 2]) 
		rotate([0, 0, 180])
			stepper_medium(17);
	// TODO add pulley
	// if (with_pulley) {
	// 	translate([makerslide_depth() + gt2_pulley_rail_distance(), 0, motor_z_offset()]) 
	// 		rotate([0, 0, 180])
	// 			gt2_pulley_20t_5mm();
	// }
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module motor_bracket_hardware() {
	// vertical MakerSlide rail -- back 
	translate([-frame_wall_thickness(), -makerslide_slot_offset(), _motor_bracket_screw_z()]) {
		screw_m5(8);
		nut_tslot_m5();
	}
	translate([-frame_wall_thickness(), makerslide_slot_offset(), _motor_bracket_screw_z()]) {
		screw_m5(8);
		nut_tslot_m5();
	}
	// vertical MakerSlide rail -- sides
	_side_screw_y = makerslide_width() / 2 + frame_wall_thickness();
	translate([makerslide_slot_offset(), _side_screw_y, _motor_bracket_screw_z()]) 
		rotate([0, 0, -90]) {
			screw_m5(12);
			nut_tslot_m5();
		}
	translate([makerslide_slot_offset(), -_side_screw_y, _motor_bracket_screw_z()]) 
		rotate([0, 0, 90]) {
			screw_m5(12);
			nut_tslot_m5();
		}
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the stepper motor to the bracket.
 */
module motor_bracket_stepper_hardware() {
	translate([_motor_bracket_plate_x(), _motor_bracket_plate_y(), _motor_bracket_plate_z()]) {
		translate([0, _motor_bracket_plate_screw_dist_y(), _motor_bracket_plate_screw_dist_z()])
			screw_m3(6);
		translate([0, vmotor_width() - _motor_bracket_plate_screw_dist_y(), _motor_bracket_plate_screw_dist_z()])
			screw_m3(6);
		translate([0, _motor_bracket_plate_screw_dist_y(), vmotor_height() - _motor_bracket_plate_screw_dist_z()])
			screw_m3(6);
		translate([0, vmotor_width() - _motor_bracket_plate_screw_dist_y(), vmotor_height() - _motor_bracket_plate_screw_dist_z()])
			screw_m3(6);
	}
}

_render_motor_bracket();
