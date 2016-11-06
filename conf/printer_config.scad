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

// The thickness of the walls outside the extruded parts.
FRAME_PART_WALL_THICKNESS = 3;

// The thickness of the wall that separates the vertical rails from the horizontal extrusions.
FRAME_V_H_RAIL_SEPARATION = 8;

// The depth of the holes that hold the V-Slot extrusions.
FRAME_PART_VSLOT_DEPTH = 30;

// The depth of the holes that hold the MakerSlide extrusions.
FRAME_PART_HSLOT_DEPTH = 35;

// The height of the bracket that holds the motor. WARNING: Increasing this might make it difficult to 
// turn the screws that hold the motor.
FRAME_PART_BRACKET_HEIGHT = 25;

// // ===== SCREWS, NUTS, BOLTS AND OTHER HARDWARE =======================================================================

// The diameter of the screws used to assemble the frame.
FRAME_SCREW_SIZE = 5;

// The diameter of the head of the screws used to assemble the frame. Actually, this is the size of the inset flange.
// The screw head of a M5 hex screw is 8.5 mm in diameter, so 10 mm should leave enough clearance.
FRAME_SCREW_HEAD_SIZE = 10;

