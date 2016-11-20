/**********************************************************************************************************************
 **
 ** parts/vitamins/vitamins.scad
 **
 ** This file provides access to the pre-rendered parts.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

use <../../bom/bom.scad>

// ===== parts/vitamins/electromechanic/stepper_*.* ====================================================================

/**
 * Provides the pre-rendered stepper motors.
 * The motor is centered along the X axis with the shaft extending into positive X.
 */
module stepper_short(size) {
	_size = (size == NEMA14) ? 14 :
	        (size == NEMA17) ? 17 :
	        (size == NEMA23) ? 23 : -1;
	if (_size < 0) {
		echo(str("ERROR: Unknown stepper size size '", size, "'."));
	} else {	
		bom_entry(section = "Electronic Components", description = "Stepper Motor", size = str("NEMA ", _size, " short"));
		color_motor()
			import(file = str("electromechanic/stepper_nema", _size, "_short.stl")); 
	}
}
module stepper_medium(size = 17) {
	_size = (size == NEMA14) ? 14 :
	        (size == NEMA17) ? 17 :
	        (size == NEMA23) ? 23 : -1;
	if (_size < 0) {
		echo(str("ERROR: Unknown stepper size size '", size, "'."));
	} else {	
		bom_entry(section = "Electronic Components", description = "Stepper Motor", size = str("NEMA ", _size, " medium"));
		color_motor()
			import(file = str("electromechanic/stepper_nema", _size, "_medium.stl")); 
	}
}
module stepper_long(size = 17) {
	_size = (size == NEMA14) ? 14 :
	        (size == NEMA17) ? 17 :
	        (size == NEMA23) ? 23 : -1;
	if (_size < 0) {
		echo(str("ERROR: Unknown stepper size size '", size, "'."));
	} else {	
		bom_entry(section = "Electronic Components", escription = "Stepper Motor", size = str("NEMA ", _size, " long"));
		color_motor()
			import(file = str("electromechanic/stepper_nema", _size, "_long.stl")); 
	}
}

// ===== parts/vitamins/electromechanic/switch_*.* =====================================================================

/**
 * Provides a pre-rendered SS-5GL end switch.
 * The switch is aligned to the YZ plane with the X axis going straight through the screw hole at the far end of the 
 * lever.
 */
module switch_ss5gl() {
	bom_entry(section = "Electronic Components", description = "End Switch", size = "SS-5GL");
	color_switch()
		translate([switch_ss5gl_thickness()/2, 0, 0])
			rotate([270, 0, 270])
				import(file = "electromechanic/switch_ss5gl.stl"); 
}

// ===== parts/vitamins/mechanic/bearing_*.* ===========================================================================

/**
 * Provides the pre-rendered ball bearings.
 * The bearing is centered along the X axis with the thread extending into positive X.
 */
module bearing(size, prefix = "", suffix = "") {
	bom_entry(section = "Bearings and Wheels", description = "Ball Bearing", size = str(prefix, size, suffix));
	color_gears()
		import(file = str("mechanic/bearing_", size, ".stl")); 
}

// ===== parts/vitamins/mechanic/gt2_*.* ===============================================================================

/**
 * Creates an approximation of a GT2 pulley with 20 teeth and a 5mm bore. The pulley is oriented with the bore 
 * centered on the Y/Z origin pointing towards positive X.
 */
module gt2_pulley_20t_5mm() {
	bom_entry(section = "Timing Belts and Pulleys", description = "GT2 Pulley", size = "20 Teeth x 5 mm Bore");
	color_gears()
		import(file = "mechanic/gt2_pulley_20t_5mm.stl"); 
}


/**
 * Creates an approximation of a GT2 belt loop of the given length. The loop is designed to fit around a 20-teeth 
 * pulley or an idler created using two of the F623ZZ bearings back-to-back (see below). Note that this belt smulation
 * does not provide teeth, but rather creates a solid belt that is as thick as the real belt including teeth would be.
 * This means that it will overlap with the pulley (which does not have grooves for the teeth either).
 * The length provided as an argument is actually the distance between the centers of the two end curves.
 * The belt is oriented as a loop around Z with end1 being centered on the Z axis at the X/Y origin.
 */
