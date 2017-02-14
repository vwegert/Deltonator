/**********************************************************************************************************************
 **
 ** parts/vitamins/electronic/escher_ir_sensor.scad
 **
 ** This file renders an approximation of the Mini Differential IR height sensor board available from 
 ** http://www.escher3d.com/pages/order/products/product1.php
 **
 **********************************************************************************************************************/

include <../../../conf/colors.scad>
include <../../../conf/derived_sizes.scad>
include <../../../conf/part_sizes.scad>

union() {
	difference() {
		// the base PCB...
		cube([escher_ir_sensor_pcb_thickness(),
		      escher_ir_sensor_pcb_width(),
	    	  escher_ir_sensor_pcb_height()]);

		// ...minus the screw holes
		translate([-epsilon(),
			       escher_ir_sensor_hole_offset_side(),
			       escher_ir_sensor_pcb_height() - escher_ir_sensor_hole_offset_top()])
			rotate([0, 90, 0])
				cylinder(d = escher_ir_sensor_hole_size(),
					     h = escher_ir_sensor_pcb_thickness() + 2 * epsilon(),
				    	 $fn = escher_ir_sensor_resolution());
		translate([-epsilon(),
			       escher_ir_sensor_pcb_width()  - escher_ir_sensor_hole_offset_side(),
			       escher_ir_sensor_pcb_height() - escher_ir_sensor_hole_offset_top()])
			rotate([0, 90, 0])
				cylinder(d = escher_ir_sensor_hole_size(),
					     h = escher_ir_sensor_pcb_thickness() + 2 * epsilon(),
				    	 $fn = escher_ir_sensor_resolution());
	}

	// placeholder for the components on the top side
	translate([escher_ir_sensor_pcb_thickness(), 0, 0]) 
		difference() {
			// the entire top side...
			cube([escher_ir_sensor_pcb_max_component_height(),
				  escher_ir_sensor_pcb_width(),
				  escher_ir_sensor_pcb_height()]);
			// minus the free areas above the screw holes
			translate([-epsilon(),
				       -epsilon(), 
				       escher_ir_sensor_pcb_height() - escher_ir_sensor_pcb_top_edge_clearance() + epsilon()])
				cube([escher_ir_sensor_pcb_max_component_height() + 2 * epsilon(),
					  escher_ir_sensor_pcb_top_edge_clearance(),
					  escher_ir_sensor_pcb_top_edge_clearance()]);
			translate([-epsilon(),
				       escher_ir_sensor_pcb_width() - escher_ir_sensor_pcb_top_edge_clearance() + epsilon(), 
				       escher_ir_sensor_pcb_height() - escher_ir_sensor_pcb_top_edge_clearance() + epsilon()])
				cube([escher_ir_sensor_pcb_max_component_height() + 2 * epsilon(),
					  escher_ir_sensor_pcb_top_edge_clearance(),
					  escher_ir_sensor_pcb_top_edge_clearance()]);
		}

	// placeholder for the pins on the back side
	translate([- escher_ir_sensor_pcb_max_pin_length(),
		        escher_ir_sensor_pcb_bottom_side_clearance(), 
		        0])
		cube([escher_ir_sensor_pcb_max_pin_length(),
			  escher_ir_sensor_pcb_width() - 2 * escher_ir_sensor_pcb_bottom_side_clearance(),
			  escher_ir_sensor_pcb_height()]);
	
}
