/**********************************************************************************************************************
 **
 ** printer/printer_plate_test.scad
 **
 ** This file constructs the a version of the printer with some plate models for dimension cross-checking
 **
 **********************************************************************************************************************/

use <printer.scad>

printer_model(head_position = [build_area_max_radius(), 0, 0]);

// top/bottom plate
_tb_depth = 520;
_tb_width = 600;
color("Green")
	translate([-_tb_depth*0.575, -_tb_width/2, -5])
		cube([_tb_depth, _tb_width, 10]);

// working plate
_wp_depth = 350;
_wp_width = 400;
color("Red")
	translate([-_wp_depth*0.5, -_wp_width/2, 15])
		cube([_wp_depth, _wp_width, 10]);
