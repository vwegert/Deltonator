/**********************************************************************************************************************
 **
 ** parts/printed/duetx_holder.scad
 **
 ** This file constructs the holder for the DuetWifi extension board.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

use <duet_common.scad>

/**
 * Renders a hole with a nut recess for one of the base struts.
 */
module _duetx_holder_frame_nut_hole(head_rotation = 0) {
	cylinder(d = duet_holder_mount_screw_size(), 
		     h = duet_holder_strut_thickness() + epsilon(),
		     $fn = duet_holder_resolution());
	translate([0, 0, duet_holder_strut_thickness() + epsilon()])
		rotate([0, 90, head_rotation]) 
			nut_recess(duet_holder_mount_screw_size());
}

/**
 * Creates the horizontal strut of the frame.
 */
module _duetx_holder_frame_hstrut() {
	difference() {
		// the strut
		cube([duet_holder_strut_size_x(),
			  duet_holder_strut_width(),
			  duet_holder_strut_thickness()]);
		// minus the screw holes
		translate([duet_holder_strut_size_x() * 0.25,
			       duet_holder_strut_width() / 2,
			       0]) 
			_duetx_holder_frame_nut_hole();
		translate([duet_holder_strut_size_x() * 0.75,
			       duet_holder_strut_width() / 2,
			       0]) 
			_duetx_holder_frame_nut_hole();

	}
}

/**
 * Creates the vertical strut of the frame.
 */
module _duetx_holder_frame_vstrut() {
	difference() {
		// the strut
		cube([duet_holder_strut_width(),
			  duet_holder_strut_size_y(),
			  duet_holder_strut_thickness()]);
		// minus the screw holes
		translate([duet_holder_strut_width() / 2,
				   duet_holder_strut_size_y() * 0.25,
			       0]) 
			_duetx_holder_frame_nut_hole(head_rotation = 90);
		translate([duet_holder_strut_width() / 2,
				   duet_holder_strut_size_y() * 0.75,
			       0]) 
			_duetx_holder_frame_nut_hole(head_rotation = 90);
	}
}

/**
 * Creates a pillar to mount the Duet Wifi on.
 */
module _duetx_holder_pillar() {
	_hole_depth = duet_holder_size_z_inner() * 0.75;
	_hole_z_offset = duet_holder_size_z_inner() * 0.25;
	difference() {
		// the pillar
		cube([duet_holder_pillar_width(),
			  duet_holder_pillar_width(),
			  duet_holder_size_z_inner()]);
		// minus the screw hole
		translate([duet_holder_pillar_width() / 2,
				   duet_holder_pillar_width() / 2,
				   _hole_z_offset + epsilon()])
				cylinder(d = tap_base_diameter(size = duet_mount_size()), 
					     h = _hole_depth,
					     $fn = duet_holder_resolution());
	}
}

/**
 * Creates the frame that is mounted to the enclosure plate.
 */
module _duetx_holder_frame() {
	union() {		
		// the horizontal struts
		translate([duet_holder_strut_offset(), 
				   duet_holder_strut_offset(), 
				   0])
			_duetx_holder_frame_hstrut();
		translate([duet_holder_strut_offset(), 
				   duet_holder_size_y() - duet_holder_strut_width() - duet_holder_strut_offset(), 
				   0])
			_duetx_holder_frame_hstrut();
		// the vertical struts
		translate([duet_holder_strut_offset(), 
				   duet_holder_strut_offset(), 
				   0])
			_duetx_holder_frame_vstrut();
		translate([duet_holder_size_x() - duet_holder_strut_width() - duet_holder_strut_offset(), 
				   duet_holder_strut_offset(), 
				   0])
			_duetx_holder_frame_vstrut();
	}
}

/**
 * Creates the left wall (as mounted - min X) of the holder.
 */
module _duetx_holder_wall_left() {
	// the outer wall
	cube([duet_holder_wall_thickness(),
		  duet_holder_size_y(),
		  duet_holder_size_z_outer()]);
	// the inner wall that the PCB rests on
	translate([duet_holder_wall_thickness(),
			   0,
			   0])
		cube([duet_holder_wall_thickness(),
			  duet_holder_size_y(),
			  duet_holder_size_z_inner()]);
}

/**
 * Creates the right wall (as mounted - max X) of the holder.
 */
module _duetx_holder_wall_right() {
	translate([duet_pcb_mount_width() - duet_holder_wall_thickness(),
			   0,
			   0]) {

		// the inner wall that the PCB rests on
		cube([duet_holder_wall_thickness(),
			  duet_holder_size_y(),
			  duet_holder_size_z_inner()]);
		translate([duet_holder_wall_thickness(),
				   0,
				   0])
			cube([duet_holder_wall_thickness(),
				  duet_holder_size_y(),
				  duet_holder_size_z_outer()]);
	}
}

/**
 * Creates the bottom wall (as mounted - min Y) of the holder.
 */
module _duetx_holder_wall_bottom() {
	difference() {
		// the wall...
		union() {
			// ...consisting of the outer wall...
			cube([duet_holder_size_x(),
				  duet_holder_wall_thickness(),
				  duet_holder_size_z_outer()]);

			// ...and the inner wall that the PCB rests on...
			translate([0,
					   duet_holder_wall_thickness(),
					   0])
				cube([duet_holder_size_x(),
					  duet_holder_wall_thickness(),
					  duet_holder_size_z_inner()]);
		}
		// minus the vent hole
		_duet_holder_inner_vent_holes();
	}
}

/**
 * Creates the top wall (as mounted - max Y) of the holder.
 */
