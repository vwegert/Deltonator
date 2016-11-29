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

// ===== ALIAS CONSTANTS TO ADDRESS THE AXES ===========================================================================

// A is the "front left" rail, B the "front right" rail, C the back rail.
A = 0;
B = 1;
C = 2;

// ===== PRINTER FRAME SIZES ===========================================================================================

/**
 * The angles of the vertical rails. A is the "front left" rail, B the "front right" rail, C the back rail.
 * These angles are also used for the sides; in this case, side A is the one opposing rail A.
 */
function angle_rail(side = A) = 
  (side == A) ? 120 :
  (side == B) ? 240 :
  0;

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

/**
 * The distance from one corner of the printer to the center of the opposing side. (The height of the triangle.)
 */
function horizontal_base_height() = sqrt(pow(horizontal_base_length(), 2) - pow(horizontal_base_length() / 2, 2));

/**
 * The distance from the center of the printer to one of the corners / edges.
 */
function horizontal_distance_center_edge() = tan(30) * horizontal_base_length()/2;
function horizontal_distance_center_corner() = horizontal_base_height() - horizontal_distance_center_edge();

/**
 * The additional clearance to leave around the MakerSlide extrusion.
 */
function makerslide_clearance() = MAKERSLIDE_CLEARANCE;

/**
 * The distance between the rods that hold the effector.
 */
function rod_distance() = ROD_DISTANCE;

// ===== DERIVED PART-DEPENDENT SIZES AND DISTANCES ====================================================================

/** 
 * More dimensions of the magnet rings used.
 */
function magnet_bevel_depth() = sin(magnet_bevel_angle()/2) * (magnet_bevel_diameter() - magnet_bore_diameter());

/**
 * The diameter of the circle on the stell ball that will touch the magnet ring.
 */
function ball_contact_circle_diameter() = sqrt( 2 * pow(ball_diameter()/2, 2));

/**
 * The distance of the contact circle plane from the center of the ball.
 */
function ball_contact_circle_height() = sqrt(pow(ball_diameter()/2, 2) - pow(ball_contact_circle_diameter()/2, 2));

/**
 * The distance of the contact circle from the ball-ward flat side of the magnet.
 */
function magnet_contact_circle_depth() = 
  abs(tan(magnet_bevel_angle()/2) * (magnet_bevel_diameter() - ball_contact_circle_diameter())/2);

/**
 * The distance of the base point of the magnet from the center of the steel ball.
 */
function ball_center_magnet_base_distance() =
  ball_contact_circle_height() - magnet_contact_circle_depth() + magnet_height();

// ===== FABRICATED PART DIMENSIONS ===================================================================================

// ----- general frame parts ------------------------------------------------------------------------------------------

/**
 * The thickness of the wall that separates the vertical rails from the horizontal extrusions.
 */
function horizontal_vertical_extrusion_gap() = FRAME_V_H_RAIL_SEPARATION;

/**
 * The overall thickness of the walls adjacent to the metal extrusions.
 */
function frame_wall_thickness() = FRAME_PART_WALL_THICKNESS;

/**
 * The depth of the holes that hold the V-Slot extrusions.
 */
function horizontal_recess_depth() = FRAME_PART_VSLOT_DEPTH;

/**
 * The distance from the outer perimeter of the screw holes that hold the V-Slot extrusions.
 */
function horizontal_screw_distance() = FRAME_PART_VSLOT_DEPTH/2;

// ----- foot ---------------------------------------------------------------------------------------------------------

/**
 * The depth of the holes that hold the V-Slot extrusions.
 */
function foot_makerslide_recess_depth() = FRAME_FOOT_MAKERSLIDE_DEPTH; 

// ----- motor bracket ------------------------------------------------------------------------------------------------

/**
 * The height of the bracket that holds the motor (only of the part that holds the rail).
 */
function motor_bracket_height() = FRAME_MOTOR_BRACKET_HEIGHT;

/**
 * The radius and resolution of the rounded edges of the motor bracket.
 */
function motor_bracket_edge_radius() = 5;
function motor_bracket_edge_resolution() = 16;

/**
 * The height at which the bracket is mounted. At the moment, it is placed directly above the lower foot.
 * see also: lower_foot_vertical_height() 
 */
function motor_bracket_z_offset() = foot_makerslide_recess_depth();

