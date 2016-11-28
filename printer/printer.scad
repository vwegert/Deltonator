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


module printer_model(head_position = [0, 50, 40]) {

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


}