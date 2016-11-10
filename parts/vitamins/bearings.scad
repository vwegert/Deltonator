/**********************************************************************************************************************
 **
 ** parts/vitamins/bearings.scad
 **
 ** This file provides access to the pre-rendered bearings.
 **
 **********************************************************************************************************************/

use <../../bom/bom.scad>
use <../../conf/colors.scad>

// /**
//  * Provides the pre-rendered screws.
//  * The screw is centered along the X axis with the thread extending into positive X.
//  */
// module screw_m3(length) {
// 	bom_entry(section = "General Hardware", description = "DIN 912 / ISO 4762 Hex Socket Head Cap Screw", size = str("M3 x ", length, " mm"));
// 	color_hardware()
// 		import(file = str("screw_M3x", length, ".stl")); 
// }
// module screw_m5(length) {
// 	bom_entry(section = "General Hardware", description = "DIN 912 / ISO 4762 Hex Socket Head Cap Screw", size = str("M5 x ", length, " mm"));
// 	color_hardware()
// 		import(file = str("screw_M5x", length, ".stl")); 
// }


/**
 * Provides a pre-rendered V-Wheel used on the MakerSlide Rails.
 * The wheel is centered along the X axis with the body extending into positive X.
 */
module vslot_wheel() {
	bom_entry(section = "Other Parts", description = "V-Wheel for MakerSlide", size = "");
	color_vwheels()
		import(file = "vwheel_dbl_bearing.stl")); 
}
