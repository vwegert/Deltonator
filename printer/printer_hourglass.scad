/**********************************************************************************************************************
 **
 ** printer/printer_hourglass.scad
 **
 ** This file produces an animated version of the printer that prints a three-dimensional hourglass-like shape.
 **
 **********************************************************************************************************************/

use <printer.scad>

OUTER_RADIUS      = 120;
INNER_RADIUS      =  25;
HEIGHT            = 300;
TURNS_PER_SECTION =   4;

// Set the camera position and orientation.
$vpr = [ 55, 0, 100 ];
$vpt = [ 2000, 200, 1800 ];

animation_position = $t;

// Determine the current print head position and render the model.
current_position = (animation_position < 0.25) ? base_spiral_position() :
                   (animation_position < 0.50) ? lower_cone_position() :
                   (animation_position < 0.75) ? upper_cone_position() :
                                 top_spiral_position();
printer_model(head_position = current_position);

// Render the shape the printer is supposedly printing.
translate([0, 0, bed_working_height()]) {
	// the lower circle / spiral
	if (animation_position < 0.25) {
		color("LimeGreen") 
			circle(r = outward_spiral_radius());
	} else {
		color("Green") 
			circle(r = OUTER_RADIUS);
		// the lower cone
		if (animation_position < 0.50) {
			color("LimeGreen") 
				rotate_extrude($fn = 120) {
					polygon(points = [
							[0, 0],
							[0, lower_cone_height()],
							[inward_spiral_radius(), lower_cone_height()],
							[OUTER_RADIUS, 0]
						]);
				}
		} else {
			color("Green") 
				rotate_extrude($fn = 120) {
					polygon(points = [
							[0, 0],
							[0, HEIGHT/2],
							[INNER_RADIUS, HEIGHT/2],
							[OUTER_RADIUS, 0]
						]);
				}
			// the upper cone
			if (animation_position < 0.75) {
				color("LimeGreen") 
					rotate_extrude($fn = 120) {
						polygon(points = [
								[0, HEIGHT/2],
								[0, upper_cone_height()],
								[outward_spiral_radius(), upper_cone_height()],
								[INNER_RADIUS, HEIGHT/2]
							]);
					}
			} else {
				color("Green") 
					rotate_extrude($fn = 120) {
						polygon(points = [
								[0, HEIGHT/2],
								[0, HEIGHT],
								[OUTER_RADIUS, HEIGHT],
								[INNER_RADIUS, HEIGHT/2]
							]);
					}
				// the upper circle / spiral
				if (animation_position < 1.00) {
					color("LimeGreen") 
						translate([0, 0, HEIGHT]) 
							difference() {
								circle(r = OUTER_RADIUS);
								circle(r = inward_spiral_radius());
							}
				} else {
					color("Green") 
						translate([0, 0, HEIGHT]) 
							circle(r = OUTER_RADIUS);
				}
			}
		}
	}
}

// Print the current angle and position for debugging purposes.
echo(current_angle = current_angle());
echo(current_position = current_position);
echo(outward_spiral_radius = outward_spiral_radius());

// ===== auxiliary functions ==========================================================================================

/**
 * Determines the position of the print head while it is printing the bottom spiral.
 */
function base_spiral_position() = 
  [
    cos(current_angle()) * outward_spiral_radius(), 
    sin(current_angle()) * outward_spiral_radius(), 
    0
  ];

/**
 * Determines the position of the print head while it is printing the lower cone.
 */
function lower_cone_position() = 
  [
    cos(current_angle()) * inward_spiral_radius(), 
    sin(current_angle()) * inward_spiral_radius(), 
    lower_cone_height()
  ];

/**
 * Determines the position of the print head while it is printing the upper cone
 */
function upper_cone_position() = 
  [
    cos(current_angle()) * outward_spiral_radius(), 
    sin(current_angle()) * outward_spiral_radius(), 
    upper_cone_height()
  ];

/**
 * Determines the position of the print head while it is printing the upper spiral.
 */
function top_spiral_position() = 
  [
    cos(current_angle()) * inward_spiral_radius(), 
    sin(current_angle()) * inward_spiral_radius(), 
    HEIGHT
  ];

/**
 * Determines the current angle (phi) of the print head in relation to the center of the build plate.
 */
function current_angle() = (((animation_position * 4) % 1) * 360 * TURNS_PER_SECTION) % 360;

/** 
 * Determines the radius of the spirals.
 */
function outward_spiral_radius() = INNER_RADIUS + ((animation_position * 4) % 1) * (OUTER_RADIUS - INNER_RADIUS);
function inward_spiral_radius() = OUTER_RADIUS - ((animation_position * 4) % 1) * (OUTER_RADIUS - INNER_RADIUS);

/**
 * Determines the height of the print head when printing the cones.
 */
function lower_cone_height() = ((animation_position * 4) % 1) * HEIGHT/2;
function upper_cone_height() = (1 + ((animation_position * 4) % 1)) * HEIGHT/2;