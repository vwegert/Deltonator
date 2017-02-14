/**********************************************************************************************************************
 **
 ** parts/printed/ir_sensor_housing.scad
 **
 ** This file constructs the housing for the Mini Differential IR height sensor board available from 
 ** http://www.escher3d.com/pages/order/products/product1.php
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

/**
 * Renders the main body of the housing without the "wings" to fasten it.
 */
module _ir_sensor_housing_body() {

	difference() {
		union() {
			// the outer shape of the housing
			difference() {
				cube([escher_ir_sensor_housing_body_depth(),
					  escher_ir_sensor_housing_body_width(),
					  escher_ir_sensor_housing_body_height()]);
				translate([escher_ir_sensor_housing_wall_thickness(), escher_ir_sensor_housing_wall_thickness(), 0])
				cube([escher_ir_sensor_housing_body_depth() - 2 * escher_ir_sensor_housing_wall_thickness(),
					  escher_ir_sensor_housing_body_width() - 2 * escher_ir_sensor_housing_wall_thickness(),
					  escher_ir_sensor_housing_body_height()]);
			}
		
			// the "resting blocks" on the underside of the PCB
			translate([escher_ir_sensor_housing_wall_thickness(), 
				       escher_ir_sensor_housing_wall_thickness(), 
				       0])
				cube([escher_ir_sensor_housing_top_bottom_clearance() + escher_ir_sensor_pcb_max_pin_length(),
					  escher_ir_sensor_pcb_bottom_side_clearance(),
					  escher_ir_sensor_housing_body_height()]);
			translate([escher_ir_sensor_housing_wall_thickness(), 
				       escher_ir_sensor_housing_body_width() - escher_ir_sensor_housing_wall_thickness() - escher_ir_sensor_pcb_bottom_side_clearance(), 
				       0])
				cube([escher_ir_sensor_housing_top_bottom_clearance() + escher_ir_sensor_pcb_max_pin_length(),
					  escher_ir_sensor_pcb_bottom_side_clearance(),
					  escher_ir_sensor_housing_body_height()]);
		
			// the "mounting blocks" on the component side of the PCB
			_mounting_block_thickness = escher_ir_sensor_pcb_max_component_height() + 
			                            escher_ir_sensor_housing_top_bottom_clearance();
			_mounting_block_x_offset = escher_ir_sensor_housing_body_depth() - escher_ir_sensor_housing_wall_thickness() - _mounting_block_thickness;
			translate([_mounting_block_x_offset, 
				       escher_ir_sensor_housing_wall_thickness(), 
				       escher_ir_sensor_housing_body_height() - escher_ir_sensor_pcb_top_edge_clearance()])
				cube([_mounting_block_thickness,
					  escher_ir_sensor_pcb_top_edge_clearance(),
					  escher_ir_sensor_pcb_top_edge_clearance()]);
			translate([_mounting_block_x_offset, 
					   escher_ir_sensor_housing_body_width() - escher_ir_sensor_housing_wall_thickness() - escher_ir_sensor_pcb_top_edge_clearance(), 
				       escher_ir_sensor_housing_body_height() - escher_ir_sensor_pcb_top_edge_clearance()])
				cube([_mounting_block_thickness,
					  escher_ir_sensor_pcb_top_edge_clearance(),
					  escher_ir_sensor_pcb_top_edge_clearance()]);
		}

		// minus the screw holes
		translate([-epsilon(),
			       escher_ir_sensor_screw_y_offset(),
			       escher_ir_sensor_screw_z_offset()])
			rotate([0, 90, 0])
				cylinder(d = tap_base_diameter(escher_ir_sensor_hole_size()),
					     h = escher_ir_sensor_housing_body_depth() + 2 * epsilon(),
				    	 $fn = escher_ir_sensor_resolution());
		translate([-epsilon(),
			       escher_ir_sensor_housing_body_width() - escher_ir_sensor_screw_y_offset(),
			       escher_ir_sensor_screw_z_offset()])
			rotate([0, 90, 0])
				cylinder(d = tap_base_diameter(escher_ir_sensor_hole_size()),
					     h = escher_ir_sensor_housing_body_depth() + 2 * epsilon(),
				    	 $fn = escher_ir_sensor_resolution());
	}
}

/**
 * Renders the two "wings" that hold the magnets.
 */
module _ir_sensor_housing_magnet_holders() {

