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
 * The color of the cast aluminium parts.
 */
module color_cast_aluminium() {
	color("Silver")
		children();
} 

/**
 * The color of the solid parts of the enclosure.
 */
module color_enclosure_solid() {
	color("BurlyWood")
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
 * The color of the printed power supply and distribution cases.
 */
module color_printed_psd_case() {
	color("DodgerBlue")
		children();
} 

/**
 * The color of the printed carriages.
 */
module color_printed_carriage() {
	color("DodgerBlue")
		children();
} 

/**
 * The color of the printed tensioners and end switch brackets.
 */
module color_printed_head_parts() {
	color("PowderBlue")
		children();
} 

/**
 * The color of the magnet holders.
 */
module color_printed_magnet_holders() {
	color("RoyalBlue")
		children();
} 

/**
 * The color of the printed effectors.
 */
module color_printed_effector() {
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
 * The color of the magnets and steel balls.
 */
module color_magnets_balls() {
	color("Silver")
		children();
} 

/**
 * The color of the gears and ball bearings.
 */
module color_gears() {
	color("Gray")
		children();
} 

/**
 * The color of the belts.
 */
module color_belt() {
	color("SaddleBrown")
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
 * The color of the powder coated parts (e. g. the extruder mount brackets).
 */
module color_powder_coated() {
	color([0.15, 0.15, 0.15])
		children();
} 

/**
 * The color of the end switches.
 */
module color_switch() {
	color([0.15, 0.15, 0.15])
		children();
} 

/**
 * The color of the V-Wheels.
 */
module color_vwheels() {
	color([0.075, 0.075, 0.075])
		children();
} 

/**
 * The color of the carbon fiber rods for the arms.
 */
module color_rod() {
	color([0.2, 0.2, 0.2])
		children();
} 

/**
 * The color for electronic component placeholders
 */
module color_electronics() {
	color("Green")
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
