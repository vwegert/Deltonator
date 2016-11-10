/**********************************************************************************************************************
 **
 ** conf/part_sizes.scad
 **
 ** This file contains functions that provide fixed sizes of external standard parts. Normally, these values
 ** would have been kept with the individual parts, but that would result in a recursive dependency.
 **
 **********************************************************************************************************************/

// ===== parts/extrusions/vslot_2020.scad ==============================================================================

// The dimensions were taken from the file vslot_2020_dimensions.jpg.

/**
 * Return the depth (X size) and width (Y size) of the V=Slot extrusion.
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

// ===== parts/extrusions/makerslide.scad ==============================================================================

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

// ===== VERTICAL AXIS NEMA 17 STEPPER MOTORS ==========================================================================

/**
 * The NEMA size of the motor.
 */
function vmotor_size() = 17;

/**
 * The outer dimensions of the motor (width and height) perpendicular to the axis. 
 * The depth is irrelevant (at the moment, at least).
 */
function vmotor_width() = 42.2;
function vmotor_height() = 42.2;

/**
 * The length of the shaft.
 */
function vmotor_shaft_length() = 24;

/**
 * The diameter of the round hole to leave for placing the motor
 */
function vmotor_mounting_hole_diameter() = 25; // NEMA drawings say 22, better leave some clearance here
function vmotor_mounting_hole_resolution() = 32;

/**
 * The distance between the screw holes on the front face of the motor.
 */
function vmotor_screw_distance() = 31;

/** 
 * The size of the screw holes to hold the motor.
 */
function vmotor_screw_size() = 3;

// ===== GT2 TIMING BELTS AND ASSOCIATED HARDWARE =====================================================================

/**
 * The dimensions of a GT2 belt.
 */
function gt2_belt_width() = 6;
function gt2_belt_thickness_max() = 1.38; 
function gt2_belt_groove_depth()  = 0.75;
function gt2_belt_thickness_min() = gt2_belt_thickness_max() - gt2_belt_groove_depth();

/**
 * The diameter and overall depth of the GT2 pulley.
 */
function gt2_pulley_diameter() = 16;
function gt2_pulley_depth() = 16;
function gt2_pulley_inner_diameter_max() = 12.22;
function gt2_pulley_inner_diameter_min() = gt2_pulley_inner_diameter_max() - gt2_belt_groove_depth();

// ===== WHEELS AND BEARINGS ==========================================================================================

/**
 * The size of a 625 ball bearing.
 */
function bearing_625_bore_diameter() = 5;
function bearing_625_outer_diameter() = 16;
function bearing_625_width() = 5;

/**
 * Some of the dimensions of a V-Wheel for the MakerSlide rails.
 */
function vwheel_width() = 7.5;
function vwheel_inner_bevel_width() = 1;
function vwheel_bearing_inset() = (vwheel_width() - vwheel_inner_bevel_width()) / 2;

/**
 * Some data to position the V-Wheels on the MakerSlide rails.
 * see http://store.amberspyglass.co.uk/v-wheel.html
 */
function vwheel_pair_center_distance() = 64.6;
function vwheel_depth_offset() = makerslide_base_depth();
function vwheel_width_offset() = vwheel_pair_center_distance() / 2;