// ----- build surface holder -----------------------------------------------------------------------------------------

function bed_bracket_height() = FRAME_BED_BRACKET_HEIGHT;

/**
 * The position of the bed bracket on the vertical rail.
 */
function bed_bracket_z_offset() = motor_bracket_z_offset() + motor_bracket_height();

/**
 * The upper edge of the bed bracket.
 */
function bed_bracket_top_level() = bed_bracket_z_offset() + bed_bracket_height();

/**
 * The height of the upper edge of the working surface.
 */
function bed_working_height() = bed_bracket_top_level() + frame_wall_thickness(); // TODO factor in bed height!

// ----- head ---------------------------------------------------------------------------------------------------------

/**
 * The depth of the holes that hold the V-Slot extrusions.
 */
function head_makerslide_recess_depth() = FRAME_HEAD_MAKERSLIDE_DEPTH; 

/**
 * The width and depth of the guides in the head piece that hold the tensioner and the end switch bracket in place.
 */
function head_guide_width() = 2;
function head_guide_depth() = 6;

/**
 * The clearance between the tensioner / bracket and its guide blocks on either side.
 */
function head_guide_clearance() = 0.2;

/**
 * The position of the head piece on the vertical rail.
 */
function head_z_offset() = vertical_extrusion_length() - head_makerslide_recess_depth();

// ----- carriage -----------------------------------------------------------------------------------------------------

/**
 * The thickness of the carriage base plate.
 */
function carriage_plate_thickness() = CARRIAGE_PLATE_THICKNESS;

/** 
 * The width of the border around the holes in the carriage base plate that hold the V-Wheels. 
 */
function carriage_plate_border_width() = CARRIAGE_PLATE_BORDER_WIDTH; 

/** 
 * The horizontal and vertical distance of the center points of the carriage wheels.
 */
function carriage_wheel_distance_x() = vwheel_pair_center_distance(); // FIXED otherwise it won't fit the rail!
function carriage_wheel_distance_y() = vwheel_pair_center_distance();

/**
 * The outer dimensions of the carriage base plate.
 */
function carriage_plate_width()  = ceil(
    carriage_wheel_distance_x() +
    vwheel_max_mounting_hole_size() +
    2 * carriage_plate_border_width()
  );
function carriage_plate_height() = ceil(
    carriage_wheel_distance_y() +
    vwheel_max_mounting_hole_size() +
    2 * carriage_plate_border_width()
  );

/**
 * The outer corner radius and resolution of the carriage base plate.
 */
function carriage_plate_edge_radius() = 4;
function carriage_plate_edge_resolution() = 16;

/**
 * The positions of the holes that the V-Wheels will be mounted on.
 * Wheel 1 is the top left wheel, 2 is the bottom left one, 3 is the adjustable wheel on the right-hand side.
 */
function carriage_wheel1_y() = -vwheel_pair_center_distance()/2;
function carriage_wheel1_z() = carriage_plate_height() - 
                                (vwheel_max_mounting_hole_size()/2 + carriage_plate_border_width());
function carriage_wheel2_y() = -vwheel_pair_center_distance()/2;
function carriage_wheel2_z() = vwheel_max_mounting_hole_size()/2 + carriage_plate_border_width();
function carriage_wheel3_y() = vwheel_pair_center_distance()/2;
function carriage_wheel3_z() = carriage_plate_height() / 2;

/**
 * The sizes of the mounting holes: fixed wheels on the left-hand size, adjustable on the right-hand sizde.
 */
function carriage_wheel1_hole_diameter() = bearing_625_bore_diameter();
function carriage_wheel2_hole_diameter() = bearing_625_bore_diameter();
function carriage_wheel3_hole_diameter() = 8; // TODO adjust to the excenter size
function carriage_wheel_hole_resolution() = 16;

/** 
 * The dimensions of the set of blocks on the carriage that hold the belt.
 */
function carriage_belt_holder_depth() = 7.0; // gt2_belt_width() + 1
function carriage_belt_holder_height() = 25;
function carriage_belt_holder_width() = 35;
function carriage_belt_holder_center_offset() = 5;
function carriage_belt_holder_outer_width() = 6;
function carriage_belt_holder_channel_height() = 15;
function carriage_belt_holder_channel_width() = 2.5;
function carriage_belt_holder_path_width() = 1.75;
function carriage_belt_holder_center_height() = 10;
function carriage_belt_holder_edge_radius() = 2;
function carriage_belt_holder_small_edge_radius() = 0.2;
function carriage_belt_holder_edge_resolution() = 16;

