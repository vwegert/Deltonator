/**********************************************************************************************************************
 **
 ** parts/vitamins/washers.scad
 **
 ** This file provides access to the pre-rendered washers.
 **
 **********************************************************************************************************************/

use <../../bom/bom.scad>
use <../../conf/colors.scad>

/**
 * Provides the pre-rendered washers.
 * The washer is centered along the X axis with the body extending into positive X.
 */
module washer_m3() {
	bom_entry(section = "General Hardware", description = "DIN 125A / ISO 7089 Washer", size ="M3");
	color_hardware()
		import(file = "washer_M3.stl"); 
}
module washer_m4() {
	bom_entry(section = "General Hardware", description = "DIN 125A / ISO 7089 Washer", size ="M3");
	color_hardware()
		import(file = "washer_M4.stl"); 
}
module washer_m5() {
	bom_entry(section = "General Hardware", description = "DIN 125A / ISO 7089 Washer", size ="M3");
	color_hardware()
		import(file = "washer_M5.stl"); 
}
