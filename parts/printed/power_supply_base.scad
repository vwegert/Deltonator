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
	cylinder(d = psd_base_mount_screw_size(), 
		     h = psd_base_thickness() + epsilon(),
		     $fn = psd_cover_resolution());
	translate([0, 0, psd_base_thickness() + epsilon()])
		rotate([0, 90, head_rotation]) 
			nut_recess(psd_base_mount_screw_size());
}

/**
 * Creates the horizontal strut of the frame.
 */
module _power_supply_base_frame_hstrut() {
	difference() {
		// the strut
		cube([ps_base_outer_width_x(),
			  psd_base_strut_width(),
			  psd_base_thickness()]);
		// minus the screw holes
		translate([ps_base_outer_width_x() * 0.25,
			       psd_base_strut_width() / 2,
			       0]) 
			_power_supply_base_frame_nut_hole();
		translate([ps_base_outer_width_x() * 0.75,
			       psd_base_strut_width() / 2,
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
		cube([psd_base_strut_width(),
			  ps_base_outer_width_y(),
			  psd_base_thickness()]);
		// minus the screw holes
		translate([psd_base_strut_width() / 2,
				   ps_base_outer_width_y() * 0.25,
			       0]) 
			_power_supply_base_frame_nut_hole(head_rotation = 90);
		translate([psd_base_strut_width() / 2,
				   ps_base_outer_width_y() * 0.75,
			       0]) 
			_power_supply_base_frame_nut_hole(head_rotation = 90);
	}
}

/**
 * Creates a support pillar.
 */
module _power_supply_base_pillar() {
	_hole_z_offset = ps_base_inner_height() * 0.25;
	difference() {
		// the pillar
		cube([psd_base_strut_width(),
			  psd_base_strut_width(),
			  ps_base_inner_height()]);
		// minus the screw hole
		translate([psd_base_strut_width() / 2,
				   psd_base_strut_width() / 2,
				   _hole_z_offset + epsilon()])
				cylinder(d = tap_base_diameter(size = psd_base_mount_screw_size()), 
					     h = ps_base_pillar_hole_depth(),
					     $fn = psd_cover_resolution());
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
		translate([ps_base_outer_width_x() - psd_base_strut_width(), 0, 0])
			_power_supply_base_frame_vstrut();
	}
}

/**
 * Creates the base assembly by rendering it from scratch. This module is not to be called externally, use 
 * power_supply_base() instead.
 */
module _render_power_supply_base() {
	color_printed_psd_case()
		render() {
			union() {
				// the base frame
				_power_supply_base_frame();
				// the support pillars
				_power_supply_base_pillar();
				translate([0, ps_base_outer_width_y() - psd_base_strut_width(), 0])
					_power_supply_base_pillar();
				translate([ps_base_outer_width_x() - psd_base_strut_width(), 0, 0])
					_power_supply_base_pillar();
				translate([ps_base_outer_width_x() - psd_base_strut_width(), ps_base_outer_width_y() - psd_base_strut_width(), 0])
					_power_supply_base_pillar();
			}
		} 
}

/**
 * Main module to use the pre-rendered base. 
 */
module power_supply_base() {
	bom_entry(section = "Printed Parts", description = "Power Supply and Distribution", size = "Power Supply Base");
	color_printed_psd_case()
		import(file = "power_supply_base.stl");
}

/**
 * Renders a nut to be placed in the base struts.
 */
module _power_supply_base_nut_screw(head_rotation = 0, screw_material_thickness = 6) {
	translate([0, 0, psd_base_thickness()])
		rotate([0, 90, head_rotation])
			nut(size = psd_base_mount_screw_size());
	translate([0, 0, -(screw_material_thickness + washer_thickness(size = psd_base_mount_screw_size()))]) 
		rotate([0, -90, 0]) {
			screw(size = psd_base_mount_screw_size(),
				  min_length = psd_base_mount_screw_min_length());
			washer(size = psd_base_mount_screw_size());
		}
} 

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module power_supply_base_hardware(screw_material_thickness = 6) {

	// horizontal strut
	translate([ps_base_outer_width_x() * 0.25, 
			   psd_base_strut_width() / 2, 
			   0])
		_power_supply_base_nut_screw(screw_material_thickness = screw_material_thickness);
	translate([ps_base_outer_width_x() * 0.75, 
			   psd_base_strut_width() / 2, 
			   0])
		_power_supply_base_nut_screw(screw_material_thickness = screw_material_thickness);

	// left vertical strut
	translate([psd_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.25, 
			   0])
		_power_supply_base_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);
	translate([psd_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.75, 
			   0])
		_power_supply_base_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);

	// right vertical strut
	translate([ps_base_outer_width_x() - psd_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.25, 
			   0])
		_power_supply_base_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);
	translate([ps_base_outer_width_x() - psd_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.75, 
			   0])
		_power_supply_base_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);

}

/**
 * Renders a set of cylinders designed to "punch holes" in the surface the bracket is mounted to.
 */
module power_supply_base_punch(hole_depth = 100) {
	// horizontal strut
	translate([ps_base_outer_width_x() * 0.25, 
			   psd_base_strut_width() / 2, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());
	translate([ps_base_outer_width_x() * 0.75, 
			   psd_base_strut_width() / 2, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());

	// left vertical strut
	translate([psd_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.25, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());
	translate([psd_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.75, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());

	// right vertical strut
	translate([ps_base_outer_width_x() - psd_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.25, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());
	translate([ps_base_outer_width_x() - psd_base_strut_width() / 2, 
			   ps_base_outer_width_y() * 0.75, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());
}

_render_power_supply_base();
