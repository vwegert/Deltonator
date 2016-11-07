/**********************************************************************************************************************
 **
 ** lib/MCAD/MCAD.scad
 **
 ** This file provides access to the pre-rendered parts of the MCAD library.
 **
 **********************************************************************************************************************/

use <../../bom/bom.scad>
use <../../conf/colors.scad>

/**
 * Provides the pre-rendered stepper motors.
 * The motor is centered along the X axis with the shaft extending into positive X.
 */
module stepper_short(size = 17) {
	bom_entry(description = "Stepper Motor", size = str("NEMA ", size, " short"));
	color_motor()
		import(file = str("stepper_nema", size, "_short.stl")); 
}
module stepper_medium(size = 17) {
	bom_entry(description = "Stepper Motor", size = str("NEMA ", size, " medium"));
	color_motor()
		import(file = str("stepper_nema", size, "_medium.stl")); 
}
module stepper_long(size = 17) {
	bom_entry(description = "Stepper Motor", size = str("NEMA ", size, " long"));
	color_motor()
		import(file = str("stepper_nema", size, "_long.stl")); 
}

