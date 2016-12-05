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

use <../parts/extrusions/vslot_2020.scad>
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

	// the second bracket that attaches to the first one
	translate([rail_bracket_side_length() + epsilon(), 0, 0]) 
		rotate([0, 90, 0])
			rail_bracket();

	// the hardware to attach the bracket to the rail
	translate([rail_bracket_side_length() + rail_bracket_outer_wall_thickness(), 0, 0])
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

}

/** 
 * The module that actually renders the assembly. 
 * This module is not intended to be called outside of this file.
 */
module _horizontal_assembly(side = A, with_connectors = false) {
	if (foot_with_rail()) {
		// the bottom extrusion
		translate([vslot_2020_depth(), 0, 0])
			rotate([0, 0, 90])
				vslot_2020_side();
	}

	// the bed-level extrusion
	translate([vslot_2020_depth(), 0, bed_bracket_z_offset() + bed_bracket_height() - vslot_2020_width()])
		rotate([0, 0, 90])
			vslot_2020_side();

	// the mechanism to hold the bed
	translate([0, (horizontal_extrusion_length() - rail_bracket_width())/2, bed_bracket_z_offset() + bed_bracket_height() - vslot_2020_width() - epsilon()]) 
		_horizontal_assembly_bed_holder();

	// the top extrusion
	translate([vslot_2020_depth(), 0, vertical_extrusion_length() - vslot_2020_width()])
		rotate([0, 0, 90])
			vslot_2020_side();
}

// render the axis to a separate output file if requested
_horizontal_assembly(side = A, with_connectors = true);