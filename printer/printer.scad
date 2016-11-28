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
use <../assemblies/horizontal_front.scad>
use <../assemblies/horizontal_left.scad>
use <../assemblies/horizontal_right.scad>


module printer_model(head_position = [00, 0, 10]) {

	_point = convert_relative_point_to_absolute(head_position);
	echo(_point = _point);

	_angle_rails = angle_rails();
	_pos_rails   = position_rails();

	_distances = [
		arm_target_base_distance(rail = _pos_rails[A], point = _point), 
		arm_target_base_distance(rail = _pos_rails[B], point = _point),
		arm_target_base_distance(rail = _pos_rails[C], point = _point)
	];
	_angles_phi = [
		arm_target_base_angle(rail = _pos_rails[A], rail_angle = _angle_rails[A], point = _point), 
		arm_target_base_angle(rail = _pos_rails[B], rail_angle = _angle_rails[B], point = _point),
		arm_target_base_angle(rail = _pos_rails[C], rail_angle = _angle_rails[C], point = _point) 
	];

	_heights = [
		arm_target_upper_height(rail = _pos_rails[A], point = _point), 
		arm_target_upper_height(rail = _pos_rails[B], point = _point),
		arm_target_upper_height(rail = _pos_rails[C], point = _point) 
	];



	echo(_angle_rails = _angle_rails);
	echo(_pos_rails = _pos_rails);
	echo(_distances = _distances);
	echo(_angles_phi = _angles_phi);
	echo(_heights = _heights); 


 

	_carriage_heights = [500, 550, 450];

	// place the three axis assemblies
	vertical_axis_assembly(position        = _pos_rails[A], 
						   angle           = _angle_rails[A], 
						   carriage_height = _carriage_heights[A],
						   arm_theta       = 30,
						   arm_phi         = _angles_phi[A]);
	vertical_axis_assembly(position        = _pos_rails[B], 
						   angle           = _angle_rails[B], 
						   carriage_height = _carriage_heights[B],
						   arm_theta       = 30,
						   arm_phi         = _angles_phi[B]);
	vertical_axis_assembly(position        = _pos_rails[C], 
						   angle           = _angle_rails[C], 
						   carriage_height = _carriage_heights[C],
						   arm_theta       = 30,
						   arm_phi         = _angles_phi[C]);

	// place the horizontal parts
	horizontal_front_assembly(position = position_front_assembly(), angle =   0, with_connectors = false);
	horizontal_left_assembly( position = position_left_assembly(),  angle =  60, with_connectors = false);
	horizontal_right_assembly(position = position_right_assembly(), angle = -60, with_connectors = false);


}