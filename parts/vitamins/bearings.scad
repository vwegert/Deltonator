/**********************************************************************************************************************
 **
 ** parts/vitamins/bearings.scad
 **
 ** This file provides access to the pre-rendered bearings.
 **
 **********************************************************************************************************************/

use <../../bom/bom.scad>
use <../../conf/colors.scad>
use <../../conf/part_sizes.scad>

/**
 * Provides the pre-rendered ball bearings.
 * The bearing is centered along the X axis with the thread extending into positive X.
 */
module bearing(size, prefix = "", suffix = "") {
	bom_entry(section = "Bearings and Wheels", description = "Ball Bearing", size = str(prefix, size, suffix));
	color_gears()
		import(file = str("bearing_", size, ".stl")); 
}

/**
 * Provides a pre-rendered V-Wheel used on the MakerSlide Rails.
 * The wheel is centered along the X axis with the body extending into positive X.
 * Optionally, the matching ball bearings can be inserted as well. Note that in this case, one of the bearings
 * will reach into negative X space!
 */
module vslot_wheel(include_bearings = true) {
	bom_entry(section = "Bearings and Wheels", description = "V-Wheel for MakerSlide", size = "");
	color_vwheels()
		import(file = "vwheel_dbl_bearing.stl"); 
	if (include_bearings) {
		translate([vwheel_width() - vwheel_bearing_inset(), 0, 0])
			bearing(size = 625, suffix="RS");
		translate([-bearing_625_width() + vwheel_bearing_inset(), 0, 0])
			bearing(size = 625, suffix="RS");
	}
}

/**
 * Provides a pre-rendered eccentric spacer for the V-Wheel (only that this spacer isn't actually eccentric).
 * The spacer is centered along the X axis with the hexagonal body extending into positive X, the inset into negative X.
 */
module vslot_wheel_spacer() {
	bom_entry(section = "Bearings and Wheels", description = "Eccentric Spacer for V-Wheel", size = "");
	color_hardware()
		import(file = "vwheel_spacer.stl"); 
}
