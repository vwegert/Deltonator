/**********************************************************************************************************************
 **
 ** printer/printer_base_circle.scad
 **
 ** This file produces an animated version of the printer that "draws" a circle on the base plate.
 **
 **********************************************************************************************************************/

use <printer.scad>

CIRCLE_RADIUS      = 115;
HEIGHT             = 0;

$vpr = [ 55, 0, 100 ];
$vpt = [ 2000, 200, 1800 ];

current_angle = $t * 360;
current_x = cos(current_angle) * CIRCLE_RADIUS;
current_y = sin(current_angle) * CIRCLE_RADIUS;

echo(current_angle = current_angle);
echo(current_x = current_x);
echo(current_y = current_y);

printer_model(head_position = [current_x, current_y, HEIGHT]);

