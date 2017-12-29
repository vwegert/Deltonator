/**********************************************************************************************************************
 **
 ** conf/part_sizes.scad
 **
 ** This file contains functions that provide fixed sizes of external standard parts. Normally, these values
 ** would have been kept with the individual parts, but that would result in a recursive dependency.
 **
 **********************************************************************************************************************/

include <constants.scad>

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

// ===== parts/vitamins/mechanic/rail_bracket.scad =====================================================================

/** 
 * The outer dimensions of the rail bracket.
 */
function rail_bracket_side_length() = 20;
function rail_bracket_width()       = 17;

/** 
 * The wall thickness of the rail bracket.
 */
function rail_bracket_outer_wall_thickness() = 3;
function rail_bracket_side_wall_thickness() = 2.25;

/** 
 * The dimensions and positions of the holes.
 */
function rail_bracket_hole_width() = 6;
function rail_bracket_hole_length() = 9;
function rail_bracket_hole_corner_offset() = 5.25;

/**
 * Some positions relative to the holes: innermost, center, outermost.
 */
function rail_bracket_hole_inner(with_z = true) = [
    rail_bracket_hole_corner_offset() + rail_bracket_hole_width()/2, 
    rail_bracket_width()/2,
    with_z ? -rail_bracket_outer_wall_thickness() : 0
  ];
function rail_bracket_hole_center(with_z = true) = [
    rail_bracket_hole_corner_offset() + rail_bracket_hole_length()/2, 
    rail_bracket_width()/2,
    with_z ? -rail_bracket_outer_wall_thickness() : 0
  ];
function rail_bracket_hole_outer(with_z = true) = [
    rail_bracket_hole_corner_offset() + rail_bracket_hole_length() - rail_bracket_hole_width()/2, 
    rail_bracket_width()/2,
    with_z ? -rail_bracket_outer_wall_thickness() : 0
  ];

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
function makerslide_edge_radius() = 0.5;
function makerslide_edge_resolution() = 64;

/**
 * Return the offset of the screw/nut slots from the back edges or the center.
 */
function makerslide_slot_offset() = 10;

// ===== SCREWS, NUTS, BOLTS AND OTHER HARDWARE =======================================================================

/**
 * Determines the next available screw length for a given size.
 */
function select_next_screw_length(size, min_length) =
	(size == M2) ?
		(min_length <= 10) ? 10 : -min_length
	: (size == M3) ?
		(min_length <=  6) ?  6 :
		(min_length <=  8) ?  8 :
		(min_length <= 10) ? 10 :
		(min_length <= 12) ? 12 :
		(min_length <= 16) ? 16 :
		(min_length <= 20) ? 20 : 
		(min_length <= 25) ? 25 : 
		(min_length <= 30) ? 30 : -min_length
	: (size == M4) ? 
		(min_length <=  8) ?  8 :
		(min_length <= 10) ? 10 :
		(min_length <= 12) ? 12 :
		(min_length <= 16) ? 16 :
		(min_length <= 20) ? 20 :
		(min_length <= 25) ? 25 :
		(min_length <= 35) ? 35 : 
		(min_length <= 45) ? 45 :
		(min_length <= 55) ? 55 : -min_length
	: (size == M5) ? 
		(min_length <=  8) ?  8 :
		(min_length <= 10) ? 10 :
		(min_length <= 12) ? 12 :
		(min_length <= 16) ? 16 :
		(min_length <= 20) ? 20 :
		(min_length <= 25) ? 25 :
		(min_length <= 30) ? 30 :
		(min_length <= 35) ? 35 :
		(min_length <= 40) ? 40 :
		(min_length <= 45) ? 45 :
		(min_length <= 55) ? 55 :
		(min_length <= 65) ? 65 : -min_length
	: (size == M8) ?
		(min_length <= 30) ? 30 : -min_length
	: -1000;

/**
 * The thickness of hex screw heads of various dimensions (ISO 4017).
 */
function hex_screw_head_thickness(size = M4) =
			(size == M2) ? 1.4 :
			(size == M3) ? 2.0 :
	        (size == M4) ? 2.8 :
	        (size == M5) ? 3.5 :
	        (size == M8) ? 5.3 : -1;	

/**
 * The thickness of washers of various dimensions (normal = ISO 7089, large = ISO 7093)
 */
