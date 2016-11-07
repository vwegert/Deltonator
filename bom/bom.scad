/**********************************************************************************************************************
 **
 ** bom/bom.scad
 **
 ** This file provides the functions to generate a basic bill of materials (BOM) from the model.
 **
 **********************************************************************************************************************/

/**
 * A recursive function to format the parent module hierarchy as a series of delimited sub-strings.
 * Example: "vertical_axis_assembly>_vertical_axis_assembly>makerslide_vertical_rail"
 */
function _bom_parent_list(level, delimiter = ">") = 
	(level < $parent_modules - 1) ? str(_bom_parent_list(level = level + 1), delimiter, parent_module(level)) : "";

module bom_entry(section = "", description = "", size = "", number = 1) {
	// Only perform any actions if WRITE_BOM is set. This is done through the command line - see Makefile.
	if (WRITE_BOM) {
		echo(str("BOM;", section, ";", description, ";", size, ";", number, ";", _bom_parent_list(level = 2)));
	}
}