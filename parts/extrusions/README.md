# Extrusions

This directory contains the files that are necessary to preoduce the extruded parts that are used for the printer frame.

## MakerSlide profile

### own source files

* makerslide.scad contains some general functions that provide the dimensions of the profile as well as the modules used to import the rendered rails. This file is intended to be included by other files down the line.
* makerslide_rail.scad is used to render the actual rail into an STL file for faster access. This file is NOT intended to be included by any other file than makerslide.scad.

### files imported from external sources

Files:
* makerslide_b17022.dxf
* makerslide_b17022_rev_2.pdf

These files were downloaded from [this repository](https://workbench.grabcad.com/workbench/projects/gcq_crZz-TsvjDvMKhmbtlfzNRmpeNJLO8d-8o69N-S1JA#/space/gcLV1u0JdB_BCzLoKQ8lEfABd8UGdoqlcWfQ0PfJajjy2E/link/490685), which in turn was linked from [the Inventables site](https://www.inventables.com/technologies/makerslide). As far as I can tell from the PDF file, these files have been licensed under a CC-BY-SA-3.0 license, but I have not been able to determine the actual author. Please contact me if you have details.

Files: 
* makerslide_extrusion_profile.dxf

Since the original extrusion profile was using non-standard dimensions and contained a considerable offset, I'm actually using a version by [mesheldrake](http://www.thingiverse.com/mesheldrake) downloaded from [Thingiverse](http://www.thingiverse.com/thing:8992). This file has been placed under a CC-BY-SA-3.0 license as well.