function carriage_lower_belt_holder_z() = carriage_plate_height()/2 - 
                                          carriage_belt_holder_height() - 
                                          carriage_belt_holder_center_offset();
function carriage_upper_belt_holder_z() = carriage_plate_height()/2 +
                                          carriage_belt_holder_height() +
                                          carriage_belt_holder_center_offset();

/**
 * The location and dimension of the threaded insert to lock the belt in the carriage holder.
 * The position is relative to the origin of the result of carriage_belt_holder().
 */
function carriage_belt_holder_insert_hole_diameter() = 5.0;
function carriage_belt_holder_insert_hole_distance() = 0.5;
function carriage_belt_holder_insert_x() = -carriage_belt_holder_channel_width() / 2 -
                                           carriage_belt_holder_insert_hole_distance() - 
                                           carriage_belt_holder_insert_hole_diameter() / 2;
function carriage_belt_holder_insert_y() = carriage_belt_holder_height() - 
                                           carriage_belt_holder_path_width() - 
                                           carriage_belt_holder_center_height()-
                                           carriage_belt_holder_path_width() - 
                                           carriage_belt_holder_insert_hole_distance() - 
                                           carriage_belt_holder_insert_hole_diameter() / 2;

/** 
 * The size of the gap that is left in the carriage to leave room for the tensioner.
 */
function carriage_tensioner_gap_width()  = tensioner_width() + 6;
function carriage_tensioner_gap_height() = carriage_plate_height() - carriage_upper_belt_holder_z();

/** 
 * The positions of the balls relative to the carriage origin. Due to the rotation of the ball holder,
 * this is not really easy to determine any more...
 */
function carriage_ball_position(left = true) = [
    carriage_plate_thickness() + 
      (cos(carriage_ball_holder_angle() + carriage_ball_holder_angle_joint_ball_center()) * carriage_ball_holder_distance_joint_ball_center()),
    left 
      ? -rod_distance()/2 
      : rod_distance()/2,
    carriage_plate_height() +
      (sin(carriage_ball_holder_angle() + carriage_ball_holder_angle_joint_ball_center()) * carriage_ball_holder_distance_joint_ball_center())
  ];

/**
 * The inward offset of the carriage from the rail origin (+X in the vertical assembly).
 */
function carriage_x_offset() = washer_thickness(M5) + epsilon() + 
                           vwheel_assembly_thickness() / 2 + 
                           makerslide_base_depth();

// ----- carriage ball holder -----------------------------------------------------------------------------------------

/**
 * The dimensions of the ball holder.
 */
function carriage_ball_holder_width() = ball_diameter();
function carriage_ball_holder_height() = ball_diameter()/2;
function carriage_ball_holder_depth() = 
  carriage_ball_holder_joint_depth() + 
  magnet_holder_top_thickness() +
  magnet_height() - magnet_contact_circle_depth() +
  ball_diameter();

/**
 * The upward angle of the ball holder.
 */
function carriage_ball_holder_angle() = CARRIAGE_BALL_HOLDER_ANGLE;

/**
 * The widths and depth of the devetail joint between the carriage and the ball holder.
 */
function carriage_ball_holder_joint_inner_width() = 0.6 * carriage_ball_holder_width();
function carriage_ball_holder_joint_outer_width() = 0.8 * carriage_ball_holder_width();
function carriage_ball_holder_joint_depth() = carriage_plate_thickness() / cos(carriage_ball_holder_angle());

/**
 * The depth of the recess that holds the ball.
 */
function carriage_ball_holder_recess_depth() = ball_diameter()/4;

/** 
 * The position of the ball holder (relative to the origin of the carriage, w/o rotation).
 */
function carriage_ball_holder_position(left = true) = [
    carriage_plate_thickness(),
    left ? -rod_distance()/2 : rod_distance()/2,
    carriage_plate_height() - carriage_ball_holder_height()
  ];

/** 
 * The position of the ball in the ball holder (relative to the origin of the ball holder, w/o rotation).
 */
