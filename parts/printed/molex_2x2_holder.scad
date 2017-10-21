/**********************************************************************************************************************
 **
 ** parts/printed/molex_2x2_holder.scad
 **
 ** This file constructs a holder for a 2x2 molex connector.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>
use <../../parts/vitamins/vitamins.scad>

// Not sure if this part is going to stay, hence the dimensions are only in here...

_mh_bottom_length     = 40;
_mh_bottom_width      = 15;
_mh_bottom_screw_size = M4;
_mh_bottom_height     = ceil(nut_thickness(_mh_bottom_screw_size) * 1.5);

_mh_tab_width     = 25;
_mh_tab_height    = 20;
_mh_tab_thickness = 2;

_mh_screw_x_offset = (_mh_bottom_length - _mh_tab_width) / 4;

_mh_tab_x_offset = (_mh_bottom_length - _mh_tab_width) / 2;
_mh_tab_y_offset = (_mh_bottom_width - _mh_tab_thickness) / 2;

_mh_resolution = 48;

module _molex_2x2_holder_bottom() {
	difference() {
		cube([_mh_bottom_length,
			  _mh_bottom_width,
			  _mh_bottom_height]);
		translate([_mh_screw_x_offset,
				   _mh_bottom_width / 2,
				   0])
			cylinder(d = tap_base_diameter(_mh_bottom_screw_size), 
				     h = _mh_bottom_height + epsilon(),
				     $fn = _mh_resolution);
		translate([_mh_bottom_length - _mh_screw_x_offset,
				   _mh_bottom_width / 2,
				   0])
			cylinder(d = tap_base_diameter(_mh_bottom_screw_size), 
				     h = _mh_bottom_height + epsilon(),
				     $fn = _mh_resolution);
	}
}

module _molex_2x2_holder_tab() {
	difference() {
		cube([_mh_tab_width,
			  _mh_tab_thickness,
			  _mh_tab_height]);
		translate([5, 0, 5])
			cube([15, _mh_tab_thickness, 10]);
		translate([10.5, 0, 15])
			cube([4, _mh_tab_thickness, 1]);
	}
}


/**
 * Creates the holder by rendering it from scratch. This module is not to be called externally, use 
 * molex_2x2_holder() instead.
 */
module _render_molex_2x2_holder() {
	color_printed_psd_case()
		render() {
			union() {
				_molex_2x2_holder_bottom();
				translate([_mh_tab_x_offset,
						   _mh_tab_y_offset,
						   _mh_bottom_height])
					_molex_2x2_holder_tab();
			}
		} 
}

/**
 * Main module to use the pre-rendered holder. 
 */
module molex_2x2_holder() {
	bom_entry(section = "Printed Parts", description = "Power Supply and Distribution", size = "Molex 2x2 Holder");
	color_printed_psd_case()
		translate(pd_cover_offset())
			import(file = "molex_2x2_holder.stl");
}

/** 
 * Renders the hardware (nuts, bolts, screws) that are used to fixed the printed part to the surrounding parts.
 */
module molex_2x2_holder_hardware() {
	// translate(pd_cover_offset())
	// 	translate([0,
	// 			   0,
	// 			   pd_cover_outer_height() + washer_thickness(size = psd_base_mount_screw_size())]) {
	// 		_screw_offsets = pd_cover_screw_offset();
	// 		for (i = [0:3])
	// 			translate(_screw_offsets[i]) {
	// 				rotate([0, 90, 0])
 // 					screw(size = psd_base_mount_screw_size(),				
	// 	 				  min_length = pd_cover_screw_min_length(),
	// 	 				  max_length = pd_cover_screw_max_length());
	// 				rotate([0, 90, 0])
	// 	 			washer(size = psd_base_mount_screw_size());
	// 		}
	// 	}
}

_render_molex_2x2_holder();

