/**********************************************************************************************************************
 **
 ** parts/printed/magnet_holder.scad
 **
 ** This file provides a common base for the magnet holders on both ends of the rods. This file is not to be printed. 
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

/**
 * Creates the magnet holder assembly by rendering it from scratch. This module is not to be called externally, use 
 * magnet_holder() instead.
 */
module _render_magnet_holder(ball_clearance, debug = false) {
	color_printed_magnet_holders() {

		// the horizontal magnet holder part
		union() {
			translate([0, 0, ball_center_magnet_base_distance()]) {

				cylinder(d = magnet_holder_top_diameter(), h = magnet_holder_top_thickness(),
					$fn = magnet_holder_resolution());
				translate([0, -magnet_holder_top_diameter()/2, 0])
					cube([magnet_holder_top_diameter()/2 + magnet_holder_arm_clearance() + magnet_holder_arm_thickness()/2,
						  magnet_holder_top_diameter(),
					  	  magnet_holder_top_thickness()]);

				// the pin to push the magnet on
				translate([0, 0, -magnet_holder_pin_height()])
					cylinder(d = magnet_holder_pin_diameter() - 2 * magnet_holder_magnet_clearance(), 
							 h = magnet_holder_pin_height(), 
							 $fn = magnet_holder_resolution());
			}
		}

		// the vertical arm
		translate([magnet_holder_top_diameter()/2 + magnet_holder_arm_clearance(), 
				   -magnet_holder_top_diameter()/2, 
				   magnet_holder_top_thickness() + ball_center_magnet_base_distance() - magnet_holder_arm_length(ball_clearance)])
			cube([magnet_holder_arm_thickness(), 
				  magnet_holder_arm_width(), 
				  magnet_holder_arm_length(ball_clearance) - magnet_holder_arm_thickness()/2]);

		// the rounded edge between the magnet holder and the vertical arm
		translate([magnet_holder_top_diameter()/2 + magnet_holder_arm_clearance() + magnet_holder_arm_thickness()/2,
				   magnet_holder_arm_width()/2,
				   ball_center_magnet_base_distance() + magnet_holder_top_thickness()/2])
			rotate([90, 0, 0])
				cylinder(d = magnet_holder_arm_thickness(), h = magnet_holder_arm_width(), 
						 $fn = magnet_holder_resolution());

		// the rod holder
		translate([0, 0, -magnet_holder_rod_distance(ball_clearance)]) {
			difference() {
				union() {
					// the outer shape of the rod holder
					translate([0, 0, - magnet_holder_rod_holder_depth()]) 
						cylinder(d = rod_outer_diameter() + 2 * magnet_holder_rod_wall_thickness(),
							     h = magnet_holder_rod_holder_depth() + magnet_holder_rod_wall_thickness(),
						    	 $fn = magnet_holder_resolution());

					// the connector up to the arm
					_connector_lower_width  = rod_outer_diameter() + 2 * magnet_holder_rod_wall_thickness();
					_connector_outer_edge   = ball_diameter()/2 + magnet_holder_arm_clearance() + magnet_holder_arm_thickness();
					_connector_inner_top    = magnet_holder_rod_wall_thickness();
					_connector_inner_bottom = _connector_inner_top - magnet_holder_arm_thickness();
					_connector_outer_top    = magnet_holder_arm_length(ball_clearance) - magnet_holder_rod_distance(ball_clearance) - magnet_holder_top_thickness();
					_connector_outer_bottom = _connector_outer_top - magnet_holder_arm_thickness();
					_connector_points = [
					  [  0,                    -_connector_lower_width/2,    _connector_inner_bottom ],  //0
					  [ _connector_outer_edge, -magnet_holder_arm_width()/2, _connector_outer_bottom ],  //1
					  [ _connector_outer_edge,  magnet_holder_arm_width()/2, _connector_outer_bottom ],  //2
					  [  0,                     _connector_lower_width/2,    _connector_inner_bottom ],  //3
					  [  0,                    -_connector_lower_width/2,    _connector_inner_top ],     //4
					  [ _connector_outer_edge, -magnet_holder_arm_width()/2, _connector_outer_top ],     //5
					  [ _connector_outer_edge,  magnet_holder_arm_width()/2, _connector_outer_top ],     //6
					  [  0,                     _connector_lower_width/2,    _connector_inner_top ]];    //7
					_connector_faces = [
					  [0,1,2,3],  // bottom
					  [4,5,1,0],  // front
					  [7,6,5,4],  // top
					  [5,6,2,1],  // right
					  [6,7,3,2],  // back
					  [7,4,0,3]]; // left				  
					polyhedron(points = _connector_points, faces = _connector_faces);
				}
				// minus the hole for the rod
				translate([0, 0, -magnet_holder_rod_holder_depth() - epsilon()]) 
					cylinder(d = rod_outer_diameter() + 2 * magnet_holder_rod_clearance(),
						     h = magnet_holder_rod_holder_depth() + epsilon(),
					    	 $fn = magnet_holder_resolution());
			}
			// if requested, plus the inner cylinder
			if (rod_inner_diameter() > 0) {
				translate([0, 0, -magnet_holder_rod_holder_depth()]) 
					cylinder(d = rod_inner_diameter() - 2 * magnet_holder_rod_clearance(),
						     h = magnet_holder_rod_holder_depth(),
					    	 $fn = magnet_holder_resolution());

			}

		}

	}
	if (debug) {
		ball(size = ball_diameter());
		translate([ball_diameter()/2 - 50, -50, -ball_diameter()/2 - ball_clearance])
			%cube([50, 100, ball_clearance]);
		_magnet_holder_hardware(ball_clearance = magnet_holder_top_ball_clearance());
	}
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module _magnet_holder_hardware(ball_clearance) {
	translate([0, 0, ball_center_magnet_base_distance()])
		rotate([0, 90, 0])
			magnet_ring(diameter = magnet_outer_diameter(), thickness = magnet_height());
}
