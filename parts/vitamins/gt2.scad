/**********************************************************************************************************************
 **
 ** parts/vitamins/steppers.scad
 **
 ** This file provides access to the pre-rendered steppers created with the MCAD library.
 **
 **********************************************************************************************************************/

use <../../bom/bom.scad>
use <../../conf/colors.scad>
use <../../conf/part_sizes.scad>

/**
 * Creates an approximation of a GT2 pulley with 20 teeth and a 5mm bore. The pulley is oriented with the bore 
 * centered on the Y/Z origin pointing towards positive X.
 */
module gt2_pulley_20t_5mm() {
	bom_entry(section = "Timing Belts and Pulleys", description = "GT2 Pulley", size = "20 Teeth x 5 mm Bore");
	color_gears()
		import(file = "gt2_pulley_20t_5mm.stl"); 
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
