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
use <carriage_ball_holder.scad>

/**
 * Produces the dovetail shapes that will be cut out from the top of the carriate to accomodate the ball holders.
 */
module _carriage_ball_holder_cutout() {
	_cutout_inner_top    = 0;
	_cutout_inner_bottom = -carriage_ball_holder_height();
	_cutout_outer_top    = 0;
	_cutout_outer_bottom = -carriage_ball_holder_height() - tan(carriage_ball_holder_angle()) * carriage_plate_thickness();
	_cutout_points = [
	  [  0,                          -carriage_ball_holder_joint_inner_width()/2,    _cutout_inner_bottom ],  //0
	  [ -carriage_plate_thickness(), -carriage_ball_holder_joint_outer_width()/2, _cutout_outer_bottom ],  //1
	  [ -carriage_plate_thickness(),  carriage_ball_holder_joint_outer_width()/2, _cutout_outer_bottom ],  //2
	  [  0,                           carriage_ball_holder_joint_inner_width()/2,    _cutout_inner_bottom ],  //3
	  [  0,                          -carriage_ball_holder_joint_inner_width()/2,    _cutout_inner_top ],     //4
	  [ -carriage_plate_thickness(), -carriage_ball_holder_joint_outer_width()/2, _cutout_outer_top ],     //5
	  [ -carriage_plate_thickness(),  carriage_ball_holder_joint_outer_width()/2, _cutout_outer_top ],     //6
	  [  0,                           carriage_ball_holder_joint_inner_width()/2,    _cutout_inner_top ]];    //7
	_cutout_faces = [
	  [0,1,2,3],  // bottom
	  [4,5,1,0],  // front
	  [7,6,5,4],  // top
	  [5,6,2,1],  // right
	  [6,7,3,2],  // back
	  [7,4,0,3]]; // left				  
	polyhedron(points = _cutout_points, faces = _cutout_faces);
}


/**
 * Renders the lower part of the base plate of the carriage that holds the wheels.
 */
module _carriage_base_plate() {
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

		// minus the gap for the belt tensioner
		translate([0, -carriage_tensioner_gap_width()/2, carriage_plate_height() - carriage_tensioner_gap_height()])
			cube([carriage_plate_thickness(), carriage_tensioner_gap_width(), carriage_tensioner_gap_height()]);

		// minus the cutouts for the ball holders
		translate([carriage_plate_thickness(), -rod_distance()/2, carriage_plate_height()])
			_carriage_ball_holder_cutout();
		translate([carriage_plate_thickness(), rod_distance()/2, carriage_plate_height()])
			_carriage_ball_holder_cutout();
	}
}

/**
 * Renders the set of blocks that clamp onto the belt.
 * This assembly is drawn for the lower belt and has to be mirrored for the upper part.
 * The origin of this assembly is at the bottom where the belt enters the blocks.
 * Due to the way that linear_extrude works, the blocks are drawn in the XY plane, extruded and then rotated.
 * This means that absolute target +Z is -X here.
 */
