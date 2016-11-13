/**********************************************************************************************************************
 **
 ** parts/extrusions/makerslide.scad
 **
 ** This file ontains some general functions that provide the dimensions of the profile as well as the modules used 
 ** to import the rendered rails. 
 ** This file is intended to be included by other files down the line.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>

/**
 * Provides the pre-rendered main vertical rail.
 * The extrusion will reach into positive X and Z space while being centered on the Y axis.
 */
module makerslide_vertical_rail() {
	bom_entry(section = "Aluminium Extrusions", description = "MakerSlide Extrusion", size = str(vertical_extrusion_length(), " mm"));
	color_extrusion()
		import(file = "makerslide_rail.stl"); 
}

/**
 * Create an object that resembles the outer shell of a MakerSlide extrusion. Usage is similar
 * to makerslide_vertical_rail(length). This is handy to punch a hole into a printed part that will later
 * accomodate the MakerSlide extrusion.
 */
module makerslide_punch(length) {
	color_punch()
		linear_extrude(height = length, center = false, convexity = 10)
			union() {
				hull() {
					// use two circles for the back sides
					_y_offset = makerslide_base_width()/2 - makerslide_edge_radius();
					translate([makerslide_edge_radius(), -_y_offset, 0])
						circle(r = makerslide_edge_radius(), $fn = makerslide_edge_resolution());
					translate([makerslide_edge_radius(), _y_offset, 0])
						circle(r = makerslide_edge_radius(), $fn = makerslide_edge_resolution());
					// use a rectangle to shape the front side
					translate([makerslide_base_depth() - 1, -makerslide_base_width()/2, 0])
						square([1, makerslide_base_width()]);
				}
				_rail_base_x = makerslide_base_depth() - makerslide_edge_radius() - makerslide_rail_depth();
				_rail_offset_y = makerslide_base_width()/2;
				_rail_punch_width = makerslide_rail_width();
				_rail_punch_depth = 2*makerslide_rail_depth() + makerslide_edge_radius();
				translate([_rail_base_x, -_rail_offset_y - _rail_punch_width, 0])
					square([_rail_punch_depth, _rail_punch_width]);
				translate([_rail_base_x, _rail_offset_y, 0])
					square([_rail_punch_depth, _rail_punch_width]);

				// previous version:
				// // use the profile itself as the basic shape
				// import(file = "makerslide.dxf"); 
				// // add a rectangle to fill the holes on the left/right (small) sides 
				// // as well as most of the inside of the profile
				// translate([2, -20, 0])
				// 	square([18, 40]);
				// // add a second rectangle to fill the gaps on the back (we want to keep the rounded edges)
				// translate([0, -18, 0])
				// 	square([2, 36]);
				
			}
}
