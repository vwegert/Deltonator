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

// ===== FRAME RAIL DIMENSIONS ========================================================================================

// The length of the vertical MakerSlide extrusions that make up the rails for the carriages.
FRAME_V_RAIL_HEIGHT = 800;

// The length of the horizontal 20x20 V-Slot extrusions that form the sides of the triangle.
FRAME_H_RAIL_LENGTH = 400;

// ===== WORKING SURFACE (BED) DIMENSIONS =============================================================================

// The thickness of the plate that serves as the heated bed.
BED_THICKNESS = 4;

// The diameter of the plate that serves as the heated bed.
BED_DIAMETER = 300;

// ===== DIMENSIONS OF THE PRINTED FRAME PARTS ========================================================================

// The additional clearance to leave around the MakerSlide extrusion.
MAKERSLIDE_CLEARANCE = 0.25;

// The thickness of the walls outside the extruded parts.
FRAME_PART_WALL_THICKNESS = 3;

// The thickness of the wall that separates the vertical rails from the horizontal extrusions.
FRAME_V_H_RAIL_SEPARATION = 8;

// The depth of the holes that hold the V-Slot extrusions.
FRAME_PART_VSLOT_DEPTH = 30;

// Whether to use a horizontal rail at the base of the printer or not.
FRAME_HORIZONTAL_BASE_RAIL = true;

// The depth of the holes in the foot that hold the MakerSlide extrusions. This is for the foot version that holds
// a horizontal rail.
FRAME_FOOT_RAIL_MAKERSLIDE_DEPTH = 23; 

// The depth of the plate in the foot that the external foot will screw into.
FRAME_FOOT_RAIL_PLATE_DEPTH = 15;

// The thickness of the plate in the foot that the external foot will screw into.
// Hint: Easier to print (although more material is required) if equals to FRAME_FOOT_RAIL_MAKERSLIDE_DEPTH.
FRAME_FOOT_RAIL_PLATE_HEIGHT = 23;

// The depth of the holes in the foot that hold the MakerSlide extrusions. This is for the foot version that does not
// hold a horizontal rail.
FRAME_FOOT_NORAIL_MAKERSLIDE_DEPTH = 17.5; 

// The size of the screws that can be used to mount the foot to the underlying surface.
FRAME_FOOT_PLATE_SCREW_SIZE = M8;

// The clearance to leave around the screw head on all sides.
FRAME_FOOT_PLATE_SCREW_HEAD_CLEARANCE = 0.25;

// The diameter of the adjustable foot that screws into the foot bracket. 
// Note that the polygon is INscribed into this circumference.
FRAME_FOOT_PLATE_DIAMETER = 50;

// The number of sides to the adjustable foot that screws into the foot bracket.
FRAME_FOOT_PLATE_SIDES = 8;

// The thickness of the adjustable foot that screws into the foot bracket.
// Keep this larger than the head of the screw used to fix it, or you will run into trouble.
FRAME_FOOT_PLATE_THICKNESS = 6.5;

// The height of the bracket that holds the motor. WARNING: Increasing this might make it difficult to 
// turn the screws that hold the motor.
FRAME_MOTOR_BRACKET_HEIGHT = 20;

// The height of the bracket that holds the intermediate level with the working surface (print bed).
// Will be A LOT easier to print if equals to 2020 extrusion width + FRAME_PART_WALL_THICKNESS
FRAME_BED_BRACKET_HEIGHT = 23; 

// The depth of the holes in the head that hold the MakerSlide extrusions.
FRAME_HEAD_MAKERSLIDE_DEPTH = 35; 

// The clearance between the tensioner / bracket and its guide blocks on either side.
FRAME_HEAD_GUIDE_CLEARANCE = 0.5;

// ===== ENCLOSURE DIMENSIONS =========================================================================================

// The material thickness of the solid (back and side) enclosure walls.
ENCLOSURE_SOLID_THICKNESS = 6.5;

// The thickness of the insulation layer between the enclosure walls and the brackets they are mounted to.
ENCLOSURE_INSULATION_THICKNESS = 2;

// The gap between the horizontal extrusions and the enclosure side walls.
ENCLOSURE_SIDE_GAP = 40;

// The factor used to round down the enclosure plate widths.
ENCLOSURE_ROUND_DOWN_TO = 1;

// The thickness of the brackets that hold the outer enclosure walls.
ENCLOSURE_BRACKET_THICKNESS = 6;