function carriage_ball_holder_ball_position() = [
    carriage_ball_holder_depth() - carriage_ball_holder_joint_depth() - ball_diameter()/2,
    0,
    carriage_ball_holder_height() + ball_diameter()/2 - carriage_ball_holder_recess_depth()
  ];

/**
 * The distance of the upper edge of the dove tail joint from the YZ plane.
 */
function carriage_ball_holder_distance_origin_joint() = 
  (carriage_ball_holder_angle() == 0) ? 0 : carriage_ball_holder_height() * tan(carriage_ball_holder_angle());

/**
 * The angle under which the center of the ball is seen from the upper center of the dove tail joint.
 */
function carriage_ball_holder_angle_joint_ball_center() = 
  atan((ball_diameter()/2 - carriage_ball_holder_recess_depth()) /
       (carriage_ball_holder_ball_position()[0] - carriage_ball_holder_distance_origin_joint()));

/**
 * The distance of the center of the ball from the upper center of the dove tail joint.
 */
function carriage_ball_holder_distance_joint_ball_center() = 
  sqrt(pow((ball_diameter()/2 - carriage_ball_holder_recess_depth()), 2) +
       pow((carriage_ball_holder_ball_position()[0] - carriage_ball_holder_distance_origin_joint()), 2));

/**
 * The resolution with which to render the rounded parts of the ball holder. 
 */
function carriage_ball_holder_resolution() = 32;

// ----- belt tensioner -----------------------------------------------------------------------------------------------

/**
 * The range by which the vertical belt tensioner can be adjusted.
 */
function tensioner_range() = TENSIONER_RANGE;

/**
 * The dimensions of the tensioners that hold the upper end of the belt.
 */
function tensioner_idler_gap_depth() = 2 * bearing_f623_width() + 2 * washer_thickness(M3);
function tensioner_flange_width() = 2;
function tensioner_separator_thickness() = 2; 
function tensioner_depth() = tensioner_idler_gap_depth() + 2 * frame_wall_thickness();
function tensioner_width() = bearing_f623_flange_diameter() + 2 * tensioner_flange_width();

/** 
 * The length of the tensioner screw is determined from the desired tensioner range.
 */
function tensioner_vertical_screw_min_length() = washer_thickness(M4) + 
                                                     tensioner_range() + 
                                                     (2*frame_wall_thickness()/3) + 
                                                     nut_thickness(M4);
function tensioner_vertical_screw_length() = select_next_screw_length(
                                               size = M4, 
                                               min_length = tensioner_vertical_screw_min_length());

/**
 * The height of the free space between the running surface of the idler and the tensioner plate.
 */
function tensioner_idler_z_offset() = (bearing_f623_flange_diameter() - bearing_f623_outer_diameter())/2 + 
                                      tensioner_flange_width();

/** 
 * The height of the empty space inside the upper bracket.
 */
function tensioner_screw_bracket_inner_height() = tensioner_vertical_screw_length() - 2 * frame_wall_thickness();

/**
 * The dimensions of the groove to leave out of the head piece to leave room for the tensioner idler axle.
 */
function head_tensioner_groove_width()  = washer_diameter(M4) + 2;
function head_tensioner_groove_depth()  = nut_thickness(M4) * 2;
function head_tensioner_groove_height() = head_makerslide_recess_depth() / 2;

/**
 * The X position of the tensioners relative to the back side (origin) of the MakerSlide rail.
 */
function tensioner_x_offset() = makerslide_depth() + vmotor_gt2_belt_rail_distance() + gt2_belt_width()/2;

/**
 * The default position of the tensioner screws. Defaults to 3/4 of the screw length, so that 1/4 of the screw is
 * screwed in, the remaining 3/4 can still be used to tighten the tensioner.
 */
function tensioner_screw_position() = 0.75 * tensioner_vertical_screw_length();
// function tensioner_screw_position() = frame_wall_thickness(); 

/**
 * The distance between the tensioner screw/washer and the idler running surface (the "origin" of the tensioner).
 */
function tensioner_z_offset() = tensioner_screw_position() + 
                                frame_wall_thickness() + 
                                tensioner_screw_bracket_inner_height() +
                                tensioner_separator_thickness() + 
                                tensioner_idler_z_offset();

// ----- end switch bracket -------------------------------------------------------------------------------------------