module _carriage_belt_holder() {
	translate([carriage_belt_holder_depth(), 0, 0])
		rotate([0, -90, 0])
			linear_extrude(height = carriage_belt_holder_depth()) {
				difference() {
					union() {
		
						// shorthands to keep things readable
						_er = carriage_belt_holder_edge_radius();
						_ser = carriage_belt_holder_small_edge_radius();
						_res = carriage_belt_holder_edge_resolution();
		
						// the center part is created as a hull of four cylinders, the lower right one being much smaller 
						// than the others
						union() {
							_cp_height       = carriage_belt_holder_center_height();
							_cp_bottom_width = carriage_belt_holder_width() - 
							                   2 * carriage_belt_holder_outer_width() - 
							                   carriage_belt_holder_channel_width() - 
							                   carriage_belt_holder_path_width() - 1;
							_cp_top_width    = _cp_bottom_width - _cp_height - 1; // 45° slope
							_cp_left         = -_cp_bottom_width - carriage_belt_holder_channel_width()/2 - 0.5;
							_cp_top_right    = _cp_left + _cp_top_width;
							_cp_bottom_right = _cp_left + _cp_bottom_width;
							_cp_top          = carriage_belt_holder_height() - carriage_belt_holder_path_width();
							_cp_bottom       = _cp_top - _cp_height;
							hull() {
								// top left corner
								translate([_cp_top - _er, _cp_left + _er])
									circle(r = _er, $fn = _res);
								// bottom left corner
								translate([_cp_bottom + _er, _cp_left + _er])
									circle(r = _er, $fn = _res);
								// top right corner
								translate([_cp_top - _er, _cp_top_right - _er])
									circle(r = _er, $fn = _res);
								// bottom right corner
								translate([_cp_bottom + _ser, _cp_bottom_right - _ser])
									circle(r = _ser, $fn = _res);
							}
						}
		
						union() {
							// bottom part
							_lp_rh_width  = carriage_belt_holder_width() - 
							                carriage_belt_holder_outer_width() - 
							                carriage_belt_holder_channel_width();
							_lp_rh_height = carriage_belt_holder_height() - 
							                2 * carriage_belt_holder_path_width() - 
							                carriage_belt_holder_center_height();
							_lp_rh_left   = -_lp_rh_width - carriage_belt_holder_channel_width()/2;
							_lp_rh_right  = -carriage_belt_holder_channel_width()/2;
							_lp_rh_bottom = 0;
							_lp_rh_top    = _lp_rh_bottom + _lp_rh_height;
							hull() {
								// lower right corner
								translate([_lp_rh_bottom + _er, _lp_rh_right - _er])
									circle(r = _er, $fn = _res);
								// upper right corner
								translate([_lp_rh_top - _er , _lp_rh_right - _er])
									circle(r = _er, $fn = _res);
								// upper left corner
								translate([_lp_rh_top - _er, _lp_rh_left + _er])
									circle(r = _er, $fn = _res);
							}
				
							// left part
							_lp_lh_width  = carriage_belt_holder_outer_width();
							_lp_lh_height = carriage_belt_holder_center_height() + 
							                2 * carriage_belt_holder_path_width() + 2*_er;
							//_lp_lh_left   = -_lp_lh_width - _lp_rh_width - carriage_belt_holder_channel_width()/2;
							_lp_lh_left   = - carriage_belt_holder_width() +
							                carriage_belt_holder_channel_width()/2 +
							                carriage_belt_holder_outer_width();
							_lp_lh_right  = _lp_lh_left + _lp_lh_width;
							_lp_lh_bottom = carriage_belt_holder_height() - _lp_lh_height;
							_lp_lh_top    = _lp_lh_bottom + _lp_lh_height;
							hull() {
								// lower right corner
								translate([_lp_lh_bottom + _er, _lp_lh_right - _er])
									circle(r = _er, $fn = _res);
								// upper right corner
								translate([_lp_lh_top - _er, _lp_lh_right - _er])
									circle(r = _er, $fn = _res);
								// lower left corner
								translate([_lp_lh_bottom + _er, _lp_lh_left + _er])
									circle(r = _er, $fn = _res);
								// upper left corner
								translate([_lp_lh_top - _er, _lp_lh_left + _er])
									circle(r = _er, $fn = _res);
							}
						}
		
						// the right part consists of two hulls - an upper and a lower one
						union() {
		
							// the upper hull is formed using two cylinders at the top and a cube at the bottom
							_rp_uh_height       = carriage_belt_holder_center_height() + carriage_belt_holder_path_width();
							_rp_uh_bottom_width = carriage_belt_holder_outer_width();
							_rp_uh_top_width    = _rp_uh_bottom_width + _rp_uh_height; // 45° slope
							_rp_uh_right        = carriage_belt_holder_channel_width()/2 + _rp_uh_bottom_width;
							_rp_uh_top_left     = _rp_uh_right - _rp_uh_top_width + _er/2;
							_rp_uh_bottom_left  = _rp_uh_right - _rp_uh_bottom_width;
							_rp_uh_top          = carriage_belt_holder_height();
							_rp_uh_bottom       = carriage_belt_holder_height() - _rp_uh_height;
							hull() {
								// lower horizontal bar
								translate([_rp_uh_bottom, _rp_uh_bottom_left])
									square([_er, _rp_uh_bottom_width]);
								// upper right corner
								translate([_rp_uh_top - _er, _rp_uh_right - _er])
									circle(r = _er, $fn = _res);
								// upper left corner
								translate([_rp_uh_top - _er, _rp_uh_top_left + _er])
									circle(r = _er, $fn = _res);
							}
		
							// the lower hull is formed of a corresponding cube at the top and two cylinders at the bottom
							_rp_lh_height = carriage_belt_holder_height() - _rp_uh_height;
							_rp_lh_width  = carriage_belt_holder_outer_width();
							_rp_lh_right  = carriage_belt_holder_channel_width()/2 + _rp_lh_width;
							_rp_lh_left   = _rp_lh_right - _rp_lh_width;
							_rp_lh_bottom = 0;
							_rp_lh_top    = _rp_lh_bottom + _rp_lh_height;
							hull() {
								// upper horizontal bar
								translate([_rp_lh_top - _er, _rp_lh_left])
									square([_er, _rp_lh_width]);
								// lower left corner
								translate([_rp_lh_bottom + _er, _rp_lh_left + _er])
									circle(r = _er, $fn = _res);
								// lower right corner
								translate([_rp_lh_bottom + _er, _rp_lh_right - _er])
									circle(r = _er, $fn = _res);
							}
						}

					} // union of blocks

					// minus the hole for the threaded insert
					translate([carriage_belt_holder_insert_y(), carriage_belt_holder_insert_x(), 0])
						circle(d = carriage_belt_holder_insert_hole_diameter(), 
							$fn = carriage_belt_holder_edge_resolution());
				} // difference

			} // linear_extrude
}

