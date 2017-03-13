/**********************************************************************************************************************
 **
 ** conf/constants.scad
 **
 ** This file contains constants and aliases used for the part size definitions.
 **
 **********************************************************************************************************************/

/**
 * The alias names for the rails.
 * A is the "front left" rail, B the "front right" rail, C the back rail.
 * These constants are also used for the sides of the frame and the effector; in this case, side A is the one 
 * opposing rail A.
 */
A = 0;
B = 1;
C = 2;

/**
 * Aliases for metric screw/nut sizes.
 */
M2 = 2;
M3 = 3;
M4 = 4;
M5 = 5;
M8 = 8;

/** 
 * Aliases for NEMA stepper motors.
 */
NEMA14 = 14;
NEMA17 = 17;
NEMA23 = 23;

/**
 * The various types of effector heads supported.
 */
EFFECTOR_DUMMY      = 0;
EFFECTOR_E3D_V6LITE = 1;
