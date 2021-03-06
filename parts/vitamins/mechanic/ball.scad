/**********************************************************************************************************************
 **
 ** parts/vitamins/mechanic/ball.scad
 **
 ** This file renders a steel ball used for the arm joints.
 **
 **********************************************************************************************************************/

include <../../../conf/part_sizes.scad>

$fn = 96;
sphere(d = ball_diameter());