/**********************************************************************************************************************
 **
 ** assemblies/vertical_axis.scad
 **
 ** This file renders and provides the entire vertical axis assembly with all brackets, motors and whatever is 
 ** attached to it. 
 ** This assembly can be rendered into an STL file; however, for further construction of the model, that rendered
 ** version is NOT used because all the color information would be lost.
 **
 **********************************************************************************************************************/

include <../conf/colors.scad>
include <../conf/derived_sizes.scad>
include <../conf/part_sizes.scad>

use <../parts/extrusions/makerslide.scad>
use <../parts/printed/bed_bracket.scad>
use <../parts/printed/carriage.scad>
use <../parts/printed/end_switch_bracket.scad>
use <../parts/printed/foot_plate.scad>
use <../parts/printed/foot_rail.scad>
use <../parts/printed/foot_norail.scad>
use <../parts/printed/head.scad>
use <../parts/printed/magnet_holder_carriage.scad>
use <../parts/printed/magnet_holder_effector.scad>
use <../parts/printed/motor_bracket.scad>
use <../parts/printed/tensioner.scad>
use <../parts/sheets/enclosure_short_side.scad>
use <../parts/vitamins/vitamins.scad>


/**
 * Provides access to the assembly.
 * theta = the angle of the arms in the vertical plane; 0 = straight down, 90 = horizontal
 * phi = the angle of the arms in the horizontal plane; 0 = along the X axis, positive values counter-clockwise
 */
module vertical_axis_assembly(angle = 0, carriage_height = 500, arm_theta = 45, arm_phi = 45) {
	rotate([0, 0, angle])
		translate([-horizontal_distance_center_corner(), 0, 0])
			_vertical_axis_assembly(carriage_height, arm_theta, arm_phi);
}

/** 
 * Renders the components that stay in a fixed position.
 */
module _vertical_axis_fixed_components() {
	// the vertical MakerSlide extrusion
	makerslide_vertical_rail();

	// the foot with associated hardware
	if (foot_with_rail()) {
		foot_rail();
		foot_rail_hardware();
		// the foot plate beneath the foot bracket
		translate([foot_plate_x_offset(), 0, foot_plate_z_offset()]) {
			foot_plate();
			foot_plate_hardware();
		}
	} else {
		foot_norail();
		foot_norail_hardware();		
	}

	// the motor bracket with the stepper and the associated hardware
	translate([0, 0, motor_bracket_z_offset()]) {
		motor_bracket();
		motor_bracket_hardware();
		motor_bracket_stepper(with_pulley = true);
		motor_bracket_stepper_hardware();
	}

	// the bed bracket with the associated hardware
	translate([0, 0, bed_bracket_z_offset()]) {
		bed_bracket();
		bed_bracket_hardware();
	}

	// the head with associated hardware
	translate([0, 0, head_z_offset()]) {
		head();
		head_hardware();
	}

	// the tensioner and the associated hardware
	translate([tensioner_x_offset(), 0, vertical_extrusion_length() - tensioner_z_offset()]) {
		tensioner();
		tensioner_hardware(screw_position = tensioner_screw_position());
	}

	// the end switch assembly
	translate([end_switch_bracket_x_offset(), end_switch_bracket_y_offset(), 
		       vertical_extrusion_length() - end_switch_bracket_z_offset()]) {
		end_switch_bracket();
		end_switch_bracket_hardware();
	}

	// the belt for this axis
	_belt_length = belt_center_distance();
	translate([makerslide_depth() + vmotor_gt2_belt_rail_distance(), 0, vmotor_z_offset() + _belt_length])
			rotate([0, 90, 0])
				gt2_belt_loop(length = _belt_length, 
					inner_diameter_end2 = gt2_pulley_inner_diameter_min(), 
					inner_diameter_end1 = gt2_pulley_inner_diameter_min());// bearing_f623zz_outer_diameter());

	// the enclosure plate mounted to the vertical rail
	translate([-enclosure_short_side_thickness() - enclosure_insulation_thickness() - frame_wall_thickness() - epsilon(), 0, 0]) {
		enclosure_short_side_plate();
		enclosure_short_side_plate_hardware();
	}

}

/**
 * Renders the mobile components of the carriage.
 */
module _vertical_axis_carriage(carriage_height = 500) {
	translate([carriage_x_offset(), 0, carriage_height]) {
		// the carriage with associated hardware
		carriage();
		carriage_hardware();
	}
}

/** 
 * The module that actually renders arms. 
 * This module is not intended to be called outside of this file.
 */
module _vertical_axis_arm() {
	magnet_holder_carriage();
	magnet_holder_carriage_hardware();
	translate([0, 0, -(arm_rod_length() + magnet_holder_rod_distance(magnet_holder_top_ball_clearance()))])
		rod();
	translate([0, 0, -(arm_rod_length() + magnet_holder_rod_distance(magnet_holder_top_ball_clearance())
		                                + magnet_holder_rod_distance(magnet_holder_bottom_ball_clearance()))])
		rotate([0, 180, 0]) {
			magnet_holder_effector();
			magnet_holder_effector_hardware();
		}
}


/** 
 * The module that actually renders the assembly. 
 * This module is not intended to be called outside of this file.
 */
module _vertical_axis_assembly(carriage_height = 500, arm_theta = 25, arm_phi = -45) {
	_vertical_axis_fixed_components();
	_vertical_axis_carriage(carriage_height);

	translate([carriage_x_offset(), 0, carriage_height]) {
		translate(carriage_ball_position(left = true)) {
			rotate([0, -arm_theta, arm_phi])
				_vertical_axis_arm();	
		}
		translate(carriage_ball_position(left = false)) {
			rotate([0, -arm_theta, arm_phi]) 
				_vertical_axis_arm();	
		}
	}
}

// render the axis to a separate output file if requested
_vertical_axis_assembly();