/**********************************************************************************************************************
 **
 ** printer/printer.scad
 **
 ** This file contains the code that combines the various assemblies into a printer model. It is not intended
 ** to be rendered itself; instead, it is used by other files in this directory.
 **
 **********************************************************************************************************************/

include <../conf/colors.scad>
include <../conf/derived_sizes.scad>
include <../conf/part_sizes.scad>

use <../assemblies/vertical_axis.scad>
use <../assemblies/horizontal_side.scad>
use <../parts/printed/effector_base.scad>


module printer_model(head_position = [0, -50, 0]) {

	// place the three axis assemblies
	vertical_axis_assembly(angle           = angle_rail(A), 
						   carriage_height = arm_carriage_height(axis = A, point = head_position),
						   arm_theta       = arm_angle_theta(axis = A, point = head_position),
						   arm_phi         = arm_angle_phi(axis = A, point = head_position));

	vertical_axis_assembly(angle           = angle_rail(B), 
						   carriage_height = arm_carriage_height(axis = B, point = head_position),
						   arm_theta       = arm_angle_theta(axis = B, point = head_position),
						   arm_phi         = arm_angle_phi(axis = B, point = head_position));

	vertical_axis_assembly(angle           = angle_rail(C), 
						   carriage_height = arm_carriage_height(axis = C, point = head_position),
						   arm_theta       = arm_angle_theta(axis = C, point = head_position),
						   arm_phi         = arm_angle_phi(axis = C, point = head_position));

	// place the horizontal parts
	horizontal_assembly(side  = A, 
		                angle = angle_rail(A));

	horizontal_assembly(side  = B, 
		                angle = angle_rail(B));

	horizontal_assembly(side  = C, 
		                angle = angle_rail(C));

	// place the effector
	translate([0, 0, bed_working_height() + effector_tool_height()])
		translate(head_position) {
			effector_base();
			effector_base_hardware();
			effector_base_dummy_tool();
		}

	_ball_plane_distance_corner_point_A = ball_plane_distance_corner_point(axis = A, point = head_position);
	echo(_ball_plane_distance_corner_point_A = _ball_plane_distance_corner_point_A);
	_ball_plane_distance_corner_point_B = ball_plane_distance_corner_point(axis = B, point = head_position);
	echo(_ball_plane_distance_corner_point_B = _ball_plane_distance_corner_point_B);
	_ball_plane_distance_corner_point_C = ball_plane_distance_corner_point(axis = C, point = head_position);
	echo(_ball_plane_distance_corner_point_C = _ball_plane_distance_corner_point_C);

	_ball_plane_angle_corner_point_absolute_A = ball_plane_angle_corner_point_absolute(axis = A, point = head_position);
	echo(_ball_plane_angle_corner_point_absolute_A = _ball_plane_angle_corner_point_absolute_A);
	_ball_plane_angle_corner_point_absolute_B = ball_plane_angle_corner_point_absolute(axis = B, point = head_position);
	echo(_ball_plane_angle_corner_point_absolute_B = _ball_plane_angle_corner_point_absolute_B);
	_ball_plane_angle_corner_point_absolute_C = ball_plane_angle_corner_point_absolute(axis = C, point = head_position);
	echo(_ball_plane_angle_corner_point_absolute_C = _ball_plane_angle_corner_point_absolute_C);

	// translate([head_position[0], head_position[1], 0])
		// cylinder(r = effector_base_center_long_edge_distance(), h = 120, $fn = 96);

	// translate(ball_plane_position(axis = A)) 
		// rotate([0, 0, ball_plane_angle_corner_point_absolute(axis = A, point = head_position)])
		// 	translate([-ball_plane_distance_corner_point(axis = A, point = head_position), 0, 0])
				// #cylinder(r = ball_plane_distance_corner_effector(axis = A, point = head_position), h = 800);
	

// function ball_plane_angle_corner_point_absolute(axis = A, point = [0, 0]) =


	// dummy printer build surface - this will be relocated later on
	// color("Salmon")
	// 	translate([0, 0, bed_working_height() - 5])
	// 		cylinder(d = 330, h = 5, $fn = 96);
}