/** 
 * The dimensions of the bracket that hold the end switch.
 */
function end_switch_bracket_thickness()             =  3;
function end_switch_bracket_foot_depth()            = 20;
function end_switch_bracket_foot_height()           = 10;
function end_switch_bracket_screw_hole_diameter()   =  2;

function end_switch_bracket_top_height()          = 17.5;
function end_switch_bracket_top_depth()           = 10;
function end_switch_bracket_top_width()           = 10;
function end_switch_bracket_top_nutcatch_height() = 7.5;

function end_switch_bracket_edge_radius()     =  2;
function end_switch_bracket_edge_resolution() = 16;

function end_switch_bracket_total_height()    = end_switch_bracket_foot_height() + end_switch_bracket_top_height();

function end_switch_bracket_spring_height() = 20;
function end_switch_bracket_screw_length() = select_next_screw_length(size = M3, min_length = 
                                               washer_thickness(M3) + 
                                               frame_wall_thickness() +
                                               end_switch_bracket_spring_height() + 
                                               (end_switch_bracket_top_nutcatch_height() - nut_thickness(M3))/2);

/**
 * The position of the end switch bracket.
 */
function end_switch_bracket_x_offset() = tensioner_x_offset() - tensioner_depth()/2;
function end_switch_bracket_y_offset() = tensioner_width() / 2 + head_guide_width() + 2 * head_guide_clearance();
function end_switch_bracket_z_offset() = frame_wall_thickness() + 
                                         end_switch_bracket_spring_height() + 
                                         end_switch_bracket_total_height(); 

// ----- magnet holder ------------------------------------------------------------------------------------------------

/**
 * The dimensions of the part that hold the magnet.
 */
function magnet_holder_top_diameter() = magnet_outer_diameter();
function magnet_holder_top_thickness() = MAGNET_HOLDER_THICKNESS;
function magnet_holder_pin_diameter() = magnet_bore_diameter();
// The pin must be small enough not to touch the ball, but not taller than the inner bore height.
function magnet_holder_pin_height() = 
  min(
    magnet_height() - magnet_bevel_depth(),
    ball_center_magnet_base_distance() - ball_diameter()/2
  );

/**
 * The clearance left between the magnet / steel ball and the arm.
 */
function magnet_holder_arm_clearance() = magnet_outer_diameter() / 4;

/**
 * The minimum clearance to leave beneath the ball.
 */
function magnet_holder_top_ball_clearance() = 8;
function magnet_holder_bottom_ball_clearance() = 20;

/**
 * The dimensions of the arm.
 */
function magnet_holder_arm_width() = magnet_outer_diameter();
function magnet_holder_arm_thickness() = MAGNET_HOLDER_THICKNESS;
function magnet_holder_arm_length(ball_clearance) = 
  magnet_holder_top_thickness() +
  magnet_height() + 
  ball_diameter() + 
  ball_clearance - magnet_holder_arm_clearance();

/**
 * The thickness of the outer wall around the rod.
 */
function magnet_holder_rod_wall_thickness() = ROD_HOLDER_WALL_THICKNESS;

/**
 * The depth of the insets that hold the rods.
 */
function magnet_holder_rod_holder_depth() = ROD_HOLDER_DEPTH;

/**
 * The additional clearance to leave between the rod and the holder.
 */
function magnet_holder_rod_clearance() = ROD_CLEARANCE;

/**
 * The additional clearance to leave around the magnet holder pin.
 */
function magnet_holder_magnet_clearance() = MAGNET_CLEARANCE;

/**
 * The distance between the center of the ball and the end of the rod in the holder.
 */
function magnet_holder_rod_distance(ball_clearance) = 
  ball_diameter()/2 +
  ball_clearance +
  magnet_holder_rod_wall_thickness(); 

/** 
 * The thickness of the rod holder.
 */
function magnet_holder_arm_thickness() = MAGNET_HOLDER_THICKNESS;

/** 
 * The rendering resolution for the magnet holder.
 */
function magnet_holder_resolution() = 32;

// ----- effector base plate ------------------------------------------------------------------------------------------

/**
 * The depth of the recess that holds the ball.
 */
function effector_base_ball_recess_depth() = ball_diameter()/4;

