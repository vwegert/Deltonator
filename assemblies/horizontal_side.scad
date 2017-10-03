/**********************************************************************************************************************
 **
 ** assemblies/horizontal_side.scad
 **
 ** This file renders and provides the horizontal parts on the sides with whatever is attached to it. 
 ** This assembly can be rendered into an STL file; however, for further construction of the model, that rendered
 ** version is NOT used because all the color information would be lost.
 **
 **********************************************************************************************************************/

include <../conf/colors.scad>
include <../conf/derived_sizes.scad>
include <../conf/part_sizes.scad>

use <../bom/bom.scad>

use <../assemblies/front_door.scad>

use <../parts/extrusions/vslot_2020.scad>
use <../parts/sheets/enclosure_long_side.scad>
use <../parts/printed/enclosure_side_bracket.scad>
use <../parts/vitamins/vitamins.scad>

/**
 * Provides access to the assembly.
 */
module horizontal_assembly(side = A, angle = 0, with_connectors = false) {
	rotate([0, 0, angle]) 
		translate([horizontal_distance_center_edge(), 0, 0])
			rotate([0, 0, 180])
				translate([-vslot_2020_depth() - horizontal_extrusion_outward_offset(), 
					       -horizontal_extrusion_length()/2, 
					       0]) {
					_horizontal_assembly(side = side, with_connectors = with_connectors);
					// TODO connectors	
				}
}

module _horizontal_assembly_bed_holder() {
	// the first bracket that attaches to the rail
	translate([rail_bracket_side_length(), rail_bracket_width(), 0]) 
		rotate([0, 90, 180])
			rail_bracket();

	// the hardware to attach the bracket to the rail
	translate(rail_bracket_hole_center())
		rotate([0, 270, 0]) {
			translate([-washer_thickness(M4) - 2* epsilon(), 0, 0])
				screw(size = M4, length = 8);
			translate([-washer_thickness(M4) - epsilon(), 0, 0])
				washer(size = M4);
			nut_tslot(M4);
		}

	// the second bracket that attaches to the first one, but shifted upwards as far as the holes allow
	translate([rail_bracket_side_length() + epsilon(), 0, bed_inner_bracket_offset()]) 
		rotate([0, 90, 0])
			rail_bracket();

	// the hardware to attach the bracket to the rail
	translate([rail_bracket_side_length() + rail_bracket_outer_wall_thickness(), 0, bed_inner_bracket_offset()])
		rotate([0, 90, 0])
			translate(rail_bracket_hole_outer(with_z = false))
				rotate([0, 90, 0]) {
					translate([-washer_thickness(M4) - 2* epsilon(), 0, 0])
						screw(size = M4, length = 10);
					translate([-washer_thickness(M4) - epsilon(), 0, 0])
						washer(size = M4);
					translate([2*rail_bracket_outer_wall_thickness() + epsilon(), 0, 0])
						washer(size = M4);
					translate([2*rail_bracket_outer_wall_thickness() + washer_thickness(M4) + 2*epsilon(), 0, 0])
						rotate([90, 0, 0])
							nut(size = M4);
				}

	translate([vslot_2020_width(), 0, bed_inner_bracket_offset()])
		translate(rail_bracket_hole_center(with_z = false)) {
			// the spring and washers on top of the inner bracket
			translate([0, 0, washer_thickness(M4) + epsilon()])
				rotate([0, 90, 0])
					washer(size = M4);
			translate([0, 0, washer_thickness(M4) + 2 * epsilon()])
				spring(inner_diameter = 5, length = bed_holder_spring_height());
			translate([0, 0, 2 * washer_thickness(M4) + bed_holder_spring_height() + 3 * epsilon()])
				rotate([0, 90, 0])
					washer(size = M4);
			// the washer and nut below the inner bracket
			translate([0, 0, -rail_bracket_outer_wall_thickness() - epsilon()])
				rotate([0, 90, 0])
					washer(size = M4);
			translate([0, 0, -rail_bracket_outer_wall_thickness() - washer_thickness(M4) - 2 * epsilon()])
				rotate([0, 90, 0])
					nut(size = M4);
		}

