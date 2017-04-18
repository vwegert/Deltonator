/**********************************************************************************************************************
 **
 ** printer/printer_default.scad
 **
 ** This file constructs the default version of the entire printer - mainly for cross-checking and illustration
 ** purposes.
 **
 **********************************************************************************************************************/

use <printer.scad>

printer_model(head_position = [build_area_max_radius(), 0, 0]);
