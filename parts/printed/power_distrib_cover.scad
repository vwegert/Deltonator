/**********************************************************************************************************************
 **
 ** parts/printed/power_distrib_cover.scad
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
 * Creates the "lid" of the cover.
 */
module _power_distrib_cover_lid() {
	translate([0,
			   0,
			   pd_cover_outer_height() - psd_cover_wall_thickness()])
		difference() {
			// the plate
			cube([pd_cover_outer_width_x(),
				  pd_cover_outer_width_y(),
				  psd_cover_wall_thickness()]);
			// minus the screw holes 
			_screw_offsets = pd_cover_screw_offset();
			for (i = [0:3])
				translate(_screw_offsets[i])
					cylinder(d = psd_base_mount_screw_size(),
							 h = psd_cover_wall_thickness() + epsilon(),
							 $fn = psd_cover_resolution());
		}
}

/**
 * Creates the left face of the cover.
 */
module _power_distrib_cover_left() {
		difference() {
			// the wall
			cube([psd_cover_wall_thickness(),
				  pd_cover_outer_width_y(),
				  pd_cover_outer_height()]);
			// minus the cut-out to pass the cables over to the power distribution side
			translate([-epsilon(),
					   psd_cable_slot_offset(),
					   0])
				cube([psd_cover_wall_thickness() + 2 * epsilon(),
					   psd_cable_slot_width(),
					   psd_cable_slot_height()]);
		}
}

module _power_distrib_cover_connector_cutouts() {

	_cutout_thickness = pd_cover_pcsfa_support_size_x() + psd_cover_wall_thickness();

	// the main cutout
	translate([-epsilon() - pd_cover_pcsfa_support_size_x(), 
		       -pcsfa_width() / 2, 
		       0])
		cube([_cutout_thickness + 2 * epsilon(), 
			  pcsfa_width(), 
			  pcsfa_height()]);
	// the screw holes
	translate([-epsilon() - pd_cover_pcsfa_support_size_x(), 
			   -pcsfa_screw_hole_distance() / 2, 
			   pcsfa_height() / 2])
		rotate([0, 90, 0])
			cylinder(d = pcsfa_screw_hole_diameter(), 
					 h = _cutout_thickness + 2 * epsilon(), 
					 $fn = psd_cover_resolution());
	translate([-epsilon() - pd_cover_pcsfa_support_size_x(), 
			   pcsfa_screw_hole_distance() / 2, 
			   pcsfa_height() / 2])
		rotate([0, 90, 0])
			cylinder(d = pcsfa_screw_hole_diameter(), 
					 h = _cutout_thickness + 2 * epsilon(), 
					 $fn = psd_cover_resolution());
}

/**
 * Creates the right face of the cover with the power connector.
 */
module _power_distrib_cover_right() {
	translate([pd_cover_outer_width_x() - psd_cover_wall_thickness(),
			   0,
			   0]) 
		difference() {
			union() {
				// the wall
				cube([psd_cover_wall_thickness(),
					  pd_cover_outer_width_y(),
					  pd_cover_outer_height()]);
				// plus the thickened part to hold the power connector assembly
				translate(pd_cover_pcsfa_support_offset())
					cube([pd_cover_pcsfa_support_size_x(),
						  pd_cover_pcsfa_support_size_y(),
						  pd_cover_pcsfa_support_size_z()]);
			}
			// minus the cutouts for the connector
			translate([0,
					   pd_cover_pcsfa_offset_y(),
					   pd_cover_pcsfa_offset_z()])
				_power_distrib_cover_connector_cutouts();
		}
}

/**
 * Creates the top/bottom face of the cover (used for both).
 */