function washer_thickness(size = M4) =
			(size == M3) ? 0.5 :
	        (size == M4) ? 0.8 :
	        (size == M5) ? 1.0 :
	        (size == M8) ? 1.6 : -1;	
function washer_thickness_large(size = M4) =
			(size == M3) ? 0.8 :
	        (size == M4) ? 1.0 :
	        (size == M5) ? 1.2 :
	        (size == M8) ? 2.0 : -1;	

/**
 * The diameter of washers of various dimensions (normal = ISO 7089, large = ISO 7093)
 */
function washer_diameter(size = M4) =
			(size == M3) ?  7 :
	        (size == M4) ?  9 :
	        (size == M5) ? 10 :
	        (size == M8) ? 16 : -1;	
function washer_diameter_large(size = M4) =
			(size == M3) ?  9 :
	        (size == M4) ? 12 :
	        (size == M5) ? 15 :
	        (size == M5) ? 24 : -1;	

/**
 * The thickness of nuts of various dimensions (ISO 4032).
 */
function nut_thickness(size = M4) =
			(size == M2) ? 1.6 :
			(size == M3) ? 2.4 :
	        (size == M4) ? 3.2 :
	        (size == M5) ? 4.7 :
	        (size == M8) ? 6.8 : -1;	

/**
 * The key width of nuts of various dimensions (ISO 4032).
 */
function nut_key_width(size = M4) =
			(size == M2) ?  4.0 :
			(size == M3) ?  5.5 :
	        (size == M4) ?  7.0 :
	        (size == M5) ?  8.0 :
	        (size == M8) ? 13.0 : -1;	

/**
 * The outer (subscribing) diameter of nuts of various dimensions.
 */
function nut_key_outer_diameter(size = M4) = (nut_key_width(size) / sqrt(3)) * 2;

/**
 * The length of a T-Slot nut along the slot, and an additional clearance to leave on each side. 
 * This is used to construct the supports that hold the nut in place.
 */
function t_slot_nut_length(size = M4) =
			(size == M4) ? 11.0 : -1;
function t_slot_nut_clearance() = 0.5;

/**
 * The width and depth of the support blocks that hold the T-Slot nuts.
 */
function t_slot_nut_holder_width() = 5.0;
function t_slot_nut_holder_depth() = 5.0;

/**
 * The diameter of a hole that is tapped with a metrical thread.
 */
function tap_base_diameter(size = M4) =
			(size == M2) ? 1.6 :
			(size == M3) ? 2.5 :
	        (size == M4) ? 3.3 :
	        (size == M5) ? 4.2 : 
	        (size == M8) ? 6.8 : -1;	

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
function gt2_pulley_base_depth() = 7.5;
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
 * The size of a F623ZZ ball bearing.
 */
function bearing_f623_bore_diameter() = 3;
function bearing_f623_outer_diameter() = 10;
function bearing_f623_flange_diameter() = 11.75;
function bearing_f623_width() = 4;

/** 
 * The dimensions of the eccentric spacer.
 */
function vwheel_spacer_hex_height()     = 6;
function vwheel_spacer_inset_height()   = 1.5; 
function vwheel_spacer_total_height()   = vwheel_spacer_hex_height() + vwheel_spacer_inset_height();
function vwheel_spacer_hex_size()       = 8; // the wrench size in mm
function vwheel_spacer_inset_diameter() = 6.9;
function vwheel_spacer_bore_diameter()  = 5;

/**
 * Some of the dimensions of a V-Wheel for the MakerSlide rails.
 */
function vwheel_width() = 7.5;
function vwheel_inner_bevel_width() = 1;
function vwheel_bearing_inset() = (vwheel_width() - vwheel_inner_bevel_width()) / 2;
function vwheel_assembly_thickness() = 2 * bearing_625_width() + 1; // the inner spacer is 1 mm thick
function vwheel_assembly_overhang() = (bearing_625_width() + 0.5) - (vwheel_width() / 2); 

/**
 * Some data to position the V-Wheels on the MakerSlide rails.
 * see http://store.amberspyglass.co.uk/v-wheel.html
 */
function vwheel_pair_center_distance() = 64.6;
function vwheel_depth_offset() = makerslide_base_depth();
function vwheel_width_offset() = vwheel_pair_center_distance() / 2;

