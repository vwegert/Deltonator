/**********************************************************************************************************************
 **
 ** parts/vitamins/mechanic/magnet_ring.scad
 **
 ** This file renders a beveled ring magnet for the arm joints.
 **
 **********************************************************************************************************************/

include <../../../conf/part_sizes.scad>
include <../../../conf/derived_sizes.scad>

$fn = 96;
rotate([0, 90, 0]) 
	rotate_extrude()
		rotate([0, 0, 90])
		  	polygon(points = [
				[ 0, magnet_bore_diameter()/2],
				[ 0, magnet_outer_diameter()/2],
				[ magnet_height(), magnet_outer_diameter()/2],
				[ magnet_height(), magnet_bevel_diameter()/2],
				[ magnet_height() - magnet_bevel_depth(), magnet_bore_diameter()/2]
			]);