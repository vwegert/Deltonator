/**********************************************************************************************************************
 **
 ** parts/printed/duet_fan_holder.scad
 **
 ** This file constructs the fan holder for the DuetWifi and DuetX electronics.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

use <duet_common.scad>

/**
 * Creates the left wall (as mounted - min X) of the holder.
 */
module _duet_fan_holder_wall_left() {
	cube([duet_fan_holder_wall_thickness(),
		  duet_fan_holder_size_y(),
		  duet_fan_holder_size_z()]);
}

/**
 * Creates the right wall (as mounted - max X) of the holder.
 */
module _duet_fan_holder_wall_right() {
	translate([duet_fan_holder_size_x() - duet_fan_holder_wall_thickness(),
		       0,
		       0])
		cube([duet_fan_holder_wall_thickness(),
			  duet_fan_holder_size_y(),
			  duet_fan_holder_size_z()]);
}

/**
 * Creates the bottom wall (as mounted - min Y) of the holder.
 */
module _duet_fan_holder_wall_bottom() {
	difference() {
		// the wall
		cube([duet_fan_holder_size_x(),
			  duet_fan_holder_wall_thickness(),
			  duet_fan_holder_size_z()]);
		// minus the vent holes
		_duet_holder_inner_vent_holes();
		// minus a hole for the fan power cables
		// TODO
	}
}

/**
 * Creates the top wall (as mounted - max Y) of the holder.
 */
module _duet_fan_holder_wall_top() {
	translate([0,
		       duet_fan_holder_size_y() - duet_fan_holder_wall_thickness(),
		       0])
		difference() {
			// the wall
			cube([duet_fan_holder_size_x(),
				  duet_fan_holder_wall_thickness(),
				  duet_fan_holder_size_z()]);
			// minus the vent holes
			_duet_holder_inner_vent_holes();
		}
}

/**
 * Renders a negative image of the fan grill with its origin placed at the center of the fan.
 */
module _duet_fan_holder_fan_grill() {
	_grill_height = duet_fan_holder_wall_thickness() + 2 * epsilon();	

	difference() {
		// the outer shape of the grill 
		cylinder(d = efan_outer_vent_diameter(), h = _grill_height, $fn = duet_fan_holder_resolution());

		// minus the center piece
		cylinder(d = efan_inner_vent_diameter(), h = _grill_height, $fn = duet_fan_holder_resolution());
		
		// minus the concentric ring-shaped struts
		_ring_width = duet_fan_holder_grill_strut_spacing() + duet_fan_holder_grill_strut_width();
		for(_strut = [1:duet_fan_holder_grill_strut_count()]) {
			_strut_outer_diameter = efan_inner_vent_diameter() + 2 * _strut * _ring_width;
			_strut_inner_diameter = _strut_outer_diameter - duet_fan_holder_grill_strut_width();
			difference() {
				cylinder(d = _strut_outer_diameter, h = _grill_height, $fn = duet_fan_holder_resolution());
				cylinder(d = _strut_inner_diameter, h = _grill_height, $fn = duet_fan_holder_resolution());
			}
		}

		// minus the radial struts
		for(_angle = [0:45:359]) {
			rotate([0, 0, _angle])
				translate([0, -duet_fan_holder_grill_strut_width() / 2, 0])
					cube([efan_outer_vent_diameter() / 2,
						  duet_fan_holder_grill_strut_width(), 
						  _grill_height]);
		}
	}		
}

/**
 * Creates the top cover including the screw and ventilation holes.
 */