module gt2_belt_loop(length, inner_diameter_end1, inner_diameter_end2) {
	// the length is only an approximation!
	_length = 2 * length + PI * inner_diameter_end1 + PI * inner_diameter_end2;
	bom_entry(section = "Timing Belts and Pulleys", description = "GT2 Belt", size = str("approx. ", _length, " mm"));
	color_belt()
		linear_extrude(height = gt2_belt_width()) {
			// create end 1
			_outer_diameter_end1 = inner_diameter_end1 + gt2_belt_thickness_max();
			difference() {
				circle(d = _outer_diameter_end1);
				circle(d = inner_diameter_end1);
				translate([0, -_outer_diameter_end1/2, 0])
					square([_outer_diameter_end1, _outer_diameter_end1]);
			}
			// create end 2			
			_outer_diameter_end2 = inner_diameter_end2 + gt2_belt_thickness_max();
			translate([length, 0, 0])
				difference() {
					circle(d = _outer_diameter_end2);
					circle(d = inner_diameter_end2);
					translate([-_outer_diameter_end2, -_outer_diameter_end2/2, 0])
						square([_outer_diameter_end2, _outer_diameter_end2]);
				}
			// connect end 1 and end 2 using two polygons
			polygon(points = [
				[ 0, inner_diameter_end1/2],
				[ 0, _outer_diameter_end1/2],
				[ length, _outer_diameter_end2/2],
				[ length, inner_diameter_end2/2]
			  ]);
			polygon(points = [
				[ 0, -inner_diameter_end1/2],
				[ 0, -_outer_diameter_end1/2],
				[ length, -_outer_diameter_end2/2],
				[ length, -inner_diameter_end2/2]
			  ]);
		}
}

// ===== parts/vitamins/mechanic/insert_*.* ============================================================================

/**
 * Provides the pre-rendered threaded insert.
 * The insert is centered along the X axis with the body extending into positive X.
 */
module insert(size, length) {
	_size = (size == M3) ? 3 : -1;
	if (_size < 0) {
		echo(str("ERROR: Unknown threaded insert size '", size, "'."));
	} else {
		_length = (length == 7) ? 7 : -1;
		if (_size < 0) {
			echo(str("ERROR: Unknown threaded insert length '", length, "'."));
		} else {
			bom_entry(section = "General Hardware", 
				description = "Threaded Insert", 
				size = str("M", _size, " x ", _length, " mm"));
			color_hardware()
				import(file = str("mechanic/insert_M", _size, "x", _length, ".stl")); 
		}
	}
}

// ===== parts/vitamins/mechanic/nut_*.* ===============================================================================

/**
 * Provides the pre-rendered nuts.
 * The nut is centered along the X axis with the thread extending into positive X.
 */
module nut(size) {
	_size = (size == M3) ? 3 :
	        (size == M4) ? 4 :
	        (size == M5) ? 5 : -1;
	if (_size < 0) {
		echo(str("ERROR: Unknown nut size '", size, "'."));
	} else {
		bom_entry(section = "General Hardware", 
			description = "Hex Nut (DIN 934 / ISO 4032)", 
			size = str("M", _size));
		color_hardware()
			import(file = str("mechanic/nut_M", _size, ".stl")); 
	}
}

/**
 * Provides a pre-rendered nut shaped used to form a recess.
 * The nut is centered along the X axis with the thread extending into positive X.
 * This is similar to nut(size), the only difference being that the nut will not be colored and counted in the BOM.
 */
module nut_recess(size) {
	_size = (size == M3) ? 3 :
	        (size == M4) ? 4 :
	        (size == M5) ? 5 : -1;
	if (_size < 0) {
		echo(str("ERROR: Unknown nut size '", size, "'."));
	} else {
		color_punch()
			import(file = str("mechanic/nut_M", _size, ".stl")); 
	}
}

/**
 * Provides a pre-rendered T-slot nut.
 * Well, actually it doesn't. We can live without it since in most cases the nut will be hidden by some
 * frame part. What this module does, however, is create a 
 */
module nut_tslot(size) {
	_size = (size == M3) ? 3 :
	        (size == M4) ? 4 :
	        (size == M5) ? 5 : -1;
	if (_size < 0) {
		echo(str("ERROR: Unknown nut size '", size, "'."));
	} else {
		bom_entry(section = "General Hardware", 
			description = "T-Slot Nut", 
			size = str("M", _size));
	}
}