module _power_distrib_cover_top_bottom() {
	difference() {
		// the wall
		cube([pd_cover_outer_width_x(),
			  psd_cover_wall_thickness(),
			  pd_cover_outer_height()]);
		// minus the venting psd_cable_slot_offset

		// The total width of n slots is n * pd_cover_vent_width() + (n+1) * pd_cover_vent_spacing() and should 
		// cover pd_cover_vent_area_width().
		//     pd_cover_vent_area_width() = n * pd_cover_vent_width() + (n+1) * pd_cover_vent_spacing()
		// <=> pd_cover_vent_area_width() = n * (pd_cover_vent_width() + pd_cover_vent_spacing()) + pd_cover_vent_spacing()
		// <=> pd_cover_vent_area_width() - pd_cover_vent_spacing() = n * (pd_cover_vent_width() + pd_cover_vent_spacing())
		// <=> n = (pd_cover_vent_area_width() - pd_cover_vent_spacing()) / (pd_cover_vent_width() + pd_cover_vent_spacing())
		// This will never be a natural number, so round off:
		_num_slots = floor((pd_cover_vent_area_width() - pd_cover_vent_spacing()) / 
						   (pd_cover_vent_width() + pd_cover_vent_spacing()));

		// the top and bottom center positions	
		_slot_lower_z = pd_cover_vent_edge_clearance();
		_slot_upper_z = _slot_lower_z + pd_cover_vent_area_height();

		// render the slots
		for(_slot = [0 : _num_slots - 1]) {
			_slot_center_x = pd_cover_vent_edge_clearance() + pd_cover_vent_spacing() + 
							 _slot * (pd_cover_vent_width() + pd_cover_vent_spacing()) + pd_cover_vent_width() / 2;
			hull() {
				translate([_slot_center_x,
						   -epsilon(), 
						   _slot_lower_z])
					rotate([-90, 0, 0])
						cylinder(d = pd_cover_vent_width(), 
								 h = psd_cover_wall_thickness() + 2 * epsilon(), 
								 $fn = psd_cover_resolution());
				translate([_slot_center_x, 
						   -epsilon(), 
						   _slot_upper_z])
					rotate([-90, 0, 0])
						cylinder(d = pd_cover_vent_width(), 
								 h = psd_cover_wall_thickness() + 2 * epsilon(), 
								 $fn = psd_cover_resolution());
			}
		}
	}
}

/**
 * Creates the top face of the cover.
 */
module _power_distrib_cover_top() {
	translate([0,
			   pd_cover_outer_width_y() - psd_cover_wall_thickness(),
			   0])
		_power_distrib_cover_top_bottom();
}

/**
 * Creates the bottom face of the cover.
 */
module _power_distrib_cover_bottom() {
	_power_distrib_cover_top_bottom();
}

/**
 * Creates the cover assembly by rendering it from scratch. This module is not to be called externally, use 
 * power_distrib_cover() instead.
 */
module _render_power_distrib_cover() {
	color_printed_psd_case()
		render() {
			union() {
				_power_distrib_cover_lid();
				_power_distrib_cover_top();
				_power_distrib_cover_left();
				_power_distrib_cover_right();
				_power_distrib_cover_bottom();
			}
		} 
}

/**
 * Main module to use the pre-rendered cover. 
 */
module power_distrib_cover() {
	bom_entry(section = "Printed Parts", description = "Power Supply and Distribution", size = "Power Distribution Cover");
	color_printed_psd_case()
		translate(pd_cover_offset())
			import(file = "power_distrib_cover.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module power_distrib_cover_hardware() {
	translate(pd_cover_offset())
		translate([0,
				   0,
				   pd_cover_outer_height() + washer_thickness(size = psd_base_mount_screw_size())]) {
			_screw_offsets = pd_cover_screw_offset();
			for (i = [0:3])
				translate(_screw_offsets[i]) {
					rotate([0, 90, 0])
 					screw(size = psd_base_mount_screw_size(),				
		 				  min_length = pd_cover_screw_min_length(),
		 				  max_length = pd_cover_screw_max_length());
					rotate([0, 90, 0])
		 			washer(size = psd_base_mount_screw_size());
			}
		}
}

_render_power_distrib_cover();

