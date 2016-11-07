/**********************************************************************************************************************
 **
 ** lib/nutsnbolts/nutsnbolts.scad
 **
 ** This file provides access to the pre-rendered parts of the nutsnbolts library.
 **
 **********************************************************************************************************************/

use <../../bom/bom.scad>
use <../../conf/colors.scad>

/**
 * Provides the pre-rendered screws.
 * The screw is centered along the X axis with the thread extending into positive X.
 */
module screw_m3(length) {
	bom_entry(section = "General Hardware", description = "DIN 912 / ISO 4762 Hex Socket Head Cap Screw", size = str("M3 x ", length, "mm"));
	color_hardware()
		import(file = str("screw_M3x", length, ".stl")); 
}
module screw_m5(length) {
	bom_entry(section = "General Hardware", description = "DIN 912 / ISO 4762 Hex Socket Head Cap Screw", size = str("M5 x ", length, "mm"));
	color_hardware()
		import(file = str("screw_M5x", length, ".stl")); 
}


/**
 * Provides a pre-rendered T-slot nut.
 * Well, actually it doesn't. We can live without it since in most cases the nut will be hidden by some
 * frame part. What this module does, however, is create a 
 */
module nut_tslot_m5() {
	bom_entry(section = "General Hardware", description = "T-Slot Nut", size = "M5");
}
