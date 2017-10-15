/**********************************************************************************************************************
 **
 ** parts/vitamins/electronic/power_supply.scad
 **
 ** This file renders a power supply case placeholder.
 **
 **********************************************************************************************************************/

include <../../../conf/part_sizes.scad>

$fn = 48;

color("LightGray")
	cube([ps_width(), ps_length(), ps_height()]);
