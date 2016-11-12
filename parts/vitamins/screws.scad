/**********************************************************************************************************************
 **
 ** parts/vitamins/screws.scad
 **
 ** This file provides access to the pre-rendered screws and nuts created with the nutsnbolts library.
 **
 **********************************************************************************************************************/

use <../../bom/bom.scad>
use <../../conf/colors.scad>

/**
 * Provides the pre-rendered screws.
 * The screw is centered along the X axis with the thread extending into positive X.
 */
module screw_m3(length) {
	bom_entry(section = "General Hardware", 
		description = "DIN 912 / ISO 4762 Hex Socket Head Cap Screw", 
		size = str("M3 x ", length, " mm"));
	color_hardware()
		import(file = str("screw_M3x", length, ".stl")); 
}
module screw_m4(length) {
	bom_entry(section = "General Hardware", 
		description = "DIN 912 / ISO 4762 Hex Socket Head Cap Screw", 
		size = str("M4 x ", length, " mm"));
	color_hardware()
		import(file = str("screw_M4x", length, ".stl")); 
}
module screw_m5(length) {
	bom_entry(section = "General Hardware", 
		description = "DIN 912 / ISO 4762 Hex Socket Head Cap Screw", 
		size = str("M5 x ", length, " mm"));
	color_hardware()
		import(file = str("screw_M5x", length, ".stl")); 
}

/**
 * Provides the pre-rendered nuts.
 * The nut is centered along the X axis with the thread extending into positive X.
 */
module nut_m3() {
	bom_entry(section = "General Hardware", 
		description = "DIN 934 / ISO 4032 Hex Nut", 
		size = "M3");
	color_hardware()
		import(file = "nut_M3.stl"); 
}
module nut_m4() {
	bom_entry(section = "General Hardware", 
		description = "DIN 934 / ISO 4032 Hex Nut", 
		size = "M4");
	color_hardware()
		import(file = "nut_M4.stl"); 
}
module nut_m5() {
	bom_entry(section = "General Hardware", 
		description = "DIN 934 / ISO 4032 Hex Nut", 
		size = "M5");
	color_hardware()
		import(file = "nut_M5.stl"); 
}


/**
 * Provides a pre-rendered T-slot nut.
 * Well, actually it doesn't. We can live without it since in most cases the nut will be hidden by some
 * frame part. What this module does, however, is create a 
 */
module nut_tslot_m5() {
	bom_entry(section = "General Hardware", description = "T-Slot Nut", size = "M5");
}
