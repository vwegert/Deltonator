/**********************************************************************************************************************
 **
 ** parts/vitamins/electronic/power_supply.scad
 **
 ** This file renders a power supply case placeholder.
 **
 **********************************************************************************************************************/

include <../../../conf/part_sizes.scad>

$fn = 48;

// Convention: the "front" side is the one aligned to the Y axis (front if primary is left, secondary right).

color("LightGray")
	cube([ps_length(), ps_width(), ps_height()]);