/**
 * The additional distance between the balls on the short sides of the effector (not the rod distance - the other 
 * one :-)).This value is added to the minimum distance determined by the ball size.
 */
function effector_base_ball_add_distance() = EFFECTOR_BALL_ADDITIONAL_DISTANCE;

/**
 * The distance of the balls on the short side of the effector - center to center.
 */
function effector_base_ball_distance() = ball_diameter() + effector_base_ball_add_distance();

/**
 * The thickness of the effector plate. 
 */
function effector_base_thickness() = EFFECTOR_THICKNESS;

/**
 * The height and edge length of the "cut-off" points of the effector - the parts that were left out to turn the
 * triangle into a hexagon.
 */
function effector_base_cutoff_edge_length() = effector_base_ball_distance();
function effector_base_cutoff_height() = effector_base_ball_distance()/2 * tan(60);

/**
 * The height and edge lenght of the base triangle that the effector would be if the points hadn't been cut off.
 */
function effector_base_triangle_edge_length() = rod_distance() + 2 * effector_base_cutoff_edge_length();
function effector_base_triangle_height() = effector_base_triangle_edge_length() * sin(60);

/** 
 * The distance of the center of the effector from one of the long sides / corners.
 * (The height of the center point of the base triangle and its inverse.)
 */
function effector_base_center_long_edge_distance() = effector_base_triangle_edge_length()/2 * tan(30);
function effector_base_center_short_edge_distance() = effector_base_center_corner_distance() - effector_base_cutoff_height();
function effector_base_center_corner_distance() = effector_base_triangle_height() - effector_base_center_long_edge_distance();
function effector_base_long_short_edge_distance() = effector_base_center_long_edge_distance() + effector_base_center_short_edge_distance();

/**
 * The positions of the balls in the effector, relative to the bottom center of the effector.
 */
function effector_base_ball_position_a_left() = 
    [
      effector_base_center_short_edge_distance(),
      -effector_base_cutoff_edge_length()/2,
      effector_base_ball_recess_depth() - ball_diameter()/2
    ];
function effector_base_ball_position_a_right() = 
    [
      -effector_base_center_long_edge_distance() + effector_base_cutoff_height(),
      -(rod_distance()/2 + effector_base_cutoff_edge_length()/2),
      effector_base_ball_recess_depth() - ball_diameter()/2
    ];
function effector_base_ball_position_b_left() = 
    [
      -effector_base_center_long_edge_distance() + effector_base_cutoff_height(),
      rod_distance()/2 + effector_base_cutoff_edge_length()/2,
      effector_base_ball_recess_depth() - ball_diameter()/2
    ];
function effector_base_ball_position_b_right() = 
    [
      effector_base_center_short_edge_distance(),
      effector_base_cutoff_edge_length()/2,
      effector_base_ball_recess_depth() - ball_diameter()/2
    ];
function effector_base_ball_position_c_left() = 
    [
      -effector_base_center_long_edge_distance(),
      rod_distance()/2,
      effector_base_ball_recess_depth() - ball_diameter()/2
    ];
function effector_base_ball_position_c_right() = 
    [
      -effector_base_center_long_edge_distance(),
      -rod_distance()/2,
      effector_base_ball_recess_depth() - ball_diameter()/2
    ];

/**
 * The dimensions of the ball holder parts.
 */
function effector_base_ball_holder_height() = effector_base_thickness() + ball_diameter()/2 - effector_base_ball_recess_depth();
function effector_base_ball_holder_diameter() = ball_diameter();

/** 
 * The rendering resolution for the effector base.
 */
function effector_base_resolution() = 32;

// ===== ROD LENGTH CALCULATION =======================================================================================

/**
 * The minimum angle of the arms.
 */
function arm_min_angle() = ROD_MIN_ANGLE;

/**
 * The factor used to round up the rod length.
 */
function arm_rod_round_up_factor() = ROD_ROUND_UP_TO;

/**
 * The horizontal length ("distance over ground") the arms will have to cover when extended to the most distant point.
 * This length is calculated from ball center to ball center, i. e. it includes the magnet holders.
 */
function arm_max_ground_distance() = 
  ball_plane_distance_center_corner() + horizontal_distance_center_edge() - effector_base_long_short_edge_distance();
// TODO might need an additional threshold here to prevent the arms from overstretching

