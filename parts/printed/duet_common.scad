/**********************************************************************************************************************
 **
 ** parts/printed/duet_common.scad
 **
 ** This file provides macros used by the other duet_*.scad files.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

/**
 * This module renders the vent holes used for the bottom of the Duet holder and the top of the DuetX holder.
 */
module _duet_holder_outer_vent_holes() {
	// The total width of n slots is n * duet_holder_outer_vent_width() + (n+1) * duet_holder_outer_vent_spacing() and should 
	// cover duet_holder_outer_vent_area_width().
	//     duet_holder_outer_vent_area_width() = n * duet_holder_outer_vent_width() + (n+1) * duet_holder_outer_vent_spacing()
	// <=> duet_holder_outer_vent_area_width() = n * (duet_holder_outer_vent_width() + duet_holder_outer_vent_spacing()) + duet_holder_outer_vent_spacing()
	// <=> duet_holder_outer_vent_area_width() - duet_holder_outer_vent_spacing() = n * (duet_holder_outer_vent_width() + duet_holder_outer_vent_spacing())
	// <=> n = (duet_holder_outer_vent_area_width() - duet_holder_outer_vent_spacing()) / (duet_holder_outer_vent_width() + duet_holder_outer_vent_spacing())
	// This will never be a natural number, so round off:
	_num_slots = floor((duet_holder_outer_vent_area_width() - duet_holder_outer_vent_spacing()) / 
					   (duet_holder_outer_vent_width() + duet_holder_outer_vent_spacing()));

	// the top and bottom center positions	
	_slot_lower_z = duet_holder_outer_vent_edge_clearance();
	_slot_upper_z = _slot_lower_z + duet_holder_outer_vent_area_height();

	// render the slots
	for(_slot = [0 : _num_slots - 1]) {
		_slot_center_x = duet_holder_outer_vent_edge_clearance() + duet_holder_outer_vent_spacing() + 
						 _slot * (duet_holder_outer_vent_width() + duet_holder_outer_vent_spacing()) + duet_holder_outer_vent_width() / 2;
		hull() {
			translate([_slot_center_x,
					   -epsilon(), 
					   _slot_lower_z])
				rotate([-90, 0, 0])
					cylinder(d = duet_holder_outer_vent_width(), 
							 h = 2 * duet_fan_holder_wall_thickness() + 2 * epsilon(), 
							 $fn = duet_holder_resolution());
			translate([_slot_center_x, 
					   -epsilon(), 
					   _slot_upper_z])
				rotate([-90, 0, 0])
					cylinder(d = duet_holder_outer_vent_width(), 
							 h = 2 * duet_fan_holder_wall_thickness() + 2 * epsilon(), 
							 $fn = duet_holder_resolution());
		}
	}
}

/**
 * This module renders the vent holes between the fan holder and the Duet/DuetX holders.
 */
module _duet_holder_inner_vent_holes() {
	// for better airflow, this is just one very large hole...
	translate([duet_fan_holder_inner_vent_offset_x(),
			   -epsilon(),
			   duet_fan_holder_inner_vent_offset_z()])
		cube([duet_fan_holder_inner_vent_width(),
			  2 * duet_fan_holder_wall_thickness() + 2 * epsilon(),
			  duet_fan_holder_inner_vent_height()]);
}