function vwheel_max_mounting_hole_size() = 8; // TODO derive this from the excentrical nut size!

// ===== MAGNETS, BALLS, RODS ==========================================================================================

/**
 * The size of the steel balls used.
 */
function ball_diameter() = 10;

/** 
 * The dimensions of the magnet rings used.
 * see https://www.mtsmagnete.de/magnetsysteme/mit-bohrung-und-senkung/neodym-scheibenmagnet-mit-bohrung-und-senkung-10x5mm-3-4mm-bohrung-n40/a-3805/
 */
function magnet_outer_diameter() = 10;
function magnet_height() = 5;
function magnet_bore_diameter() = 3.4;
function magnet_bevel_diameter() = 7;
function magnet_bevel_angle() = 90;

/**
 * The dimensions of the rods that hold the effector.
 */
function rod_outer_diameter() = ROD_OUTER_DIAMETER;
function rod_inner_diameter() = ROD_INNER_DIAMETER;

// ===== SWITCHES =====================================================================================================

/**
 * The dimensions of the end switch used here. 
 * The values were taken from https://www.omron.com/ecb/products/sw/12/ss.html.
 */
function switch_ss5gl_thickness()            =  6.4;
function switch_ss5gl_width()                = 19.8;
function switch_ss5gl_body_height()          = 10.2;
function switch_ss5gl_hole_edge_distance()   =  5.15;
function switch_ss5gl_hole_bottom_distance() =  2.9;
function switch_ss5gl_hole_distance()        =  9.5;
function switch_ss5gl_hole_diameter()        =  2.35;

// ===== EXTRUDER NEMA 17 STEPPER MOTORS ==============================================================================

/**
 * The NEMA size of the motor.
 */
function emotor_size() = NEMA17;

/**
 * The outer dimensions of the motor (width and height) perpendicular to the axis. 
 * The depth is irrelevant (at the moment, at least).
 */
function emotor_width() = 42.2;
function emotor_height() = 42.2;

/**
 * The length of the shaft.
 */
function emotor_shaft_length() = 24;

/**
 * The distance between the screw holes on the front face of the motor.
 */
function emotor_screw_distance() = 31;

/** 
 * The size of the screw holes to hold the motor.
 */
function emotor_screw_size() = 3;

// ===== EXTRUDER MOUNT ===============================================================================================

/**
 * The material (plate) thickness of the mount.
 */
function extruder_mount_thickness() = 2; // TODO verify this value

/**
 * The width of the bracket (both sides).
 */
function extruder_mount_bracket_width() = 42;

/**
 * The length of the bracket sides.
 */
function extruder_mount_motor_length() = 50;
function extruder_mount_base_length() = 50;

/**
 * The size of the large holes in the side.
 */
function extruder_mount_hole_size() = 22;

/**
 * The size of the screw holes to mount the motor.
 */
function extruder_mount_motor_screw_hole_size() = 3.5;

/**
 * The size of the mounting holes in the base.
 */
function extruder_mount_base_screw_hole_size() = M4;

/**
 * The distance of the mounting holes from each other in the directions of the dimensions specified above.
 */
function extruder_mount_base_screw_dist_width() = 30;
function extruder_mount_base_screw_dist_length() = 24;

/**
 * The distance of the mounting holes from the sides of the bracket.
 */
function extruder_mount_base_screw_edge_dist_width() = (extruder_mount_bracket_width() - extruder_mount_base_screw_dist_width()) / 2;
function extruder_mount_base_screw_edge_dist_length() = 6; // TODO verify this value

// ===== ESCHER 3D MINI DIFFERENTIAL IR HEIGHT SENSOR =================================================================

/**
 * The size of the sensor PCB.
 */
function escher_ir_sensor_pcb_width() = 24;
function escher_ir_sensor_pcb_height() = 18;

/**
 * The relative position and size of the mounting holes.
 */
function escher_ir_sensor_hole_size() = M3;
function escher_ir_sensor_hole_offset_side() = 2.5;
function escher_ir_sensor_hole_offset_top() = 2.5;

/**
 * The sizes of the components (excluding the connector header) - or rather the clearance required to 
 * fit a case around the components.
 */
