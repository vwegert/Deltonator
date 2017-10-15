/**********************************************************************************************************************
 **
 ** parts/printed/power_supply_base.scad
 **
 ** This file constructs the base that the connector side of the power supply is mounted into.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

/**
 * Renders a hole with a nut recess for one of the base struts.
 */
module _power_supply_base_frame_nut_hole(head_rotation = 0) {
	cylinder(d = ps_base_mount_screw_size(), 
		     h = ps_base_thickness() + epsilon(),
		     $fn = ps_cover_resolution());
	translate([0, 0, ps_base_thickness() + epsilon()])
		rotate([0, 90, head_rotation]) 
			nut_recess(ps_base_mount_screw_size());
}

/**
 * Creates the horizontal strut of the frame.
 */
module _power_supply_base_frame_hstrut() {
	difference() {
		// the strut
		cube([ps_base_outer_width_x(),
			  ps_base_strut_width(),
			  ps_base_thickness()]);
		// minus the screw holes
		translate([ps_base_outer_width_x() * 0.25,
			       ps_base_strut_width() / 2,
			       0]) 
			_power_supply_base_frame_nut_hole();
		translate([ps_base_outer_width_x() * 0.75,
			       ps_base_strut_width() / 2,
			       0]) 
			_power_supply_base_frame_nut_hole();

	}
}

/**
 * Creates the vertical strut of the frame.
 */
module _power_supply_base_frame_vstrut() {
	difference() {
		// the strut
		cube([ps_base_strut_width(),
			  ps_base_outer_width_y(),
			  ps_base_thickness()]);
		// minus the screw holes
		translate([ps_base_strut_width() / 2,
				   ps_base_outer_width_y() * 0.25,
			       0]) 
			_power_supply_base_frame_nut_hole(head_rotation = 90);
		translate([ps_base_strut_width() / 2,
				   ps_base_outer_width_y() * 0.75,
			       0]) 
			_power_supply_base_frame_nut_hole(head_rotation = 90);
	}
}

/**
 * Creates a support pillar.
 */
module _power_supply_base_pillar() {
	_hole_depth = ps_base_inner_height() * 0.75;
	_hole_z_offset = ps_base_inner_height() * 0.25;
	difference() {
		// the pillar
		cube([ps_base_strut_width(),
			  ps_base_strut_width(),
			  ps_base_inner_height()]);
		// minus the screw hole
		translate([ps_base_strut_width() / 2,
				   ps_base_strut_width() / 2,
				   _hole_z_offset + epsilon()])
				cylinder(d = tap_base_diameter(size = ps_base_mount_screw_size()), 
					     h = _hole_depth,
					     $fn = ps_cover_resolution());
	}
}

/**
 * Creates the frame that is mounted to the enclosure plate.
 */
module _power_supply_base_frame() {
	union() {		
		// the bottom horizontal strut
		_power_supply_base_frame_hstrut();
		// the vertical struts
		_power_supply_base_frame_vstrut();
		translate([ps_base_outer_width_x() - ps_base_strut_width(), 0, 0])
			_power_supply_base_frame_vstrut();
		// the support pillars
		_power_supply_base_pillar();
		translate([0, ps_base_outer_width_y() - ps_base_strut_width(), 0])
			_power_supply_base_pillar();
		translate([ps_base_outer_width_x() - ps_base_strut_width(), 0, 0])
			_power_supply_base_pillar();
		translate([ps_base_outer_width_x() - ps_base_strut_width(), ps_base_outer_width_y() - ps_base_strut_width(), 0])
			_power_supply_base_pillar();
	}
}

/**
 * Creates the base assembly by rendering it from scratch. This module is not to be called externally, use 
 * power_supply_base() instead.
 */
module _render_power_supply_base() {
	color_printed_ps_case()
		render() {
			union() {
				_power_supply_base_frame();
			}
		} 
}

/**
 * Main module to use the pre-rendered base. 
 */
module power_supply_base() {
	bom_entry(section = "Printed Parts", description = "Power Supply and Distribution", size = "Power Supply Base");
	color_printed_ps_case()
		import(file = "power_supply_base.stl");
}

/**
 * Renders a nut to be placed in the base struts.
 */
module _power_supply_base_nut_screw(head_rotation = 0) {
	translate([0, 0, ps_base_thickness()])
		rotate([0, 90, head_rotation])
			nut(size = ps_base_mount_screw_size());
	translate([0, 0, -(enclosure_solid_thickness() + washer_thickness(size = ps_base_mount_screw_size()))]) 
		rotate([0, -90, 0]) {
			screw(size = ps_base_mount_screw_size(),
				  min_length = ps_base_mount_screw_min_length());
			washer(size = ps_base_mount_screw_size());
		}
} 

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module power_supply_base_hardware(screw_material_thickness = 6) {

	// the nuts in the horizontal strut
	translate([ps_base_outer_width_x() * 0.25, 
			   ps_base_strut_width() / 2, 
			   0])
		_power_supply_base_nut_screw();
	translate([ps_base_outer_width_x() * 0.75, 
			   ps_base_strut_width() / 2, 
			   0])
		_power_supply_base_nut_screw();

	// the nuts in the left vertical strut
	translate([ps_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.25, 
			   0])
		_power_supply_base_nut_screw(head_rotation = 90);
	translate([ps_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.75, 
			   0])
		_power_supply_base_nut_screw(head_rotation = 90);

	// the nuts in the right vertical strut
	translate([ps_base_outer_width_x() - ps_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.25, 
			   0])
		_power_supply_base_nut_screw(head_rotation = 90);
	translate([ps_base_outer_width_x() - ps_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.75, 
			   0])
		_power_supply_base_nut_screw(head_rotation = 90);

}

_render_power_supply_base();
