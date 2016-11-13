/**********************************************************************************************************************
 **
 ** parts/extrusions/makerslide_rail.scad
 **
 ** This file s used to render the actual rail into an STL file for faster access. 
 ** This file is NOT intended to be included by any other file.
 **
 **********************************************************************************************************************/

include <../../conf/colors.scad>
include <../../conf/derived_sizes.scad>
include <../../conf/part_sizes.scad>

// pre-render the main MakerSlide rails into an STL file for later use
linear_extrude(height = vertical_extrusion_length(), center = false, convexity = 10)
	import(file = "makerslide_extrusion_profile.dxf"); 
