/**********************************************************************************************************************
 **
 ** parts/extrusions/vslot_2020.scad
 **
 ** This file ontains some general functions that provide the dimensions of the profile as well as the modules used 
 ** to import the rendered rails. 
 ** This file is intended to be included by other files down the line.
 **
 **********************************************************************************************************************/

use <../../conf/colors.scad>
use <../../conf/derived_sizes.scad>

// ----- DIMENSIONS ----------------------------------------------------------------------------------------------------

// The dimensions were taken from the file vslot_2020_dimensions.jpg.

/**
 * Return the depth (X size) and width (Y size) of the V-Slot extrusion.
 */
function vslot_2020_depth() = 20;
function vslot_2020_width() = 20;

/**
 * The edge radius of the back side and the resolution used to render the curve.
 */
function vslot_2020_edge_radius() = 1.5;
function vslot_2020_edge_resolution() = 64;

/**
 * Return the offset of the screw/nut slots from the back edges or the center.
 */
function vslot_2020_slot_offset() = 10;

// ----- EXTRUSIONS ----------------------------------------------------------------------------------------------------

/**
 * Provides the pre-rendered horizontal side piece.
 * The extrusion will lie horizontally along the positive X axis and will extend into positve Y and Z.
 */
module vslot_2020_side() {
	color_extrusion()
		import(file = "vslot_2020_side.stl"); 
}

// ----- PUNCH ---------------------------------------------------------------------------------------------------------

/**
 * Create an object that resembles the outer shell of a V-Slot 20x20 mm  extrusion. Usage is similar
 * to vslot_extrusion(length). This is handy to punch a hole into a printed part that will later
 * accomodate the V-Slot 20x20 mm  extrusion.
 */
module vslot_2020_punch(length) {
	color_punch()
		linear_extrude(height = length, center = false, convexity = 10)
			hull($fn = vslot_2020_edge_resolution()) {
				translate([vslot_2020_edge_radius(), vslot_2020_edge_radius(), 0])
					circle(r = vslot_2020_edge_radius());
				translate([vslot_2020_depth() - vslot_2020_edge_radius(), vslot_2020_edge_radius(), 0])
					circle(r = vslot_2020_edge_radius());
				translate([vslot_2020_edge_radius(), 18.5, 0])
					circle(r = vslot_2020_edge_radius());
				translate([vslot_2020_depth() - vslot_2020_edge_radius(), vslot_2020_width() - vslot_2020_edge_radius(), 0])
					circle(r = vslot_2020_edge_radius());
			}
}
