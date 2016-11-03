/**********************************************************************************************************************
 **
 ** parts/extrusions/vslot_2020_side.scad
 **
 ** This file is used to render the actual rail into an STL file for faster access. 
 ** This file is NOT intended to be included by any other file.
 **
 **********************************************************************************************************************/

use <../../conf/derived_sizes.scad>
use <vslot_2020.scad>

// pre-render the side V-Slot extrusion into an STL file for later use
translate([0, 0, vslot_2020_depth()]) {
	 rotate([0, 90, 0]) 
		linear_extrude(height = horizontal_extrusion_length(), center = false, convexity = 10)
	 		difference() {
	 			// the original profile
	 			translate([-16.5, -12.575, 0])
					import(file = "vslot_2020_fullscale.dxf", layer = 0); 
				// cut away the circular left-over piece from the dimensioning 
			 	translate([0, -10, 0])
			 		square([20, 10]);
			}
}
		

