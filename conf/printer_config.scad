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

// The depth of the holes in the foot that hold the MakerSlide extrusions.
FRAME_FOOT_MAKERSLIDE_DEPTH = 25; 

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

// The downward angle of the magnets in the carriage.
CARRIAGE_MAGNET_ANGLE = 45;

// The outer diameter of the magnets in the carriage.
CARRIAGE_MAGNET_DIAMETER = 10;

// The depth of the magnets in the carriage.
CARRIAGE_MAGNET_DEPTH = 5;

// The thickness of the walls around the magnets.
CARRIAGE_MAGNET_WALL_THICKNESS = 4;

// The outward angle of the magnets in the effector.
EFFECTOR_MAGNET_ANGLE = 20;

// The outer diameter of the magnets in the effector.
EFFECTOR_MAGNET_DIAMETER = 15;

// The depth of the magnets in the effector.
EFFECTOR_MAGNET_DEPTH = 3;

// The thickness of the walls around the magnet.
EFFECTOR_MAGNET_WALL_THICKNESS = 3;

// The additional distance between the magnets on the effector (not the rod distance - the other one :-)).
// This value is added to the minimum distance determined by the magnet size and wall thickness.
EFFECTOR_MAGNET_ADDITIONAL_DISTANCE = 0;

// The minimal thickness of the effector plate. Note that if the magnet angle requires a thicker plate, the dimension
// will automatically be increased.
EFFECTOR_MIN_THICKNESS = 8;
