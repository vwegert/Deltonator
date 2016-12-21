/**********************************************************************************************************************
 **
 ** parts/vitamins/mechanic/extruder_mount.scad
 **
 ** This file renders the metal bracket used to mount a stepper motor and extruder.
 **
 **********************************************************************************************************************/

include <../../../conf/part_sizes.scad>

$fn = 96;

module motor_plate() {
	difference() {
	
		// the plate
		cube([extruder_mount_motor_length(),
		      extruder_mount_bracket_width(),
		      extruder_mount_thickness()]);
			  
		// minus the central hole
		translate([extruder_mount_motor_length() - emotor_height() / 2,
				   extruder_mount_bracket_width() / 2,
				   -1]) {
				   
			cylinder(d = extruder_mount_hole_size(), h = extruder_mount_thickness() + 2);
		
			// minus the screw holes to mount the motor
			translate([-emotor_screw_distance()/2, -emotor_screw_distance()/2, 0])
				cylinder(d = extruder_mount_motor_screw_hole_size(), h = extruder_mount_thickness() + 2);
			translate([-emotor_screw_distance()/2, emotor_screw_distance()/2, 0])
				cylinder(d = extruder_mount_motor_screw_hole_size(), h = extruder_mount_thickness() + 2);
			translate([emotor_screw_distance()/2, -emotor_screw_distance()/2, 0])
				cylinder(d = extruder_mount_motor_screw_hole_size(), h = extruder_mount_thickness() + 2);
			translate([emotor_screw_distance()/2, emotor_screw_distance()/2, 0])
				cylinder(d = extruder_mount_motor_screw_hole_size(), h = extruder_mount_thickness() + 2);
		
		}
	}
}

module base_plate() {
	difference() {
	
		// the plate
		cube([extruder_mount_base_length(),
		      extruder_mount_bracket_width(),
		      extruder_mount_thickness()]);
	
		// minus the central hole
		translate([extruder_mount_base_length() - extruder_mount_base_screw_edge_dist_length() - extruder_mount_hole_size() / 2,
				   extruder_mount_bracket_width() / 2,
				   -1]) 
			cylinder(d = extruder_mount_hole_size(), h = extruder_mount_thickness() + 2);
		
		// minus the screw holes in the base
		translate([extruder_mount_base_length() - extruder_mount_base_screw_edge_dist_length(), 
				   extruder_mount_base_screw_edge_dist_width(), 
				   -1])
			cylinder(d = extruder_mount_motor_screw_hole_size(), h = extruder_mount_thickness() + 2);
		translate([extruder_mount_base_length() - extruder_mount_base_screw_edge_dist_length(), 
				   extruder_mount_bracket_width() - extruder_mount_base_screw_edge_dist_width(), 
				   -1])
			cylinder(d = extruder_mount_motor_screw_hole_size(), h = extruder_mount_thickness() + 2);
		translate([extruder_mount_base_length() - extruder_mount_base_screw_edge_dist_length() - extruder_mount_base_screw_dist_length(), 
				   extruder_mount_base_screw_edge_dist_width(), 
				   -1])
			cylinder(d = extruder_mount_motor_screw_hole_size(), h = extruder_mount_thickness() + 2);
		translate([extruder_mount_base_length() - extruder_mount_base_screw_edge_dist_length() - extruder_mount_base_screw_dist_length(), 
				   extruder_mount_bracket_width() - extruder_mount_base_screw_edge_dist_width(), 
				   -1])
			cylinder(d = extruder_mount_motor_screw_hole_size(), h = extruder_mount_thickness() + 2);
		
	}
}

union() {
	base_plate();
	translate([extruder_mount_thickness(), 0, 0])
		rotate([0, -90, 0])
			motor_plate();
}