/**
 * Creates the carriage assembly by rendering it from scratch. This module is not to be called externally, use 
 * carriage() instead.
 */
module _render_carriage() {
	color_printed_carriage()
		render() {
			// the base plate			
			_carriage_base_plate();
			
			// the lower belt holder
			translate([carriage_plate_thickness(), -gt2_pulley_inner_diameter_min()/2, carriage_lower_belt_holder_z()])
				_carriage_belt_holder();
			
			// the upper belt holder
			translate([carriage_plate_thickness(), -gt2_pulley_inner_diameter_min()/2, carriage_upper_belt_holder_z()])
				mirror([0, 0, 1])
					_carriage_belt_holder();
		} 
}

/**
 * Main module to use the pre-rendered carriage. The assembly is centered on the Z axis in Y direction for easier 
 * manipulation, similar to the MakerSlide extrusion. 
 */
module carriage() {
	bom_entry(section = "Printed Parts", description = "Arm", size = "Carriage");
	color_printed_carriage()
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
	translate([-(washer_thickness(M5) + epsilon()), 0, 0])
		washer(M5);
	// wheel assembly
	_vwheel_x = -(washer_thickness(M5) + epsilon() + 
		          vwheel_assembly_thickness() - vwheel_assembly_overhang() + epsilon()); 
	translate([_vwheel_x, 0, 0])
		vslot_wheel(include_bearings = true);
	// washer on the outer side of the wheel
	_outer_washer_x = _vwheel_x - vwheel_assembly_overhang() - epsilon() - washer_thickness(M5);
	translate([_outer_washer_x, 0, 0])
		washer(M5);
	// screw
	_screw_min_length = 3 * washer_thickness(M5) + carriage_plate_thickness() + 
	                    vwheel_assembly_thickness() + nut_thickness(M5);
	_screw_max_length = 2 * washer_thickness(M5) + carriage_plate_thickness() + 
	                    vwheel_assembly_thickness()/2 + makerslide_base_depth();
	translate([carriage_plate_thickness() + epsilon() + washer_thickness(M5) + epsilon(), 0, 0])
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
	translate([-(washer_thickness(M5) + epsilon()), 0, 0])
		washer(M5);
	// wheel assembly
	_vwheel_x = -(washer_thickness(M5) + epsilon() + 
		          vwheel_assembly_thickness() - vwheel_assembly_overhang() + epsilon()); 
	translate([_vwheel_x, 0, 0])
		vslot_wheel(include_bearings = true);
	// washer on the outer side of the wheel
	_outer_washer_x = _vwheel_x - vwheel_assembly_overhang() - epsilon() - washer_thickness(M5);
	translate([_outer_washer_x, 0, 0])
		washer(M5);
	// screw
	_screw_min_length = 3 * washer_thickness(M5) + vwheel_spacer_hex_height() + carriage_plate_thickness() + 
	                    vwheel_assembly_thickness() + nut_thickness(M5);
	_screw_max_length = 2 * washer_thickness(M5) + vwheel_spacer_hex_height() + carriage_plate_thickness() +
					    vwheel_assembly_thickness()/2 + makerslide_base_depth();
	translate([_inner_washer_x + epsilon() + washer_thickness(M5) + epsilon(), 0, 0])
		rotate([0, 180, 0])
			screw(size = M5, min_length = _screw_min_length, max_length = _screw_max_length); 
	// nut
	_nut_x = _outer_washer_x - epsilon();
	translate([_nut_x, 0, 0])
		rotate([0, 180, 0])
			nut(M5);
}

/**
 * Renders the hardware used to hold the belt in place.
 */
module _carriage_hardware_belt_fixation() { 
	translate([0, carriage_belt_holder_insert_x(), carriage_belt_holder_insert_y()]) {
		// the threaded insert
		_insert_size = 7;
		insert(size = M3, length = _insert_size);
		// a washer on top
		translate([carriage_belt_holder_depth() + epsilon(), 0, 0])
			washer_large(size = M3);
		// the screw to hold everything in place
		translate([carriage_belt_holder_depth() + epsilon() + washer_thickness_large(M3) + epsilon(), 0, 0])
			rotate(180, 0, 0)
				screw(size = M3, 
					min_length = washer_thickness_large(M3), 
					max_length = washer_thickness_large(M3) + _insert_size);
	}
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

	// the belt fixation for the lower holder
	translate([carriage_plate_thickness(), -gt2_pulley_inner_diameter_min()/2, carriage_lower_belt_holder_z()])
		_carriage_hardware_belt_fixation();

	// the belt fixation for the upper holder
	translate([carriage_plate_thickness(), -gt2_pulley_inner_diameter_min()/2, carriage_upper_belt_holder_z()])
		mirror([0, 0, 1])
			_carriage_hardware_belt_fixation();
}

_render_carriage();
