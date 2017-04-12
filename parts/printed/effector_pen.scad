/**********************************************************************************************************************
 **
 ** parts/printed/effector_pen.scad
 **
 ** This file constructs a effector to hold a pen to draw onto something placed on the print bed.
 ** This part is supposed to be printed once for that hotend tyoe.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

use <effector_base.scad>
use <ir_sensor_housing.scad>

_block_width          = 17.0;
_block_height         = 12.0;
_block_back_depth     =  8.0;
_block_front_depth    = 18.0;
_block_wall_thickness =  3.0;
_block_hole_side      = sqrt( 2 * pow(_block_width / 2 - _block_wall_thickness, 2 ) );

/**
 * Renders the block below the base plate that holds the pen.
 */
module _effector_pen_holding_block() {
	difference() {
		// the block
		translate([-_block_back_depth, -_block_width/2, -_block_height]) 
			cube([_block_back_depth + _block_front_depth, _block_width, _block_height]);
		// minus the hole for the fixing screw
		translate([epsilon(), 0, -_block_height/2])
			rotate([0, 90, 0])
				cylinder(d = tap_base_diameter(M4),
						 h = _block_front_depth,
			 			 $fn = effector_base_resolution());
	}
}

/**
 * Renders the hole that is cut out of the plate to let the pen poke through.
 */
module _effector_pen_cutout() {
	// the rectangular hole
	rotate([0, 0, 45])
		translate([-_block_hole_side/2, -_block_hole_side/2, - _block_height - epsilon()])
			cube([_block_hole_side, _block_hole_side, effector_base_thickness() + _block_height+ 2 * epsilon()]);
}

/**
 * Renders the holes to mount the IR height sensor.
 */
module _effector_pen_ir_sensor() {
	// the hole to plug the wire though
	translate([-(effector_base_center_long_edge_distance() - escher_ir_sensor_cutout_distance_solder()), 
		       -escher_ir_sensor_cutout_width()/2, 
		       -epsilon()])
		cube([escher_ir_sensor_cutout_depth(), 
			  escher_ir_sensor_cutout_width(), 
			  effector_base_thickness() + 2 * epsilon()]);
	// the holes for the adjustment screws
	_hole_y_offset = escher_ir_sensor_housing_body_width() / 2 + escher_ir_sensor_magnet_diameter() / 2 + escher_ir_sensor_magnet_clearance();
	translate([-(effector_base_center_long_edge_distance() -  escher_ir_sensor_magnet_holder_depth()/2),
               -_hole_y_offset,
               -epsilon()])
		cylinder(d = tap_base_diameter(escher_ir_sensor_adjustment_screw_size()),
				 h = effector_base_thickness() + 2 * epsilon(),
				 $fn = effector_base_resolution());
	translate([-(effector_base_center_long_edge_distance() -  escher_ir_sensor_magnet_holder_depth()/2),
               _hole_y_offset,
               -epsilon()])
		cylinder(d = tap_base_diameter(escher_ir_sensor_adjustment_screw_size()),
				 h = effector_base_thickness() + 2 * epsilon(),
				 $fn = effector_base_resolution());
}

/**
 * Creates the effector assembly by rendering it from scratch. This module is not to be called externally, use 
 * effector_pen() instead.
 */
module _render_effector_pen() {
	color_printed_effector() 
		union() {
			difference() {
				union() {
					// the base plate
					effector_base();
					// plus the pen holder block
					_effector_pen_holding_block();	
				}
				// minus the cutout for the hotend in the center
				_effector_pen_cutout();
				// minus the mounting holes for the IR sensor
				_effector_pen_ir_sensor();
			}
		// TODO add lighting
		}
}

/**
 * Main module to use the pre-rendered effector. The assembly is centered at the origin. 
 */
module effector_pen() {
	bom_entry(section = "Printed Parts", description = "Effector", size = "Pen Holder");
	color_printed_effector()
		import(file = "effector_pen.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module effector_pen_hardware(with_spacers = true, with_ir_sensor = true) {
	effector_base_hardware();

	if (with_ir_sensor) {
		translate([-effector_base_center_long_edge_distance() + escher_ir_sensor_housing_body_depth() / 2, 
			       0, 
			       0]) {
			ir_sensor_housing();
			ir_sensor_housing_hardware();
		}
		// TODO add adjustment screws
	}
}

/**
 * Renders a placeholder to indicate the location of an assumed tool mounted in the center of the effector.
 */
module effector_pen_tool() {
	_nozzle_height = hotend_e3d_v6lite_overall_height() - effector_pen_spacer_height() - effector_base_thickness();
	#rotate_extrude()
		polygon(points = [
			[0, 0],
			[0, -_nozzle_height],
			[-_nozzle_height/2, 0]
		]);
}

_render_effector_pen();
//effector_pen_hardware();
//effector_pen_tool();