module _duet_fan_holder_cover() {
	translate([0, 
			   0, 
			   duet_fan_holder_size_z() - duet_fan_holder_wall_thickness()]) {
		difference() {
			// the cover plate
			cube([duet_fan_holder_size_x(), 
				  duet_fan_holder_size_y(), 
				  duet_fan_holder_wall_thickness()]);

			// minus some fan-related stuff
			translate([duet_fan_holder_fan_offset_x(),
					   duet_fan_holder_fan_offset_y(),
					   -epsilon()]) {
				// minus the mounting screw holes - assuming that the fan is mounted centered in Y on the right (max X) wall
				_screw_length = duet_fan_holder_wall_thickness() + 2 * epsilon();
				translate([duet_fan_holder_fan_screw_center_offset(), duet_fan_holder_fan_screw_center_offset(), 0])
					cylinder(d = efan_screw_size(), h = _screw_length, $fn = duet_fan_holder_resolution());
				translate([-duet_fan_holder_fan_screw_center_offset(), duet_fan_holder_fan_screw_center_offset(), 0])
					cylinder(d = efan_screw_size(), h = _screw_length, $fn = duet_fan_holder_resolution());
				translate([duet_fan_holder_fan_screw_center_offset(), -duet_fan_holder_fan_screw_center_offset(), 0])
					cylinder(d = efan_screw_size(), h = _screw_length, $fn = duet_fan_holder_resolution());
				translate([-duet_fan_holder_fan_screw_center_offset(), -duet_fan_holder_fan_screw_center_offset(), 0])
					cylinder(d = efan_screw_size(), h = _screw_length, $fn = duet_fan_holder_resolution());

				// minus the fan grill (?) - the air intake slots
				_duet_fan_holder_fan_grill();
			}
		}
	}
}

/**
 * Creates one of the support pillars.
 */
module _duet_fan_holder_pillar(x = 0, y = 0) {
	translate([x - duet_fan_holder_pillar_width() / 2, 
			   y - duet_fan_holder_pillar_width() / 2, 
			   0]) 
		difference() {
			cube([duet_fan_holder_pillar_width(),
				  duet_fan_holder_pillar_width(),
				  duet_fan_holder_pillar_height()]);
			translate([duet_fan_holder_pillar_width()/2, 
					   duet_fan_holder_pillar_width()/2,
					   -epsilon()])
				cylinder(d = tap_base_diameter(efan_screw_size()),
						 h = duet_fan_holder_pillar_height() + 2 * epsilon(),
						 $fn = duet_fan_holder_resolution());
		}
}

/**
 * Creates the fan holder assembly by rendering it from scratch. This module is not to be called externally, use 
 * duet_fan_holder() instead.
 */
module _render_duet_fan_holder() {
	color_printed_psd_case()
		render() {
			union() {
				// the walls
				_duet_fan_holder_wall_top();
				_duet_fan_holder_wall_bottom();
				_duet_fan_holder_wall_left();
				_duet_fan_holder_wall_right();

				// the top cover including the screw and ventilation holes
				_duet_fan_holder_cover();

				// the pillars in the "left" (min X) corners
				_duet_fan_holder_pillar(duet_fan_holder_wall_thickness() + duet_fan_holder_pillar_width()/2, 
					                    duet_fan_holder_wall_thickness() + duet_fan_holder_pillar_width()/2);
				_duet_fan_holder_pillar(duet_fan_holder_wall_thickness() + duet_fan_holder_pillar_width()/2, 
					                    duet_fan_holder_size_y() - duet_fan_holder_wall_thickness() - duet_fan_holder_pillar_width()/2);

				// the pillars beneath the fan mounting holes
				translate([duet_fan_holder_fan_offset_x(),
						   duet_fan_holder_fan_offset_y(),
						   0]) {
					_duet_fan_holder_pillar(duet_fan_holder_fan_screw_center_offset(), 
											duet_fan_holder_fan_screw_center_offset());
					_duet_fan_holder_pillar(-duet_fan_holder_fan_screw_center_offset(), 
											duet_fan_holder_fan_screw_center_offset());
					_duet_fan_holder_pillar(duet_fan_holder_fan_screw_center_offset(), 
											-duet_fan_holder_fan_screw_center_offset());
					_duet_fan_holder_pillar(-duet_fan_holder_fan_screw_center_offset(), 
											-duet_fan_holder_fan_screw_center_offset());
				}
			}
		} 
}

/**
 * Main module to use the pre-rendered holder. 
 */
