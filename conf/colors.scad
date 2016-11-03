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
 * The color of punches and other objects that are usually not intended to be rendered as such, but rather to be
 * used as subtractive objects.
 */
module color_punch() {
	color("Red")
		children();
} 