function escher_ir_sensor_pcb_thickness() = 1.0;
function escher_ir_sensor_pcb_max_pin_length() = 2.25;
function escher_ir_sensor_pcb_max_component_height() = 5.5;

/**
 * The width of the area on the left and right back side that can be used to rest the board on.
 */
function escher_ir_sensor_pcb_bottom_side_clearance() = 5.0; 

/**
 * The width and height of the area on the top of the component side that can be used to hold the board in place.
 */
function escher_ir_sensor_pcb_top_edge_clearance() = 5.0;

/**
 * The size of the small magnets used to hold the height sensor.
 */
function escher_ir_sensor_magnet_diameter() = 6.0;
function escher_ir_sensor_magnet_height() = 3.0;

/**
 * The recommended height of the IR sensor above the nozzle level.
 */
function escher_ir_sensor_nozzle_offset() = 1.5;

// ===== AXIAL FAN FOR PART COOLING ===================================================================================

/** 
 * The fan size.
 */
function pc_fan_side_length() = 25;
function pc_fan_inner_diameter() = 22;
function pc_fan_depth() = 10;
function pc_fan_corner_radius() = 2.0; 

/**
 * The size and position of the mounting holes.
 */
function pc_fan_hole_diameter() = 3.0; 
function pc_fan_hole_offset() = 2.5; 

// ===== E3D V6 LITE HOTEND ===========================================================================================

/** 
 * The size of the cutout required for the hotend in the effector plate.
 */
function hotend_e3d_v6lite_cutout_width() = 32.0;
function hotend_e3d_v6lite_cutout_depth_front() = 27.5;
function hotend_e3d_v6lite_cutout_depth_back() = 12.5;

/**
 * The horizontal distance between the nozzle and the middle of the mounting holes when using the standard bracket.
 */
function hotend_e3d_v6lite_mounting_hole_distance() = 25.0;

/** 
 * The size of the screw to use for mounting the hotend.
 */
function hotend_e3d_v6lite_mounting_hole_size() = M4;

/**
 * The height of the hotend from the underside of the mounting plate to the tip of the nozzle.
 */
function hotend_e3d_v6lite_overall_height() = 53.0; 

// ===== POWER SUPPLY =================================================================================================

/**
 * The outer dimensions of the power supply housing.
 */
function ps_length() = 215;
function ps_width()  = 114;
function ps_height() =  50;

/**
 * The distance between the mounting holes (assuming they are centered on the mounting side).
 */
function ps_screw_distance_length() = 150;
function ps_screw_distance_width()  =  50;

/**
 * The size and maximum depth of the mounting screws.
 */
function ps_screw_size()     = M4;
function ps_screw_min_depth() = 2.0;
function ps_screw_max_depth() = 5.0;

// ===== POWER CONNECTOR / SWITCH / FUSE ASSEMBLY =====================================================================

/**
 * The dimensions of the cutout and the screw holes for the power connector.
 */
function pcsfa_width()  = 28;
function pcsfa_height() = 48;
function pcsfa_screw_hole_diameter() = 2.5;
function pcsfa_screw_hole_distance() = 40;

// ===== DUET WIFI AND DUEXn PCB ======================================================================================

// We assume that Duet and DueXn have the same dimensions.
// see https://www.duet3d.com/wiki/Mounting_and_cooling_the_board

/**
 * The dimension of the DuetWifi PCB.
 */
function duet_pcb_width() = 123.0;
function duet_pcb_height() = 100.0;

/**
 * The size and distance of the mounting holes from the edge.
 */
function duet_mount_size() = M4;
function duet_mount_offset_width() = 4.0;
function duet_mount_offset_height() = 4.0;

// ===== MAIN ELECTRONICS COOLING FAN =================================================================================

/**
 * The size and height of the fan.
 */
function efan_width()  = 80.0;
function efan_height() = 25.0;

/**
 * The size of the ring used by the fan blades.
 */
function efan_outer_vent_diameter() = 77.0;
function efan_inner_vent_diameter() = 35.0;

/**
 * The size and position of the mounting holes.
 */
function efan_screw_size()   = M4;
function efan_screw_offset() = 3.5;

// ===== AUXILIARY FUNCTIONS ==========================================================================================

/**
 * A small value that can be added to or subtracted from edges to eliminate rendering artifacts.
 */
function epsilon() = 0.01;


