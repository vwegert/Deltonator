/**********************************************************************************************************************
 **
 ** conf/derived_sizes.scad
 **
 ** This file contains functions that calculate various dimensions of the printer. Note that sizes that are only 
 ** relevant for specific parts are calculated in the corresponding part files directly.
 **
 **********************************************************************************************************************/

include <printer_config.scad>
use <part_sizes.scad>

// ===== PRINTER FRAME SIZES ===========================================================================================

/**
 * The length of the vertical MakerSlide extrusions.
 */
function vertical_extrusion_length() = FRAME_V_RAIL_HEIGHT;

/**
 * The length of the horizontal 20x20 V-Slot extrusions.
 */
function horizontal_extrusion_length() = FRAME_H_RAIL_LENGTH;

/**
 * The offset of the horizontal V-Slot extrusions from the logical crossing point of the sides of the center triangle
 * (that is, from the center of the outer side of the MakerSlide rail).
 */
function horizontal_extrusion_offset() = makerslide_rail_edge_distance() + horizontal_vertical_extrusion_gap();

/**
 * The overall size of the base triangle - from one crossing point to the next.
 */
function horizontal_base_length() = horizontal_extrusion_length() + 2 * horizontal_extrusion_offset();

// ===== FABRICATED PART DIMENSIONS ===================================================================================

/**
 * The thickness of the wall that separates the vertical rails from the horizontal extrusions.
 */
function horizontal_vertical_extrusion_gap() = FRAME_V_H_RAIL_SEPARATION;

// ===== PART PLACEMENT ================================================================================================

/**
 * The offset of the front plane from the X origin into positive X. This offset is applied to the back center of the
 * vertical rails, thus marking the front side of the construction triangle between the origins of the vertical rails.
 */
function front_plane_offset() = sqrt(pow(horizontal_base_length(), 2) - pow(horizontal_base_length() / 2, 2));

/**
 * The positions of the vertical rails. A is the "front left" rail, B the "front right" rail, C the back rail.
 */
function position_rail_a() = [front_plane_offset(), -horizontal_base_length() / 2, 0];
function position_rail_b() = [front_plane_offset(),  horizontal_base_length() / 2, 0];
function position_rail_c() = [0, 0, 0];

/**
 * Each of the horizontal extrusion sets is placed outside of the construction triangle. This function specifies the
 * distance by which the rails are offset.
 */
function vertical_extrusion_outward_offset() = (makerslide_base_width()/2 * sin(60)) - (vslot_2020_width()/2);

/**
 * The positions of the horizontal side assemblies. Be aware that - in contrast to the positioning of the vertical 
 * rails - the translation is applied BEFORE the rotation since that makes the calculation much easier to understand.
 */
function position_front_assembly() = [front_plane_offset() + vertical_extrusion_outward_offset(), 
                                      -horizontal_extrusion_length()/2, 0];
function position_left_assembly() = [-vertical_extrusion_outward_offset() - vslot_2020_depth(),
                                     -horizontal_extrusion_length() - horizontal_extrusion_offset(), 0];



function position_right_assembly() = [-vertical_extrusion_outward_offset() - vslot_2020_depth(),
                                      horizontal_extrusion_offset(), 0];
