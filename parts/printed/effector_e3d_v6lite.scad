/**********************************************************************************************************************
 **
 ** parts/printed/effector_e3d_v6lite.scad
 **
 ** This file constructs a effector to hold the E3D V6 lite.
 ** This part is supposed to be printed once for that hotend tyoe.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

use <effector_base.scad>
use <effector_e3d_v6lite_spacer.scad>
use <ir_sensor_housing.scad>

/**
 * Renders the hole that is cut out of the plate to let the hotend poke through.
 */
module _effector_e3d_v6lite_cutout() {
	union() {
		// the rectangular hole
		translate([-hotend_e3d_v6lite_cutout_depth_back(),
			       -hotend_e3d_v6lite_cutout_width()/2,
			       -epsilon()])
			cube([hotend_e3d_v6lite_cutout_depth_back() + hotend_e3d_v6lite_cutout_depth_front(),
				  hotend_e3d_v6lite_cutout_width(),
				  effector_base_thickness() + 2 * epsilon()]);
		// a 45° bevel on the back side
		translate([-hotend_e3d_v6lite_cutout_depth_back(),
			       -hotend_e3d_v6lite_cutout_width()/2,
			       -epsilon()])
			rotate([0, -45, 0])
				cube([effector_base_thickness(),
				   	   hotend_e3d_v6lite_cutout_width(),
					   2 * effector_base_thickness()]);
		// a 45° bevel on the front side
		translate([hotend_e3d_v6lite_cutout_depth_front(),
			       -hotend_e3d_v6lite_cutout_width()/2,
			       -epsilon()])
			rotate([0, 45, 0])
				translate([-effector_base_thickness(), 0, 0])
					cube([effector_base_thickness(),
					   	   hotend_e3d_v6lite_cutout_width(),
						   2 * effector_base_thickness()]);
	}
}

/**
 * Renders the mounting holes below the spacer blocks.
 */
module _effector_e3d_v6lite_mounting_holes() {
	translate([0,
		       -hotend_e3d_v6lite_mounting_hole_distance(),
		       -epsilon()])
		cylinder(d = hotend_e3d_v6lite_mounting_hole_size(),
				 h = effector_base_thickness() + 2 * epsilon(),
				 $fn = effector_base_resolution());
	translate([0,
		       hotend_e3d_v6lite_mounting_hole_distance(),
		       -epsilon()])
		cylinder(d = hotend_e3d_v6lite_mounting_hole_size(),
				 h = effector_base_thickness() + 2 * epsilon(),
				 $fn = effector_base_resolution());
}


/**
 * Renders the holes to mount the IR height sensor.
 */
module _effector_e3d_v6lite_ir_sensor() {
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
 * Renders the right-hand (if viewed from the front) part cooling fan holder.
 */
module _effector_e3d_v6lite_pcf_holder() {
	rotate([0, 0, -30]) 
		translate([-pc_fan_side_length()/2, effector_base_center_long_edge_distance(), 0]) {
			// the upper part that the fan is screwed onto
			difference() {
				// the fan mounting plate
				cube([pc_fan_side_length(), pc_fan_side_length(), effector_base_thickness()]);
				// minus the center hole
				translate([pc_fan_side_length()/2, pc_fan_side_length()/2, -epsilon()])
				cylinder(d = pc_fan_side_length() - 2 * 2, h = effector_base_thickness() + 2 * epsilon());
				// TODO add the screw holes
			}
			// TODO add the air nozzle

			_nozzle_bottom_length = 3 * pc_fan_side_length();

			translate([0, pc_fan_side_length(), 0])
			rotate([20, 0, 0])
				translate([0, -_nozzle_bottom_length, -effector_base_thickness()])
					cube([pc_fan_side_length(), _nozzle_bottom_length, effector_base_thickness()]);
		}
}

/**
 * Renders both part cooling fan holders.
 */
module _effector_e3d_v6lite_pcf_holders() {
	_effector_e3d_v6lite_pcf_holder();
	mirror([0, 1, 0])
		_effector_e3d_v6lite_pcf_holder();
}

/**
 * Creates the effector assembly by rendering it from scratch. This module is not to be called externally, use 
 * effector_e3d_v6lite() instead.
 */
module _render_effector_e3d_v6lite() {
	color_printed_effector() 
		union() {
			difference() {
				// the base plate
				effector_base();
				// minus the cutout for the hotend in the center
				_effector_e3d_v6lite_cutout();
				// minus the mounting holes for the hotend
				_effector_e3d_v6lite_mounting_holes();
				// minus the mounting holes for the IR sensor
				_effector_e3d_v6lite_ir_sensor();
			}
			// add the part cooling fan holders
			_effector_e3d_v6lite_pcf_holders();
		// TODO add a part cooling fan
		// TODO add lighting
		}
}

/**
 * Main module to use the pre-rendered effector. The assembly is centered at the origin. 
 */
module effector_e3d_v6lite() {
	bom_entry(section = "Printed Parts", description = "Effector", size = "E3D V6 Lite (Base Plate)");
	color_printed_effector()
		import(file = "effector_e3d_v6lite.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module effector_e3d_v6lite_hardware(with_spacers = true, with_ir_sensor = true) {
	effector_base_hardware();

	if (with_spacers) {
		translate([0, -hotend_e3d_v6lite_mounting_hole_distance(), effector_base_thickness() + epsilon()])
			effector_e3d_v6lite_spacer();
		translate([0, hotend_e3d_v6lite_mounting_hole_distance(), effector_base_thickness() + epsilon()])
			effector_e3d_v6lite_spacer();
		// TODO add screws for both top and bottom of spacers
	}

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
module effector_e3d_v6lite_tool() {
	_nozzle_height = hotend_e3d_v6lite_overall_height() - effector_e3d_v6lite_spacer_height() - effector_base_thickness();
	#rotate_extrude()
		polygon(points = [
			[0, 0],
			[0, -_nozzle_height],
			[-_nozzle_height/2, 0]
		]);
}

_render_effector_e3d_v6lite();
//effector_e3d_v6lite_hardware();
//effector_e3d_v6lite_tool();