	// TODO add a part for a countersunk scres
	bom_entry(section = "General Hardware", 
		description = "Flat Head Countersunk Socket Cap Screw (DIN 7991 / ISO 10642)", 
		size = str("M4 x ", ceil(bed_screw_min_length()/5)*5, " mm"));

}

/** 
 * The module that actually renders the assembly. 
 * This module is not intended to be called outside of this file.
 */
module _horizontal_assembly(side = A, with_connectors = false) {
	// the top-level elements
	translate([vslot_2020_depth(), 0, vertical_extrusion_length() - vslot_2020_width()]) {
		// the horizontal extrusion
		rotate([0, 0, 90])
			vslot_2020_side();

		// the brackets on the A and B sides to hold the enclosure walls
		if ((side == A) || (side == B)) {
			translate([-vslot_2020_depth(), enclosure_bracket_total_width()/2 + enclosure_bracket_horizontal_offset(), 0]) 
				rotate([0, 0, 180]) {
					enclosure_side_bracket();
					enclosure_side_bracket_hardware();
				}
			translate([-vslot_2020_depth(), horizontal_extrusion_length() - (enclosure_bracket_total_width()/2 + enclosure_bracket_horizontal_offset()), 0]) 
				rotate([0, 0, 180]) {
					enclosure_side_bracket();
					enclosure_side_bracket_hardware();
				}
		}
	}

	// the bed-level elements
	translate([vslot_2020_depth(), 0, bed_bracket_z_offset() + bed_bracket_height() - vslot_2020_width()]) {
		// the horizontal extrusion
		rotate([0, 0, 90])
			vslot_2020_side();

		// the brackets on the A and B sides to hold the enclosure walls
		if ((side == A) || (side == B)) {
			translate([-vslot_2020_depth(), enclosure_bracket_total_width()/2 + enclosure_bracket_horizontal_offset(), 0]) 
				rotate([0, 0, 180]) {
					enclosure_side_bracket();
					enclosure_side_bracket_hardware();
				}
			translate([-vslot_2020_depth(), horizontal_extrusion_length() - (enclosure_bracket_total_width()/2 + enclosure_bracket_horizontal_offset()), 0]) 
				rotate([0, 0, 180]) {
					enclosure_side_bracket();
					enclosure_side_bracket_hardware();
				}
		}
	}

	// the mechanism to hold the bed
	translate([0, (horizontal_extrusion_length() - rail_bracket_width())/2, bed_bracket_z_offset() + bed_bracket_height() - vslot_2020_width() - epsilon()]) 
		_horizontal_assembly_bed_holder();

	// the foot-level elements
	if (foot_with_rail()) {
		// the bottom extrusion
		translate([vslot_2020_depth(), 0, 0])
			rotate([0, 0, 90])
				vslot_2020_side();

		// the brackets on the A and B sides to hold the enclosure walls
		if ((side == A) || (side == B)) {
			translate([0, enclosure_bracket_total_width()/2 + enclosure_bracket_horizontal_offset(), 0]) 
				rotate([0, 0, 180]) {
					enclosure_side_bracket();
					enclosure_side_bracket_hardware();
				}
			translate([0, horizontal_extrusion_length() - (enclosure_bracket_total_width()/2 + enclosure_bracket_horizontal_offset()), 0]) 
				rotate([0, 0, 180]) {
					enclosure_side_bracket();
					enclosure_side_bracket_hardware();
				}
		}
	}


	// the enclosure walls on the sides opposing the A and B rails, the front door on the side opposing the C rail
	translate([-enclosure_long_side_gap() - enclosure_insulation_thickness() - enclosure_solid_thickness() - epsilon(), horizontal_extrusion_length()/2, 0]) {
		if ((side == A) || (side == B)) {
			enclosure_long_side_plate();
			enclosure_long_side_plate_hardware();
		} else {
			front_door_assembly();
		}
	}

}

// render the axis to a separate output file if requested
_horizontal_assembly(side = A, with_connectors = true);