/**
 * The exact length of the arms when extended to the the most distant point at the minimum angle configured.
 * This length is calculated from ball center to ball center, i. e. it includes the magnet holders.
 */
function arm_exact_overall_length() = arm_max_ground_distance() / cos(arm_min_angle());

/**
 * The exact length of the rods when reaching for the most distant point.
 */
function arm_rod_exact_length() = 
  arm_exact_overall_length() 
  - magnet_holder_rod_distance(magnet_holder_top_ball_clearance())
  - magnet_holder_rod_distance(magnet_holder_bottom_ball_clearance());

/**
 * The length of the rod rounded up as per the configured value.
 */
function arm_rod_length() = ceil((arm_rod_exact_length() / arm_rod_round_up_factor())) * arm_rod_round_up_factor();

/**
 * The length of the entire arm from ball center to ball center.
 */
function arm_overall_length() = 
  arm_rod_length() 
  + magnet_holder_rod_distance(magnet_holder_top_ball_clearance())
  + magnet_holder_rod_distance(magnet_holder_bottom_ball_clearance());

// ===== SCREWS, NUTS, BOLTS AND OTHER HARDWARE =======================================================================

/**
 * The diameter of the screws used to assemble the frame. Not configurable because that would introduce weird 
 * dependency tracing issues with the rendered screws.
 */
function frame_screw_size() = M4;

/**
 * The diameter of the heads of the screws used to assemble the frame. Actually, this is the size of the inset flange.
* The screw head of a M5 hex screw is 8.5 mm in diameter, so 10 mm should leave enough clearance.
 */
function frame_screw_head_size() = washer_diameter(frame_screw_size() + 1);

/**
 * The rendering resolution of the screw holes. Not configurable at the moment.
 */
function frame_screw_hole_resolution() = 16;

// ===== PART PLACEMENT ================================================================================================

/*
 * Each of the horizontal extrusion sets is placed outside of the construction triangle. This function specifies the
 * distance by which the rails are offset.
 */
function horizontal_extrusion_outward_offset() = (makerslide_base_width()/2 * sin(60)) - (vslot_2020_width()/2);

/**
 * The distance of the motor front face to the inward face of the vertical MakerSlide extrusion.
 * The nominal length of the axis is 24 mm. The value of frame_wall_thickness() (default 3mm) is irrelevant here 
 * because it applies to both the inner wall of the bracket and the motor mounting plate in the same direction.
 */
function vmotor_rail_distance() = 30; // must be greater than vmotor_shaft_length();

/**
 * The height at which the motor is mounted. 
 */
function vmotor_z_offset() = motor_bracket_z_offset() + motor_bracket_height() / 2;

/**
 * Whether to place the pulley bevel-first on the motor (false) or gear-first (false).
 */
function vmotor_gt2_pulley_reversed() = false; 

/** 
 * The distance of the pulleys and belts from the inward face of the vertical MakerSlide extrusion.
 */
function vmotor_gt2_pulley_rail_distance() = vmotor_gt2_pulley_reversed() ?
  vmotor_rail_distance() - 3 - gt2_pulley_depth() : // reversed
  vmotor_rail_distance() - 4.5; // normal

function vmotor_gt2_belt_rail_distance() = vmotor_gt2_pulley_reversed() ?
  vmotor_gt2_pulley_rail_distance() + gt2_pulley_base_depth() + 1.5 : // reversed
  vmotor_gt2_pulley_rail_distance() - gt2_pulley_base_depth() - gt2_belt_width() - 1.5; // normal

/**
 * The length of the belt - or more precisely the distance between the centers of the two bearings.
 */
function belt_center_distance() = vertical_extrusion_length() 
                                  - vmotor_z_offset() // bottom distance
                                  - (tensioner_z_offset() + bearing_f623_outer_diameter() / 2); // top distance

// ===== ARM MOVEMENT ==================================================================================================

/** 
 * Determines the distance of the "ball plane" from the center of the build plate.
 */
function ball_plane_distance_center_corner() = 
  horizontal_distance_center_corner() - carriage_x_offset() - carriage_ball_position(left = true)[0];

/**
 * Determines the distance of the edge of the "ball plane triangle" from the center of the build plate.
 */
function ball_plane_distance_center_edge() = sin(30) * ball_plane_distance_center_corner();

/**
 * The height of the "ball plane triangle".
 */
