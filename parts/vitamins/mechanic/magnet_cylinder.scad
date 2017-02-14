/**********************************************************************************************************************
 **
 ** parts/vitamins/mechanic/magnet_cylinder.scad
 **
 ** This file renders a cylindrical magnet for the IR sensor.
 **
 **********************************************************************************************************************/

include <../../../conf/part_sizes.scad>
include <../../../conf/derived_sizes.scad>

$fn = 96;
cylinder(d = escher_ir_sensor_magnet_diameter(),
	     h = escher_ir_sensor_magnet_height());
