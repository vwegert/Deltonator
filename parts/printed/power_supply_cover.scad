/**********************************************************************************************************************
 **
 ** parts/printed/power_supply_cover.scad
 **
 ** This file constructs the cover above the connector side of the power supply.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

/**
 * Creates the top face of the cover.
 */
module _power_supply_cover_top() {
	translate([0,
			   0,
			   ps_cover_outer_height() - psd_cover_wall_thickness()])
		difference() {
			// the plate
			cube([ps_cover_outer_width_x(),
				  ps_cover_outer_width_y(),
				  psd_cover_wall_thickness()]);
			// minus the screw holes 
			_screw_offsets = ps_cover_screw_offset();
			for (i = [0:3])
				translate(_screw_offsets[i])
					cylinder(d = ps_base_mount_screw_size(),
							 h = psd_cover_wall_thickness() + epsilon(),
							 $fn = psd_cover_resolution());
		}
}

/**
 * Creates the left face of the cover.
 */
module _power_supply_cover_left() {
	cube([psd_cover_wall_thickness(),
		  ps_cover_outer_width_y(),
		  ps_cover_outer_height()]);
}

/**
 * Creates the right face of the cover.
 */
module _power_supply_cover_right() {
	translate([ps_cover_outer_width_x() - psd_cover_wall_thickness(),
			   0,
			   0]) 
		difference() {
			// the wall
			cube([psd_cover_wall_thickness(),
				  ps_cover_outer_width_y(),
				  ps_cover_outer_height()]);
			// minus the cut-out to pass the cables over to the power distribution side
			translate([-epsilon(),
					   psd_cable_slot_offset(),
					   0])
				cube([psd_cover_wall_thickness() + 2 * epsilon(),
					   psd_cable_slot_width(),
					   psd_cable_slot_height()]);
		}
}

/**
 * Creates the bottom face of the cover.
 */
module _power_supply_cover_bottom() {
	difference() {
		// the wall
		cube([ps_cover_outer_width_x(),
			  psd_cover_wall_thickness(),
			  ps_cover_outer_height()]);
		// minus the venting psd_cable_slot_offset

		// The total width of n slots is n * ps_cover_vent_width() + (n+1) * ps_cover_vent_spacing() and should 
		// cover ps_cover_vent_area_width().
		//     ps_cover_vent_area_width() = n * ps_cover_vent_width() + (n+1) * ps_cover_vent_spacing()
		// <=> ps_cover_vent_area_width() = n * (ps_cover_vent_width() + ps_cover_vent_spacing()) + ps_cover_vent_spacing()
		// <=> ps_cover_vent_area_width() - ps_cover_vent_spacing() = n * (ps_cover_vent_width() + ps_cover_vent_spacing())
		// <=> n = (ps_cover_vent_area_width() - ps_cover_vent_spacing()) / (ps_cover_vent_width() + ps_cover_vent_spacing())
		// This will never be a natural number, so round off:
		_num_slots = floor((ps_cover_vent_area_width() - ps_cover_vent_spacing()) / 
						   (ps_cover_vent_width() + ps_cover_vent_spacing()));

		// the top and bottom center positions	
		_slot_lower_z = ps_cover_vent_edge_clearance();
		_slot_upper_z = _slot_lower_z + ps_cover_vent_area_height();

		// render the slots
		for(_slot = [0 : _num_slots - 1]) {
			_slot_center_x = ps_cover_vent_edge_clearance() + ps_cover_vent_spacing() + 
							 _slot * (ps_cover_vent_width() + ps_cover_vent_spacing()) + ps_cover_vent_width() / 2;
			hull() {
				translate([_slot_center_x,
						   -epsilon(), 
						   _slot_lower_z])
					rotate([-90, 0, 0])
						cylinder(d = ps_cover_vent_width(), 
								 h = psd_cover_wall_thickness() + 2 * epsilon(), 
								 $fn = psd_cover_resolution());
				translate([_slot_center_x, 
						   -epsilon(), 
						   _slot_upper_z])
					rotate([-90, 0, 0])
						cylinder(d = ps_cover_vent_width(), 
								 h = psd_cover_wall_thickness() + 2 * epsilon(), 
								 $fn = psd_cover_resolution());
			}
		}

	}
}

/**
 * Creates the base assembly by rendering it from scratch. This module is not to be called externally, use 
 * power_supply_cover() instead.
 */
module _render_power_supply_cover() {
	color_printed_ps_case()
		render() {
			union() {
				_power_supply_cover_top();
				_power_supply_cover_left();
				_power_supply_cover_right();
				_power_supply_cover_bottom();
			}
		} 
}

/**
 * Main module to use the pre-rendered base. 
 */
module power_supply_cover() {
	bom_entry(section = "Printed Parts", description = "Power Supply and Distribution", size = "Power Supply Cover");
	color_printed_ps_case()
		translate(ps_cover_offset())
			import(file = "power_supply_cover.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module power_supply_cover_hardware() {
	translate([0,
			   0,
			   ps_cover_outer_height() + washer_thickness(size = ps_base_mount_screw_size())]) {
		_screw_offsets = ps_cover_screw_offset();
		for (i = [0:3])
			translate(_screw_offsets[i]) {
				rotate([0, 90, 0])
 				screw(size = ps_base_mount_screw_size(),				
	 				  min_length = ps_cover_screw_min_length(),
	 				  max_length = ps_cover_screw_max_length());
				rotate([0, 90, 0])
	 			washer(size = ps_base_mount_screw_size());
		}
	}
}

_render_power_supply_cover();