// The width of the brackets that hold the outer enclosure walls, excluding the parts that bolt on to the 
// horizontal rails.
ENCLOSURE_BRACKET_WIDTH = 40;

// The size of the glass pane in the front door.
ENCLOSURE_GLASS_WIDTH = 350;
ENCLOSURE_GLASS_HEIGHT = 700;

// The size of the gap around the glass pane.
ENCLOSURE_GLASS_GAP_WIDTH = 1.0;

// The width of the bevel in the front door that holds the glass.
ENCLOSURE_GLASS_BEVEL_WIDTH = 15;

// The additional clearance on the sides of the front door to allow for the hinge to move.
ENCLOSURE_DOOR_SIDE_CLEARANCE = 2.0;

// The thickness of the material of the front door.
ENCLOSURE_DOOR_WOOD_THICKNESS = 3.0;
ENCLOSURE_DOOR_GLASS_THICKNESS = 1.8;

// ===== CARRIAGE DIMENSIONS ==========================================================================================

// The thickness of the carriage base plate. A thicker plate will make the carriage stiffer, but cost more
// material to print and take away space from the working area.
CARRIAGE_PLATE_THICKNESS = 6;

// The width of the border around the holes in the carriage base plate that hold the V-Wheels. 
CARRIAGE_PLATE_BORDER_WIDTH = 8;

// The upward angle of the ball holder on the carriage.
CARRIAGE_BALL_HOLDER_ANGLE = 10;

// ===== ARM DIMENSIONS AND PARAMETERS ================================================================================

// The distance between the rods that hold the effector.
ROD_DISTANCE = 65;

// The outer diameter of the rods.
ROD_OUTER_DIAMETER = 8;

// The inner diameter of the rods. Set to 0 if the rods are not hollow.
ROD_INNER_DIAMETER = 0;

// The additional clearance to leave between the rod and the holder.
ROD_CLEARANCE = 0.25;

// The thickness of the outer wall around the rod.
ROD_HOLDER_WALL_THICKNESS = 2.2;

// The depth of the insets that hold the rods.
ROD_HOLDER_DEPTH = 10;

// The size of the text on the outside of the rod holders.
ROD_HOLDER_TEXT_SIZE = 9;

// The depth of the text on the outside of the rod holders.
ROD_HOLDER_TEXT_DEPTH = 0.5;

// The minimum angle of the arms.
ROD_MIN_ANGLE = 18;

// The factor used to round up the rod length.
ROD_ROUND_UP_TO = 5;

// Set this to a positive value if you want the rods to have a fixed length (for example if you have pre-fabricated
// rods). Set this to a negative value to have the rod length calculated automatically.
ROD_FIXED_LENGTH = 330;

// The thickness of the magnet holder arms.
MAGNET_HOLDER_THICKNESS = 5;

// The additional clearance to leave around the magnet holder pin.
MAGNET_CLEARANCE = 0.025;

// ===== IR SENSOR DIMENSIONS AND PARAMETERS ==========================================================================

// The additional clearance to leave around the PCB.
IR_SENSOR_PCB_CLEARANCE = 0.25;

// The additional clearance to leave around the magnets.
IR_SENSOR_MAGNET_CLEARANCE = 0.2;

// The size of the screws used to adjust the IR sensor.
IR_SENSOR_ADJUSTMENT_SCREW_SIZE = M4;

// ===== EFFECTOR DIMENSIONS AND PARAMETERS ===========================================================================

// The additional distance between the magnets on the effector (not the rod distance - the other one :-)).
// This value is added to the minimum distance determined by the magnet size and wall thickness.
EFFECTOR_BALL_ADDITIONAL_DISTANCE = 15;

// The thickness of the effector plate.
EFFECTOR_THICKNESS = 4;

// The type of effector to use.
EFFECTOR_TYPE = EFFECTOR_E3D_V6LITE;

// The clearance in Z direction to leave beneath the effector plate.
EFFECTOR_Z_CLEARANCE = 30.0;

// ===== POWER DISTRIBUTION PARAMETERS ================================================================================

// The thickness of the cover walls.
POWER_WALL_THICKNESS = 2.5;

// The clearance between the inner and outer parts of the covers as well as between the covers.
POWER_CLEARANCE = 0.5;

// ===== OTHER DIMENSIONS AND PARAMETERS ==============================================================================

// The range by which the vertical belt tensioner can be adjusted.
TENSIONER_RANGE = 15;