module duet_fan_holder() {
	bom_entry(section = "Printed Parts", description = "Electronics Mount", size = "Duet Fan Holder");
	color_printed_psd_case()
		import(file = "duet_fan_holder.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module duet_fan_holder_hardware(screw_material_thickness = 6) {

	// TODO complete hardware parts

	// // bottom horizontal strut
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() * 0.25, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_width() / 2, 
	// 		   0])
	// 	_duet_fan_holder_nut_screw(screw_material_thickness = screw_material_thickness);
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() * 0.75, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_width() / 2, 
	// 		   0])
	// 	_duet_fan_holder_nut_screw(screw_material_thickness = screw_material_thickness);

	// // top horizontal strut
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() * 0.25, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() - duet_fan_holder_strut_width() / 2, 
	// 		   0])
	// 	_duet_fan_holder_nut_screw(screw_material_thickness = screw_material_thickness);
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() * 0.75, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() - duet_fan_holder_strut_width() / 2, 
	// 		   0])
	// 	_duet_fan_holder_nut_screw(screw_material_thickness = screw_material_thickness);

	// // left vertical strut
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_width() / 2, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() * 0.25, 
	// 		   0])
	// 	_duet_fan_holder_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_width() / 2, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() * 0.75, 
	// 		   0])
	// 	_duet_fan_holder_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);

	// // right vertical strut
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() - duet_fan_holder_strut_width() / 2, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() * 0.25, 
	// 		   0])
	// 	_duet_fan_holder_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() - duet_fan_holder_strut_width() / 2, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() * 0.75, 
	// 		   0])
	// 	_duet_fan_holder_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);

	// // TODO add mounting screws for the PCB

}

/**
 * Renders a set of cylinders designed to "punch holes" in the surface the holder is mounted to.
 */
module duet_fan_holder_punch(hole_depth = 100) {

	// TODO complete punch

	// // bottom horizontal strut
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() * 0.25, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_width() / 2, 
	// 		   -( hole_depth - epsilon())])
	// 	cylinder(d = psd_base_mount_screw_size(), 
	// 	    	 h = hole_depth,
	// 		     $fn = psd_cover_resolution());
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() * 0.75, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_width() / 2, 
	// 		   -( hole_depth - epsilon())])
	// 	cylinder(d = psd_base_mount_screw_size(), 
	// 	    	 h = hole_depth,
	// 		     $fn = psd_cover_resolution());

	// // top horizontal strut
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() * 0.25, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() - duet_fan_holder_strut_width() / 2, 
	// 		   -( hole_depth - epsilon())])
	// 	cylinder(d = psd_base_mount_screw_size(), 
	// 	    	 h = hole_depth,
	// 		     $fn = psd_cover_resolution());
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() * 0.75, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() - duet_fan_holder_strut_width() / 2, 
	// 		   -( hole_depth - epsilon())])
	// 	cylinder(d = psd_base_mount_screw_size(), 
	// 	    	 h = hole_depth,
	// 		     $fn = psd_cover_resolution());

	// // left vertical strut
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_width() / 2, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() * 0.25, 
	// 		   -( hole_depth - epsilon())])
	// 	cylinder(d = psd_base_mount_screw_size(), 
	// 	    	 h = hole_depth,
	// 		     $fn = psd_cover_resolution());
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_width() / 2, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() * 0.75, 
	// 		   -( hole_depth - epsilon())])
	// 	cylinder(d = psd_base_mount_screw_size(), 
	// 	    	 h = hole_depth,
	// 		     $fn = psd_cover_resolution());

	// // right vertical strut
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() - duet_fan_holder_strut_width() / 2, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() * 0.25, 
	// 		   -( hole_depth - epsilon())])
	// 	cylinder(d = psd_base_mount_screw_size(), 
	// 	    	 h = hole_depth,
	// 		     $fn = psd_cover_resolution());
	// translate([duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_x() - duet_fan_holder_strut_width() / 2, 
	// 		   duet_fan_holder_strut_offset() + duet_fan_holder_strut_size_y() * 0.75, 
	// 		   -( hole_depth - epsilon())])
	// 	cylinder(d = psd_base_mount_screw_size(), 
	// 	    	 h = hole_depth,
	// 		     $fn = psd_cover_resolution());
}

_render_duet_fan_holder();
