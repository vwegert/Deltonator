/**********************************************************************************************************************
 **
 ** conf/part_sizes.scad
 **
 ** This file contains functions that provide fixed sizes of external standard parts. Normally, these values
 ** would have been kept with the individual parts, but that would result in a recursive dependency.
 **
 **********************************************************************************************************************/

// ----- parts/extrusions/vslot_2020.scad ------------------------------------------------------------------------------

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

// ----- parts/extrusions/makerslide.scad ------------------------------------------------------------------------------

// All dimensions were taken from the file makerslide_b17022_rev_2.pdf.

/**
 * Return the depth (X size) and width (Y size) of the base of the MakerSlide extrusion. These measurements exclude the 
 * rail extensions on the front side, i. e. only comprise the rectangular main body.
 */
function makerslide_base_depth() = 20;
function makerslide_base_width() = 40;

/**
 * Return the additional depth (X size) and width (Y size) introduced by the rail extensions. Note that the width
 * specified here comprises a single rail only.
 */
function makerslide_rail_depth() = 4.75/2;
function makerslide_rail_width() = 5.9358/2;

/**
 * Return the depth (X size) and width (Y size) of the MakerSlide extrusion. These measurements comprise the 
 * rail extensions on the front side.
 */
function makerslide_depth() = makerslide_base_depth() + makerslide_rail_depth();
function makerslide_width() = makerslide_base_width() + 2*makerslide_rail_width();

/**
 * The distance from the "back center" (the origin) of the MakerSlide vertical rails to the outer edges of the rail.
 * Measured value from the DXF drawings: 30.52933453 mm.
 * Calculated size: 32.065 mm
 * The difference is probably due to a rounded edge in the drawing.
 */
function makerslide_rail_edge_distance() = sqrt(pow(makerslide_width() / 2, 2) + pow(makerslide_depth(), 2));

/**
 * The edge radius of the back side and the resolution used to render the curve.
 */
function makerslide_edge_radius() = 1;
function makerslide_edge_resolution() = 64;

/**
 * Return the offset of the screw/nut slots from the back edges or the center.
 */
function makerslide_slot_offset() = 10;

