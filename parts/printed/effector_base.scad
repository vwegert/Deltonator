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
 * Creates a ball holder. 
 */
module _effector_base_ball_holder() {
	translate([0, 0, ball_diameter()/2 - effector_base_ball_recess_depth()]) 
		cylinder(d = effector_base_ball_holder_diameter(),
				 h = effector_base_ball_holder_height(), 
				 $fn = effector_base_resolution());
}

/**
 * Main module to use the pre-rendered effector base. The assembly is centered at the origin. Since this version is
 * not supposed to be printed, no BOM entry is generated.
 */
module effector_base() {

	_bp_a_left  = effector_base_ball_position_a_left();
	_bp_a_right = effector_base_ball_position_a_right();
	_bp_b_left  = effector_base_ball_position_b_left();
	_bp_b_right = effector_base_ball_position_b_right();
	_bp_c_left  = effector_base_ball_position_c_left();
	_bp_c_right = effector_base_ball_position_c_right();

	color_printed_effector()
		render() {		
			difference() {
				union() {
					// the base plate			
				    linear_extrude(height = effector_base_thickness())
		        		polygon(points = [
		        				[ _bp_a_left[0],  _bp_a_left[1]  ],
								[ _bp_a_right[0], _bp_a_right[1] ],
								[ _bp_c_right[0], _bp_c_right[1] ],
								[ _bp_c_left[0],  _bp_c_left[1]  ],
								[ _bp_b_left[0],  _bp_b_left[1]  ],
								[ _bp_b_right[0], _bp_b_right[1] ]
		        			]);
    
					// the ball holders
					translate(_bp_a_left)
						_effector_base_ball_holder();
					translate(_bp_a_right)
						_effector_base_ball_holder();
					translate(_bp_b_left)
						_effector_base_ball_holder();
					translate(_bp_b_right)
						_effector_base_ball_holder();
					translate(_bp_c_left)
						_effector_base_ball_holder();
					translate(_bp_c_right)
						_effector_base_ball_holder();
				}				

				// minus the cutouts for the balls
				translate(_bp_a_left)
					sphere(d = ball_diameter(), $fn = effector_base_resolution());
				translate(_bp_a_right)
					sphere(d = ball_diameter(), $fn = effector_base_resolution());
				translate(_bp_b_left)
					sphere(d = ball_diameter(), $fn = effector_base_resolution());
				translate(_bp_b_right)
					sphere(d = ball_diameter(), $fn = effector_base_resolution());
				translate(_bp_c_left)
					sphere(d = ball_diameter(), $fn = effector_base_resolution());
				translate(_bp_c_right)
					sphere(d = ball_diameter(), $fn = effector_base_resolution());
			}
		} 
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 * This also includes the V-Wheels and their supporting material.
 */
module effector_base_hardware() {
	// the balls inside the holders
	translate(effector_base_ball_position_a_left())
		ball();
	translate(effector_base_ball_position_a_right())
		ball();
	translate(effector_base_ball_position_b_left())
		ball();
	translate(effector_base_ball_position_b_right())
		ball();
	translate(effector_base_ball_position_c_left())
		ball();
	translate(effector_base_ball_position_c_right())
		ball();
}
