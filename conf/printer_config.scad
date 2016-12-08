/**********************************************************************************************************************
 **
 ** conf/printer_config.scad
 **
 ** This file contains the main control variables that determine the size and shape of the printer. Note that in the
 ** actual parts specifications, the constants defined here will only ever be accessed through functions defined in
 ** conf/derived_sizes.scad exclusively to allow for easier adaptation, should the mode of calculation change. 
 **
 ** All sizes in mm. Caution: Little to no cross-checking is implemented. Change values sensibly and one at a time.
 **
 ** This file is NOT to be included by any other file except for conf/derived_sizes.scad.
 **
 **********************************************************************************************************************/

include <constants.scad>

// ===== PRINTER CONFIGURATION ========================================================================================

// The length of the vertical MakerSlide extrusions that make up the rails for the carriages.
FRAME_V_RAIL_HEIGHT = 800;

// The length of the horizontal 20x20 V-Slot extrusions that form the sides of the triangle.
FRAME_H_RAIL_LENGTH = 400;

// ===== FABRICATED PART DIMENSIONS ===================================================================================

// The additional clearance to leave around the MakerSlide extrusion.
MAKERSLIDE_CLEARANCE = 0.05;

// The thickness of the walls outside the extruded parts.
FRAME_PART_WALL_THICKNESS = 3;

// The thickness of the wall that separates the vertical rails from the horizontal extrusions.
FRAME_V_H_RAIL_SEPARATION = 8;

// The depth of the holes that hold the V-Slot extrusions.
FRAME_PART_VSLOT_DEPTH = 30;

// Whether to use a horizontal rail at the base of the printer or not.
FRAME_HORIZONTAL_BASE_RAIL = false;

// The depth of the holes in the foot that hold the MakerSlide extrusions. This is for the foot version that holds
// a horizontal rail.
FRAME_FOOT_RAIL_MAKERSLIDE_DEPTH = 25; 

// The depth of the holes in the foot that hold the MakerSlide extrusions. This is for the foot version that does not
// hold a horizontal rail.
FRAME_FOOT_NORAIL_MAKERSLIDE_DEPTH = 17.5; 

// The size of the screws that can be used to mount the foot to the underlying surface.
FRAME_FOOT_BOTTOM_SCREW_SIZE = M5;

// The height of the bracket that holds the motor. WARNING: Increasing this might make it difficult to 
// turn the screws that hold the motor.
FRAME_MOTOR_BRACKET_HEIGHT = 25;

// The height of the bracket that holds the intermediate level with the working surface (print bed).
FRAME_BED_BRACKET_HEIGHT = 25; 

// The depth of the holes in the head that hold the MakerSlide extrusions.
FRAME_HEAD_MAKERSLIDE_DEPTH = 35; 

// The thickness of the carriage base plate. A thicker plate will make the carriage stiffer, but cost more
// material to print and take away space from the working area.
CARRIAGE_PLATE_THICKNESS = 6;

// The width of the border around the holes in the carriage base plate that hold the V-Wheels. 
CARRIAGE_PLATE_BORDER_WIDTH = 8;

// The range by which the vertical belt tensioner can be adjusted.
TENSIONER_RANGE = 15;

// The distance between the rods that hold the effector.
ROD_DISTANCE = 65;

// The outer diameter of the rods.
ROD_OUTER_DIAMETER = 6;

// The inner diameter of the rods. Set to 0 if the rods are not hollow.
ROD_INNER_DIAMETER = 4;

// The additional clearance to leave between the rod and the holder.
ROD_CLEARANCE = 0.05;

// The thickness of the outer wall around the rod.
ROD_HOLDER_WALL_THICKNESS = 2;

// The depth of the insets that hold the rods.
ROD_HOLDER_DEPTH = 10;

// The minimum angle of the arms.
ROD_MIN_ANGLE = 20;

// The factor used to round up the rod length.
ROD_ROUND_UP_TO = 5;

// The thickness of the magnet holder arms.
MAGNET_HOLDER_THICKNESS = 5;

// The additional clearance to leave around the magnet holder pin.
MAGNET_CLEARANCE = 0.025;

// The upward angle of the ball holder on the carriage.
CARRIAGE_BALL_HOLDER_ANGLE = 10;

// The additional distance between the magnets on the effector (not the rod distance - the other one :-)).
// This value is added to the minimum distance determined by the magnet size and wall thickness.
EFFECTOR_BALL_ADDITIONAL_DISTANCE = 15;

// The thickness of the effector plate.
EFFECTOR_THICKNESS = 8;

// The thickness of the plate that serves as the heated bed.
BED_THICKNESS = 4;

// The diameter of the plate that serves as the heated bed.
BED_DIAMETER = 300;
