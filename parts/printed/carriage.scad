/**********************************************************************************************************************
 **
 ** parts/printed/carriage.scad
 **
 ** This file constructs the carriage that will hold the arms. To assemble the printer, you need three of these parts.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/extrusions/makerslide.scad>
use <../../parts/vitamins/vitamins.scad>

/**
 * Renders the lower part of the base plate of the carriage that holds the wheels.
 */
module _carriage_lower_base_plate() {
	difference() {
		// the plate
		hull() {
			_corner_distance = vwheel_max_mounting_hole_size()/2 + carriage_plate_border_width();
			_corner_distance_round = _corner_distance - carriage_plate_edge_radius();
	
			// above and left of wheel 1: a cube (because there will be the upper part above it)
			translate([0, carriage_wheel1_y() - _corner_distance, carriage_wheel1_z()])
				cube(size = [carriage_plate_thickness(), _corner_distance, _corner_distance]);
	
			// below and left of wheel 2
			translate([0, carriage_wheel2_y() - _corner_distance_round, carriage_wheel2_z() - _corner_distance_round])
				rotate([0, 90, 0])
					cylinder(r = carriage_plate_edge_radius(), 
						     h = carriage_plate_thickness(),
						     $fn = carriage_plate_edge_resolution());
	
			// below and right of wheel 2
			translate([0, carriage_wheel2_y() + _corner_distance_round, carriage_wheel2_z() - _corner_distance_round])
				rotate([0, 90, 0])
					cylinder(r = carriage_plate_edge_radius(), 
						     h = carriage_plate_thickness(),
						     $fn = carriage_plate_edge_resolution());
	
			// way above and right of wheel 3: a cube (because there will be the upper part above it)
			translate([0, carriage_wheel3_y(), carriage_wheel1_z()])
				cube(size = [carriage_plate_thickness(), _corner_distance, _corner_distance]);
	
			// below and right of wheel 3
			translate([0, carriage_wheel3_y() + _corner_distance_round, carriage_wheel3_z() - _corner_distance_round])
				rotate([0, 90, 0])
					cylinder(r = carriage_plate_edge_radius(), 
						     h = carriage_plate_thickness(),
						     $fn = carriage_plate_edge_resolution());
		}
		// minus the three holes for the V-Wheel mounts
		translate([0, carriage_wheel1_y(), carriage_wheel1_z()])
			rotate([0, 90, 0])
				cylinder(d = carriage_wheel1_hole_diameter(),
			    		 h = carriage_plate_thickness() + epsilon(),
					     $fn = carriage_wheel_hole_resolution());
		translate([0, carriage_wheel2_y(), carriage_wheel2_z()])
			rotate([0, 90, 0])
				cylinder(d = carriage_wheel2_hole_diameter(),
			    		 h = carriage_plate_thickness() + epsilon(),
					     $fn = carriage_wheel_hole_resolution());
		translate([0, carriage_wheel3_y(), carriage_wheel3_z()])
			rotate([0, 90, 0])
				cylinder(d = carriage_wheel3_hole_diameter(),
			    		 h = carriage_plate_thickness() + epsilon(),
					     $fn = carriage_wheel_hole_resolution());
	}
}

/**
 * Renders the upper part of the base plate of the carriage that holds the magnets.
 */
module _carriage_upper_base_plate() {

}

/**
 * Renders the lower part of the base plate of the carriage that holds the wheels.
 */
module _carriage_base_plate() {
	union() {
		_carriage_lower_base_plate();
		_carriage_upper_base_plate();
	}
}

/**
 * Creates the carriage assembly by rendering it from scratch. This module is not to be called externally, use 
 * carriage() instead.
 */
module _render_carriage() {
	color_printed_carriage()
		render() {
			difference() {
				// the base plate			
				_carriage_base_plate();


			}

			// TODO add belt holding mechanism
			// TODO add magnet holders

		} 
}

/**
 * Main module to use the pre-rendered carriage. The assembly is centered on the Z axis in Y direction for easier 
 * manipulation, similar to the MakerSlide extrusion. 
 */
module carriage() {
	bom_entry(section = "Printed Parts", description = "Arm", size = "Outer Carriage");
	color_printed_outer_frame()
		import(file = "carriage.stl");
}