module _duetx_holder_wall_top() {
	translate([0,
			   duet_pcb_mount_height(),
			   0]) {
		difference() {
			// the wall...
			union() {
				// ...consisting of the inner wall that the PCB rests on...
				cube([duet_holder_size_x(),
					  duet_holder_wall_thickness(),
					  duet_holder_size_z_inner()]);
	
				// ...and the outer wall...
				translate([0,
						   duet_holder_wall_thickness(),
						   0])
					cube([duet_holder_size_x(),
						  duet_holder_wall_thickness(),
						  duet_holder_size_z_outer()]);
			}
			// minus the vent holes
			_duet_holder_outer_vent_holes();
		}
	}
}

/**
 * Creates the holder assembly by rendering it from scratch. This module is not to be called externally, use 
 * duet_holder() instead.
 */
module _render_duetx_holder() {
	color_printed_psd_case()
		render() {
			union() {
				// the base frame
				_duetx_holder_frame();

				// the walls
				_duetx_holder_wall_left();
				_duetx_holder_wall_right();
				_duetx_holder_wall_bottom();
				_duetx_holder_wall_top();

				// the support pillars
				translate([duet_holder_wall_thickness(),
						   duet_holder_wall_thickness(),
						   0])
					_duetx_holder_pillar();
				translate([duet_holder_wall_thickness() + duet_pcb_width()  + duet_holder_pcb_clearance() - duet_holder_pillar_width(),
						   duet_holder_wall_thickness(),
						   0])
					_duetx_holder_pillar();
				translate([duet_holder_wall_thickness(),
						   duet_holder_wall_thickness() + duet_pcb_height() + duet_holder_pcb_clearance() - duet_holder_pillar_width(),
						   0])
					_duetx_holder_pillar();
				translate([duet_holder_wall_thickness() + duet_pcb_width()  + duet_holder_pcb_clearance() - duet_holder_pillar_width(),
						   duet_holder_wall_thickness() + duet_pcb_height() + duet_holder_pcb_clearance() - duet_holder_pillar_width(),
						   0])
					_duetx_holder_pillar();
			}
		} 
}

/**
 * Main module to use the pre-rendered holder. 
 */
module duetx_holder() {
	bom_entry(section = "Printed Parts", description = "Electronics Mount", size = "DuetX Holder");
	color_printed_psd_case()
		import(file = "duetx_holder.stl");
}

/**
 * Renders a nut to be placed in the base struts.
 */
module _duetx_holder_nut_screw(head_rotation = 0, screw_material_thickness = 6) {
	translate([0, 0, duet_holder_strut_thickness()])
		rotate([0, 90, head_rotation])
			nut(size = duet_holder_mount_screw_size());
	translate([0, 0, -(screw_material_thickness + washer_thickness(size = duet_holder_mount_screw_size()))]) 
		rotate([0, -90, 0]) {
			screw(size = duet_holder_mount_screw_size(),
				  min_length = duet_holder_mount_screw_min_length());
			washer(size = duet_holder_mount_screw_size());
		}
} 

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module duetx_holder_hardware(screw_material_thickness = 6) {

	// bottom horizontal strut
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() * 0.25, 
			   duet_holder_strut_offset() + duet_holder_strut_width() / 2, 
			   0])
		_duetx_holder_nut_screw(screw_material_thickness = screw_material_thickness);
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() * 0.75, 
			   duet_holder_strut_offset() + duet_holder_strut_width() / 2, 
			   0])
		_duetx_holder_nut_screw(screw_material_thickness = screw_material_thickness);

	// top horizontal strut
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() * 0.25, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() - duet_holder_strut_width() / 2, 
			   0])
		_duetx_holder_nut_screw(screw_material_thickness = screw_material_thickness);
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() * 0.75, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() - duet_holder_strut_width() / 2, 
			   0])
		_duetx_holder_nut_screw(screw_material_thickness = screw_material_thickness);

	// left vertical strut
	translate([duet_holder_strut_offset() + duet_holder_strut_width() / 2, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() * 0.25, 
			   0])
		_duetx_holder_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);
	translate([duet_holder_strut_offset() + duet_holder_strut_width() / 2, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() * 0.75, 
			   0])
		_duetx_holder_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);

	// right vertical strut
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() - duet_holder_strut_width() / 2, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() * 0.25, 
			   0])
		_duetx_holder_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() - duet_holder_strut_width() / 2, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() * 0.75, 
			   0])
		_duetx_holder_nut_screw(head_rotation = 90, screw_material_thickness = screw_material_thickness);

	// TODO add mounting screws for the PCB

}

/**
 * Renders a set of cylinders designed to "punch holes" in the surface the holder is mounted to.
 */
module duetx_holder_punch(hole_depth = 100) {

	// bottom horizontal strut
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() * 0.25, 
			   duet_holder_strut_offset() + duet_holder_strut_width() / 2, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() * 0.75, 
			   duet_holder_strut_offset() + duet_holder_strut_width() / 2, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());

	// top horizontal strut
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() * 0.25, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() - duet_holder_strut_width() / 2, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() * 0.75, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() - duet_holder_strut_width() / 2, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());

	// left vertical strut
	translate([duet_holder_strut_offset() + duet_holder_strut_width() / 2, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() * 0.25, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());
	translate([duet_holder_strut_offset() + duet_holder_strut_width() / 2, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() * 0.75, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());

	// right vertical strut
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() - duet_holder_strut_width() / 2, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() * 0.25, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());
	translate([duet_holder_strut_offset() + duet_holder_strut_size_x() - duet_holder_strut_width() / 2, 
			   duet_holder_strut_offset() + duet_holder_strut_size_y() * 0.75, 
			   -( hole_depth - epsilon())])
		cylinder(d = psd_base_mount_screw_size(), 
		    	 h = hole_depth,
			     $fn = psd_cover_resolution());
}

_render_duetx_holder();
