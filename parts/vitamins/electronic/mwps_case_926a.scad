/**********************************************************************************************************************
 **
 ** parts/vitamins/electronic/mwps_case_926a.scad
 **
 ** This file renders a power supply case designated as "Case No. 926A" in the MeanWell data sheets.
 **
 **********************************************************************************************************************/

include <../../../conf/part_sizes.scad>

$fn = 48;

// Convention: the "front" side is the one aligned to the Y axis (front if primary is left, secondary right).

module _mwps_screw_hole(front = true) {
	translate([0, front ? -epsilon() : mwps_width() + epsilon(), 0])
		rotate([front ? -90 : 90, 0, 0])
			cylinder(d = mpws_screw_diameter(), h = mpws_screw_depth() + epsilon());
}

module _mwps_case_926a() {
	union() {
	
		color("LightGray")
			difference() {
				// the basic shape of the case
				cube([mwps_length(), mwps_width(), mwps_height()]);
		
				// minus the screw holes
				translate([mpws_pri_screw_offset(), 0, mpws_lower_screw_height()]) {
					_mwps_screw_hole(front = false);
					_mwps_screw_hole(front = true);
				}
				translate([mpws_pri_screw_offset(), 0, mpws_upper_screw_height()]) {
					_mwps_screw_hole(front = false);
					_mwps_screw_hole(front = true);
				}
				translate([mwps_length() - mpws_sec_screw_offset(), 0, mpws_lower_screw_height()]) {
					_mwps_screw_hole(front = false);
					_mwps_screw_hole(front = true);
				}
				translate([mwps_length() - mpws_sec_screw_offset(), 0, mpws_upper_screw_height()]) {
					_mwps_screw_hole(front = false);
					_mwps_screw_hole(front = true);
				}
			}
		
		color("Black") {
			// plus the primary terminal block placeholder
			translate([-mwps_pri_term_length(), mwps_pri_term_offset_y(), mwps_pri_term_offset_z()])
				cube([mwps_pri_term_length(), mwps_pri_term_width(), mwps_pri_term_height()]);
		
			// plus the secondary terminal block placeholder
			translate([mwps_length(), mwps_sec_term_offset_y(), mwps_sec_term_offset_z()])
				cube([mwps_sec_term_length(), mwps_sec_term_width(), mwps_sec_term_height()]);
		}
	}
}

_mwps_case_926a();