// ===== parts/vitamins/mechanic/screw_*.* =============================================================================

/**
 * Provides the pre-rendered screws.
 * The screw is centered along the X axis with the thread extending into positive X.
 */
module screw(size, length = -1, min_length = -1, max_length = -1) {
	_size = (size == M3) ? 3 :
	        (size == M4) ? 4 :
	        (size == M5) ? 5 : -1;
	if (_size < 0) {
		echo(str("ERROR: Unknown screw size '", size, "'."));
	} else {
		if (length > 0 && min_length < 0 && max_length < 0) {
			_screw_exact_length(size = _size, length = length);
		} else if (length < 0 && min_length > 0 && max_length < 0) {
			_screw_min_length(size = _size, min_length = min_length);
		} else if (length < 0 && min_length > 0 && max_length > 0) {
			_screw_ranged_length(size = _size, min_length = min_length, max_length = max_length);
		} else {
			echo("ERROR: Unsupported screw length parameter combination:");			
			echo(length = length, min_length = min_length, max_length = max_length);
		}
	}	
}

module _screw_exact_length(size, length) {
	_length = select_next_screw_length(size = size, min_length = length);
	if ((_length < 0) || (_length != length)) {
		echo(str("ERROR: Unsupported screw length '", length, "' for M", size, " screws."));
	} else {
		_screw(size = size, length = _length);
	}
}

module _screw_min_length(size, min_length) {
	_length = select_next_screw_length(size = size, min_length = min_length);
	if (_length < 0) {
		echo(str("ERROR: Unsupported minimal screw length '", min_length, "' for M", size, " screws."));
	} else {
		_screw(size = size, length = _length);
	}
}

module _screw_ranged_length(size, min_length, max_length) {
	_length = select_next_screw_length(size = size, min_length = min_length);
	if (_length < 0) {
		echo(str("ERROR: Unsupported minimal screw length '", min_length, "' for M", size, " screws."));
	} else if (_length > max_length) {
		echo(str("ERROR: Unsupported screw length range ['", min_length, "':'", max_length, "'] for M", size, " screws."));
	} else {
		_screw(size = size, length = _length);
	}
}

module _screw(size, length) {
	bom_entry(section = "General Hardware", 
		description = "Hex Socket Head Cap Screw (DIN 912 / ISO 4762)", 
		size = str("M", size, " x ", length, " mm"));
	color_hardware()
		import(file = str("mechanic/screw_M", size, "x", length, ".stl")); 
}

// ===== parts/vitamins/mechanic/vwheel_*.* ============================================================================

/**
 * Provides a pre-rendered V-Wheel used on the MakerSlide Rails.
 * The wheel is centered along the X axis with the body extending into positive X.
 * Optionally, the matching ball bearings can be inserted as well. Note that in this case, one of the bearings
 * will reach into negative X space!
 */
module vslot_wheel(include_bearings = true) {
	bom_entry(section = "Bearings and Wheels", description = "V-Wheel for MakerSlide", size = "");
	color_vwheels()
		import(file = "mechanic/vwheel_dbl_bearing.stl"); 
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
		import(file = "mechanic/vwheel_spacer.stl"); 
}

// ===== parts/vitamins/mechanic/washer_*.* ============================================================================

/**
 * Provides the pre-rendered washers.
 * The washer is centered along the X axis with the body extending into positive X.
 */
module washer(size) {
	_size = (size == M3) ? 3 :
	        (size == M4) ? 4 :
	        (size == M5) ? 5 : -1;
	if (_size < 0) {
		echo(str("ERROR: Unknown washer size '", size, "'."));
	} else {
		bom_entry(section = "General Hardware", 
			description = "Washer (DIN 125A / ISO 7089)", 
			size = str("M", _size));
		color_hardware()
			import(file = str("mechanic/washer_M", _size, ".stl")); 
	}
}
module washer_large(size) {
	_size = (size == M3) ? 3 :
	        (size == M4) ? 4 :
	        (size == M5) ? 5 : -1;
	if (_size < 0) {
		echo(str("ERROR: Unknown washer size '", size, "'."));
	} else {
		bom_entry(section = "General Hardware", 
			description = "Large Washer (DIN 9021 / ISO 7093)", 
			size = str("M", _size));
		color_hardware()
			import(file = str("mechanic/washer_large_M", _size, ".stl")); 
	}
}
