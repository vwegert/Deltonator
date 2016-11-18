/**********************************************************************************************************************
 **
 ** parts/vitamins/bearing_f623.scad
 **
 ** This file renders a ball bearing of the size specified by the file name.
 **
 **********************************************************************************************************************/

// The MCAD library does not (yet) provide flanged bearings, so...
// The dimensions were taken from https://www.makeralot.com/images/bearings/F623ZZ-S.jpg.

$fn = 96;
rotate([0, 90, 0]) 
 		rotate_extrude($fn = bearing_resolution())
		rotate([0, 0, 90])
		  	polygon(points = [
				[ 0.00, 1.50],
				[ 0.00, 5.75],
				[ 1.00, 5.75],
				[ 1.00, 5.00],
				[ 4.00, 5.00],
				[ 4.00, 1.50]
			]);