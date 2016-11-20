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
use <../parts/printed/carriage.scad>
use <../parts/printed/end_switch_bracket.scad>
use <../parts/printed/foot.scad>
use <../parts/printed/head.scad>
use <../parts/printed/motor_bracket.scad>
use <../parts/printed/tensioner.scad>
use <../parts/vitamins/vitamins.scad>

/**
 * Provides access to the assembly.
 */
module vertical_axis_assembly(position = [0, 0, 0], angle = 0) {
	translate(position)
		rotate([0, 0, angle])
			_vertical_axis_assembly();
}

/** 
 * The module that actually renders the assembly. 
 * This module is not intended to be called outside of this file.
 */
module _vertical_axis_assembly() {
	// the vertical MakerSlide extrusion
	makerslide_vertical_rail();

	// the foot with associated hardware
	foot();
	foot_hardware();

	// the motor bracket with the stepper and the associated hardware
	translate([0, 0, motor_bracket_z_offset()]) {
		motor_bracket();
		motor_bracket_hardware();
		motor_bracket_stepper(with_pulley = true);
		motor_bracket_stepper_hardware();
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
		end_switch_bracket_hardware(screw_position = 15);
	}

	// the belt for this axis
	_belt_length = belt_center_distance();
	translate([makerslide_depth() + vmotor_gt2_belt_rail_distance(), 0, vmotor_z_offset() + _belt_length])
			rotate([0, 90, 0])
				gt2_belt_loop(length = _belt_length, 
					inner_diameter_end2 = gt2_pulley_inner_diameter_min(), 
					inner_diameter_end1 = gt2_pulley_inner_diameter_min());// bearing_f623zz_outer_diameter());

	// TODO make the carriage position dynamic
	_carriage_z = 640;
	translate([carriage_x_offset(), 0, _carriage_z]) {
		carriage();
		carriage_hardware();
	}

}

// render the axis to a separate output file if requested
_vertical_axis_assembly();