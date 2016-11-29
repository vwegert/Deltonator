/**********************************************************************************************************************
 **
 ** parts/printed/carriage_ball_holder.scad
 **
 ** This file constructs the ball holders that are mounted to the carriage. To assemble the printer, you need six of 
 ** these parts.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

/**
 * Creates the ball holder assembly by rendering it from scratch. This module is not to be called externally, use 
 * carriage_ball_holder() instead.
 */
module _render_carriage_ball_holder() {
	color_printed_carriage()
		render() {
			rotate([0, 0, 0]) {

				difference() {
					// the basic block shape
					union() {
						translate([-carriage_ball_holder_joint_depth(), -carriage_ball_holder_width()/2, 0])
							cube([carriage_ball_holder_depth() - ball_diameter()/2, 
								  carriage_ball_holder_width(), 
								  carriage_ball_holder_height()]);
						translate([carriage_ball_holder_depth() - carriage_ball_holder_joint_depth() - ball_diameter()/2, 0, 0])
							cylinder(d = ball_diameter(), 
								     h = carriage_ball_holder_height(), 
								   	 $fn = carriage_ball_holder_resolution());
					}

					// minus the recess to hold the ball
					translate(carriage_ball_holder_ball_position())
						sphere(d = ball_diameter(), $fn = carriage_ball_holder_resolution());

					// minus the left dovetail cutaway
					rotate([0, carriage_ball_holder_angle(), 0])
						translate([0, 0, -carriage_ball_holder_height()])
						linear_extrude(height = 3*carriage_ball_holder_height()) {
							polygon(points = [
								[-carriage_plate_thickness(), -carriage_ball_holder_width()/2],
								[-carriage_plate_thickness(), -carriage_ball_holder_joint_outer_width()/2],
								[0,                           -carriage_ball_holder_joint_inner_width()/2],
								[0,                           -carriage_ball_holder_width()/2]
							]);
						}

					// minus the right dovetail cutaway
					rotate([0, carriage_ball_holder_angle(), 0])
						translate([0, 0, -carriage_ball_holder_height()])
						linear_extrude(height = 3*carriage_ball_holder_height()) {
							polygon(points = [
								[-carriage_plate_thickness(), carriage_ball_holder_width()/2],
								[-carriage_plate_thickness(), carriage_ball_holder_joint_outer_width()/2],
								[0,                           carriage_ball_holder_joint_inner_width()/2],
								[0,                           carriage_ball_holder_width()/2]
							]);
						}

					// minus the back beveled edge
					_bevel_cutout_depth = 10;
					rotate([0, carriage_ball_holder_angle(), 0])
						translate([-carriage_plate_thickness() - _bevel_cutout_depth, 
							       -carriage_ball_holder_width()/2,
							       -carriage_ball_holder_height()])
							cube([_bevel_cutout_depth,
								  carriage_ball_holder_width(), 
								  3*carriage_ball_holder_height()]);

				}
			} // rotate
		} // render
}

/**
 * Main module to use the pre-rendered ball holder. The part is aligned so that the center of the lower inner dovetail 
 * joint is placed at the origin. To place it in the carriage, it needs to be rotated with 
 *   rotate([0, -carriage_ball_holder_angle(), 0])
 */
module carriage_ball_holder() {
	bom_entry(section = "Printed Parts", description = "Arm", size = "Carriage Ball Holder");
	color_printed_carriage()
		import(file = "carriage_ball_holder.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module carriage_ball_holder_hardware() {
	translate(carriage_ball_holder_ball_position())
		ball(size = ball_diameter()); 
}

_render_carriage_ball_holder();
