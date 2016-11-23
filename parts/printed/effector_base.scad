/**********************************************************************************************************************
 **
 ** parts/printed/effector_base.scad
 **
 ** This file constructs the effector base plate which serves as a starting point for the actual effetor models.
 ** This part is not supposed to be printed.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

/**
 * Creates a magnet holder. 
 */
module _effector_base_magnet_holder() {
	translate([-effector_base_magnet_holder_height() + effector_base_magnet_depth(), 0, 0])
		rotate([0, 90, 0])
			cylinder(d = effector_base_magnet_holder_diameter(), h = effector_base_magnet_holder_height());
}

/**
 * Creates a hole to hold a magnet and the clean surface abovr.
 */
module _effector_base_magnet_hole_and_surface() {
	// the magnet hole
	rotate([0, 90, 0])
		cylinder(d = effector_base_magnet_diameter() + epsilon(), h = effector_base_magnet_depth() + epsilon());
	// a cylinder to clean the surface area
	translate([effector_base_magnet_depth(), 0, 0])
		rotate([0, 90, 0])
			cylinder(d = effector_base_magnet_holder_diameter(), h = effector_base_magnet_holder_height());
}

/**
 * Creates the effector base assembly by rendering it from scratch. This module is not to be called externally, use 
 * effector_base() instead.
 */
module _render_effector_base() {

	_mp_a_left  = effector_base_magnet_position_a_left();
	_mp_a_right = effector_base_magnet_position_a_right();
	_mp_b_left  = effector_base_magnet_position_b_left();
	_mp_b_right = effector_base_magnet_position_b_right();
	_mp_c_left  = effector_base_magnet_position_c_left();
	_mp_c_right = effector_base_magnet_position_c_right();

	color_printed_effector()
		render() {		
			difference() {
				union() {
					// the base plate			
				    linear_extrude(height = effector_base_thickness())
		        		polygon(points = [
		        				[ _mp_a_left[0],  _mp_a_left[1]  ],
								[ _mp_a_right[0], _mp_a_right[1] ],
								[ _mp_c_right[0], _mp_c_right[1] ],
								[ _mp_c_left[0],  _mp_c_left[1]  ],
								[ _mp_b_left[0],  _mp_b_left[1]  ],
								[ _mp_b_right[0], _mp_b_right[1] ]
		        			]);
    
					// the magnet holders
					translate(_mp_a_left)
						rotate([0, -90 - effector_base_magnet_angle(), 120])
							_effector_base_magnet_holder();
					translate(_mp_a_right)
						rotate([0, -90 - effector_base_magnet_angle(), 120])
							_effector_base_magnet_holder();
					translate(_mp_b_left)
						rotate([0, -90 - effector_base_magnet_angle(), -120])
							_effector_base_magnet_holder();
					translate(_mp_b_right)
						rotate([0, -90 - effector_base_magnet_angle(), -120])
							_effector_base_magnet_holder();
					translate(_mp_c_left)
						rotate([0, -90 - effector_base_magnet_angle(), 0])
							_effector_base_magnet_holder();
					translate(_mp_c_right)
						rotate([0, -90 - effector_base_magnet_angle(), 0])
							_effector_base_magnet_holder();
				}
				
				// minus everything in negative X
				translate([-effector_base_triangle_edge_length(), -effector_base_triangle_edge_length(), -effector_base_thickness()])
					cube([2*effector_base_triangle_edge_length(), 2*effector_base_triangle_edge_length(), effector_base_thickness()]);

				// minus the holes for the magnets
				translate(_mp_a_left)
					rotate([0, -90 - effector_base_magnet_angle(), 120])
						_effector_base_magnet_hole_and_surface();
				translate(_mp_a_right)
					rotate([0, -90 - effector_base_magnet_angle(), 120])
						_effector_base_magnet_hole_and_surface();
				translate(_mp_b_left)
					rotate([0, -90 - effector_base_magnet_angle(), -120])
						_effector_base_magnet_hole_and_surface();
				translate(_mp_b_right)
					rotate([0, -90 - effector_base_magnet_angle(), -120])
						_effector_base_magnet_hole_and_surface();
				translate(_mp_c_left)
					rotate([0, -90 - effector_base_magnet_angle(), 0])
						_effector_base_magnet_hole_and_surface();
				translate(_mp_c_right)
					rotate([0, -90 - effector_base_magnet_angle(), 0])
						_effector_base_magnet_hole_and_surface();
			}
		} 
}

/**
 * Main module to use the pre-rendered effector base. The assembly is centered at the origin. Since this version is
 * not supposed to be printed, no BOM entry is generated.
 */
module effector_base() {
	color_printed_effector()
		import(file = "effector_base.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 * This also includes the V-Wheels and their supporting material.
 */
module effector_base_hardware() {
	// the magnets inside the holders
	translate(effector_base_magnet_position_a_left())
		rotate([0, -90 - effector_base_magnet_angle(), 120])
			magnet_ring(diameter = effector_base_magnet_diameter(), thickness = effector_base_magnet_depth());
	translate(effector_base_magnet_position_a_right())
		rotate([0, -90 - effector_base_magnet_angle(), 120])
			magnet_ring(diameter = effector_base_magnet_diameter(), thickness = effector_base_magnet_depth());
	translate(effector_base_magnet_position_b_left())
		rotate([0, -90 - effector_base_magnet_angle(), -120])
			magnet_ring(diameter = effector_base_magnet_diameter(), thickness = effector_base_magnet_depth());
	translate(effector_base_magnet_position_b_right())
		rotate([0, -90 - effector_base_magnet_angle(), -120])
			magnet_ring(diameter = effector_base_magnet_diameter(), thickness = effector_base_magnet_depth());
	translate(effector_base_magnet_position_c_left())
		rotate([0, -90 - effector_base_magnet_angle(), 0])
			magnet_ring(diameter = effector_base_magnet_diameter(), thickness = effector_base_magnet_depth());
	translate(effector_base_magnet_position_c_right())
		rotate([0, -90 - effector_base_magnet_angle(), 0])
			magnet_ring(diameter = effector_base_magnet_diameter(), thickness = effector_base_magnet_depth());
}

_render_effector_base();