/**
 * Renders the hardware used for a fixed wheel.
 */
module _carriage_hardware_fixed_wheel() {
	// washer on the inner side (facing away from the rail)
	translate([carriage_plate_thickness() + epsilon(), 0, 0])
		washer(M5);
	// washer between the plate and the wheel
	translate([-(washer_thickness_m5() + epsilon()), 0, 0])
		washer(M5);
	// wheel assembly
	_vwheel_x = -(washer_thickness_m5() + epsilon() + 
		          vwheel_assembly_thickness() - vwheel_assembly_overhang() + epsilon()); 
	translate([_vwheel_x, 0, 0])
		vslot_wheel(include_bearings = true);
	// washer on the outer side of the wheel
	_outer_washer_x = _vwheel_x - vwheel_assembly_overhang() - epsilon() - washer_thickness_m5();
	translate([_outer_washer_x, 0, 0])
		washer(M5);
	// screw
	_screw_min_length = 3 * washer_thickness_m5() + carriage_plate_thickness() + 
	                    vwheel_assembly_thickness() + nut_thickness_m5();
	_screw_max_length = 2 * washer_thickness_m5() + carriage_plate_thickness() + 
	                    vwheel_assembly_thickness()/2 + makerslide_base_depth();
	translate([carriage_plate_thickness() + epsilon() + washer_thickness_m5() + epsilon(), 0, 0])
		rotate([0, 180, 0])
			screw(size = M5, min_length = _screw_min_length, max_length = _screw_max_length); 
	// nut
	_nut_x = _outer_washer_x - epsilon();
	translate([_nut_x, 0, 0])
		rotate([0, 180, 0])
			nut(M5);
}

/**
 * Renders the hardware used for a fixed wheel.
 */
module _carriage_hardware_adjustable_wheel() {
	// spacer
	translate([carriage_plate_thickness() + epsilon(), 0, 0])
		vslot_wheel_spacer();
	// washer between the screw and the spacer
	_inner_washer_x = carriage_plate_thickness() + epsilon() + vwheel_spacer_hex_height() + epsilon();
	translate([_inner_washer_x, 0, 0])
		washer(M5);
	// washer between the plate and the wheel
	translate([-(washer_thickness_m5() + epsilon()), 0, 0])
		washer(M5);
	// wheel assembly
	_vwheel_x = -(washer_thickness_m5() + epsilon() + 
		          vwheel_assembly_thickness() - vwheel_assembly_overhang() + epsilon()); 
	translate([_vwheel_x, 0, 0])
		vslot_wheel(include_bearings = true);
	// washer on the outer side of the wheel
	_outer_washer_x = _vwheel_x - vwheel_assembly_overhang() - epsilon() - washer_thickness_m5();
	translate([_outer_washer_x, 0, 0])
		washer(M5);
	// screw
	_screw_min_length = 3 * washer_thickness_m5() + vwheel_spacer_hex_height() + carriage_plate_thickness() + 
	                    vwheel_assembly_thickness() + nut_thickness_m5();
	_screw_max_length = 2 * washer_thickness_m5() + vwheel_spacer_hex_height() + carriage_plate_thickness() +
					    vwheel_assembly_thickness()/2 + makerslide_base_depth();
	translate([_inner_washer_x + epsilon() + washer_thickness_m5() + epsilon(), 0, 0])
		rotate([0, 180, 0])
			screw(size = M5, min_length = _screw_min_length, max_length = _screw_max_length); 
	// nut
	_nut_x = _outer_washer_x - epsilon();
	translate([_nut_x, 0, 0])
		rotate([0, 180, 0])
			nut(M5);
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 * This also includes the V-Wheels and their supporting material.
 */
module carriage_hardware() {
	// the fixed wheels on the left-hand side
	translate([0, carriage_wheel1_y(), carriage_wheel1_z()])
		_carriage_hardware_fixed_wheel();
	translate([0, carriage_wheel2_y(), carriage_wheel2_z()])
		_carriage_hardware_fixed_wheel();
	// the adjustable wheel on the right-hand side
	translate([0, carriage_wheel3_y(), carriage_wheel3_z()])
		_carriage_hardware_adjustable_wheel();
}

_render_carriage();