function ball_plane_base_height() = ball_plane_distance_center_corner() + ball_plane_distance_center_edge();

/** 
 * The side length of the "ball plane triangle".
 */
function ball_plane_base_length() = ball_plane_base_height() / cos(30);

/**
 * Determines the positions of the centers of the ball planes.
 */
function ball_plane_position(axis = A) =
  (axis == A) ? [ball_plane_distance_center_edge(), -ball_plane_base_length()/2] :
  (axis == B) ? [ball_plane_distance_center_edge(),  ball_plane_base_length()/2] :
  (axis == C) ? [-ball_plane_distance_center_corner(), 0] : [0, 0];

/**
 * Determines the distance of a point on the print surface from the axis given.
 */
function ball_plane_distance_corner_point(axis = A, point = [0, 0]) =
  sqrt(pow(point[0] - ball_plane_position(axis)[0], 2) + pow(point[1] - ball_plane_position(axis)[1], 2));

/**
 * Determines the distance of the edge of the effector from the axis given if centered on a certain point on the print 
 * surface.
 */
function ball_plane_distance_corner_effector(axis = A, point = [0, 0]) =
  ball_plane_distance_corner_point(axis = axis, point = point) - effector_base_center_long_edge_distance();

/**
 * Determines the angle phi (in the plane) from a certain axis to a given point. This is the absolute angle that 
 * still needs to be adapted to the orientation of the arm.
 */
function ball_plane_angle_corner_point_absolute(axis = A, point = [0, 0]) =
  asin((point[0] - ball_plane_position(axis)[0]) / ball_plane_distance_corner_point(axis = axis, point = point));

/**
 * Determines the angle of an arm in the plane (phi) for a given axis and point.
 */
function arm_angle_phi(axis = A, point = [0, 0]) =
  (axis == A) ? -(ball_plane_angle_corner_point_absolute(axis = axis, point = point) + 30) :
  (axis == B) ?  (ball_plane_angle_corner_point_absolute(axis = axis, point = point) + 30) :
  (axis == C) ? -(ball_plane_angle_corner_point_absolute(axis = axis, point = point) - 90) : 0;

/**
 * Determines the downward angle of the arm (theta) for a given axis and point.
 */
function arm_angle_theta(axis = A, point = [0, 0]) =
  asin(ball_plane_distance_corner_effector(axis = axis, point = point) / arm_overall_length());
  
/**
 * Determines the height of the upper ball joint for a given point above the print surface.
 */
function arm_ball_joint_height(axis = A, point = [0, 0, 0]) =
  bed_working_height() + 
  point[2] + 
  sqrt(pow(arm_overall_length(), 2) - pow(ball_plane_distance_corner_effector(axis = axis, point = point), 2));

/** 
 * Determines the height of the carriage for a given point above the print surface.
 */
function arm_carriage_height(axis = A, point = [0, 0, 0]) =
  arm_ball_joint_height(axis = axis, point = point) - carriage_ball_position(left = true)[2];

// /**
//  * Determines the distance in the horizontal plane of a point from a given rail.
//  */
// function arm_target_base_distance(rail = [0, 0], point = [0, 0, 0]) = 
//   (rail[0] == point[0]) ?
//     (abs(point[1] - rail[1]))
//   :
//     sqrt(pow(rail[0] - point[0], 2) + pow(rail[1] - point[1], 2))
//   ;

// /**
//  * Determines the angle between the normal of an axis and a given point in thr horizontal plane.
//  */
// function arm_target_base_angle(rail = [0, 0], rail_angle = 0, point = [0, 0, 0]) = 
//   (point[1] == rail[1]) ?
//     0
//   :
//     abs(rail_angle/4) - atan(abs(point[0] - rail[0])/abs(point[1] - rail[1]))
//   ;

// /**
//  * Determines the height of the upper end of the arm for a given point. 
//  */
// function arm_target_upper_height(rail = [0, 0], point = [0, 0, 0]) =
//   point[2] + sqrt(pow(arm_overall_length(), 2) - pow(arm_target_base_distance(rail, point), 2));


// ===== AUXILIARY FUNCTIONS ===========================================================================================

/**
 * A small value that can be added to or subtracted from edges to eliminate rendering artifacts.
 */
function epsilon() = 0.01;