	// move to the Z base
	translate([0, 0, escher_ir_sensor_housing_body_height() - escher_ir_sensor_magnet_holder_height()]) {

		// create the left block
		translate([0, -escher_ir_sensor_magnet_holder_width(), 0]) 
			difference() {
				// the block
				cube([escher_ir_sensor_magnet_holder_depth(),
					  escher_ir_sensor_magnet_holder_width(),
					  escher_ir_sensor_magnet_holder_height()]);

				// minus the hole for the magnets
				translate([escher_ir_sensor_magnet_holder_depth() / 2,
					       escher_ir_sensor_housing_wall_thickness() + escher_ir_sensor_magnet_clearance() + escher_ir_sensor_magnet_diameter()/2,
					       escher_ir_sensor_magnet_holder_height() - (escher_ir_sensor_magnet_height() + escher_ir_sensor_magnet_clearance())])
				cylinder(d = escher_ir_sensor_magnet_diameter() + 2 * escher_ir_sensor_magnet_clearance(),
					     h = escher_ir_sensor_magnet_height() + escher_ir_sensor_magnet_clearance(),
					     $fn = escher_ir_sensor_resolution());
			}

		// create the right block
		translate([0, escher_ir_sensor_housing_body_width(), 0]) 
			difference() {
				// the block
				cube([escher_ir_sensor_magnet_holder_depth(),
					  escher_ir_sensor_magnet_holder_width(),
					  escher_ir_sensor_magnet_holder_height()]);

				// minus the hole for the magnets
				translate([escher_ir_sensor_magnet_holder_depth() / 2,
					       escher_ir_sensor_magnet_clearance() + escher_ir_sensor_magnet_diameter()/2,
					       escher_ir_sensor_magnet_holder_height() - (escher_ir_sensor_magnet_height() + escher_ir_sensor_magnet_clearance())])
				cylinder(d = escher_ir_sensor_magnet_diameter() + 2 * escher_ir_sensor_magnet_clearance(),
					     h = escher_ir_sensor_magnet_height() + escher_ir_sensor_magnet_clearance(),
					     $fn = escher_ir_sensor_resolution());
			}
	}
} 

/**
 * Creates the housing by rendering it from scratch. This module is not to be called externally, use 
 * ir_sensor_housing() instead.
 */
module _render_ir_sensor_housing() {
	color_printed_head_parts()
		render() {
			_ir_sensor_housing_body();
			_ir_sensor_housing_magnet_holders();
		} 
}

/**
 * Main module to use the pre-rendered sensor housing. 
 * TODO describe the orientation of the housing
 */
module ir_sensor_housing() {
	bom_entry(section = "Printed Parts", description = "Small Parts", size = "IR Sensor Housing");
	color_printed_head_parts()
		import(file = "ir_sensor_housing.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 * This also includes the sensor board.
 */
module ir_sensor_housing_hardware() {

	// the sensor board inside the housing
	translate([escher_ir_sensor_housing_wall_thickness() 
		       + escher_ir_sensor_housing_top_bottom_clearance()
               + escher_ir_sensor_pcb_max_pin_length()
               + escher_ir_sensor_housing_pcb_clearance(),
		       escher_ir_sensor_housing_wall_thickness() 
               + escher_ir_sensor_housing_pcb_clearance(),
		       0])
		escher_ir_sensor();

	// the screws to hold the sensor board
	translate([-epsilon(),
		       escher_ir_sensor_screw_y_offset(),
		       escher_ir_sensor_screw_z_offset()])
		screw(size = escher_ir_sensor_hole_size(),
			  min_length = escher_ir_sensor_screw_min_length(),
			  max_length = escher_ir_sensor_housing_body_depth());
	translate([-epsilon(),
		       escher_ir_sensor_housing_body_width() - escher_ir_sensor_screw_y_offset(),
		       escher_ir_sensor_screw_z_offset()])
		screw(size = escher_ir_sensor_hole_size(),
			  min_length = escher_ir_sensor_screw_min_length(),
			  max_length = escher_ir_sensor_housing_body_depth());

	// the magnets
	translate([escher_ir_sensor_magnet_holder_depth()/2,
		       - escher_ir_sensor_magnet_diameter() / 2 - escher_ir_sensor_magnet_clearance(), 
		       escher_ir_sensor_housing_body_height() - escher_ir_sensor_magnet_height()]) 
		magnet_cylinder();
	translate([escher_ir_sensor_magnet_holder_depth()/2,
		       escher_ir_sensor_housing_body_width() + escher_ir_sensor_magnet_diameter() / 2 + escher_ir_sensor_magnet_clearance(), 
		       escher_ir_sensor_housing_body_height() - escher_ir_sensor_magnet_height()]) 
		magnet_cylinder();

}

_render_ir_sensor_housing();
