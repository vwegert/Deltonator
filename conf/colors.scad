/**********************************************************************************************************************
 **
 ** conf/colors.scad
 **
 ** This file defines some modules to use symbolic colors throughout the entire project.
 **
 **********************************************************************************************************************/

/**
 * The color of the aluminium extrusions.
 */
module color_extrusion() {
	color("LightGrey")
		children();
} 

/**
 * The color of the "outer" printed frame elements.
 */
module color_printed_outer_frame() {
	color("RoyalBlue")
		children();
} 

/**
 * The color of the "inner" printed frame elements.
 */
module color_printed_inner_frame() {
	color("DodgerBlue")
		children();
} 

/**
 * The color of the stock hardware parts like nuts, bolts and screws.
 */
module color_hardware() {
	color("DarkSlateGray")
		children();
} 

/**
 * The color of the stepper motors.
 */
module color_motor() {
	color("DimGray")
		children();
} 

/**
 * The color of punches and other objects that are usually not intended to be rendered as such, but rather to be
 * used as subtractive objects.
 */
module color_punch() {
	color("Red")
		children();
} 
