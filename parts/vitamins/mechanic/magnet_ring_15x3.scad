/**********************************************************************************************************************
 **
 ** parts/vitamins/magnet_ring_15x3.scad
 **
 ** This file renders a beveled ring magnet of the dimensions specified by the file name
 **
 **********************************************************************************************************************/

// for dimensions see https://www.mtsmagnete.de/magnetsysteme/mit-bohrung-und-senkung/neodym-scheibenmagnet-mit-bohrung-und-senkung-15x3mm-3-5mm-bohrung-n45/a-3807/

D = 15;      // outer diameter
H = 3;       // height
d1 = 3.5;    // bore
d2 = 7;      // bevel diameter

// calculate bevel depth
bd = sin(45) * (d2 - d1);

$fn = 96;
rotate([0, 90, 0]) 
	rotate_extrude()
		rotate([0, 0, 90])
		  	polygon(points = [
				[ 0, d1/2],
				[ 0, D/2],
				[ H, D/2],
				[ H, d2/2],
				[ H - bd, d1/2]
			]);