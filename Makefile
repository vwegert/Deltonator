###################################################################################################
##
## Deltonator main Makefile - magic starts here...
##
###################################################################################################

#
# phony target definitions (targets that are no files)
#
.PHONY: all clean assemblies printer bom vitamins

#
# OS detection and inclusion of OS-specific configuration files
#
ifeq ($(OS),Windows_NT)
OS_DET := Windows
else
OS_DET := $(shell uname -s)
endif
CONFIG_FILE = conf/os_$(OS_DET).make
ifneq ("$(wildcard $(CONFIG_FILE))","")
$(info Using configuration file $(CONFIG_FILE)...)
include $(CONFIG_FILE)
else
$(error Configuration file $(CONFIG_FILE) not found)
endif

#
# default targets all and clean
#
all: assemblies printer bom # demos

clean:
	$(RM) assemblies/*.deps
	$(RM) assemblies/*.stl
	$(RM) bom/bom_raw_data.echo
	$(RM) parts/extrusions/*.deps
	$(RM) parts/extrusions/*.stl
	$(RM) parts/printed/*.deps
	$(RM) parts/printed/*.stl
# do NOT clean the STL files in the vitamins directories because not all of them are built automatically!
	$(RM) parts/vitamins/*.deps
	$(RM) printer/*.deps
	$(RM) printer/*.stl
# TODO the clean target does not work on Windows systems 

#
# file-type specific build rules
#
%.stl: %.scad 
	$(OPENSCAD) -m $(MAKE) -o $@ -d $@.deps -D WRITE_BOM=false $<

#
# Include the dependency files provided by OpenSCAD. 
#
include $(wildcard parts/vitamins/*.deps)
include $(wildcard parts/extrusions/*.deps)
include $(wildcard parts/printed/*.deps)
include $(wildcard assemblies/*.deps)
include $(wildcard printer/*.deps)

#
# Rule to build the printer model.
#
printer: printer/printer_default.stl

#
# Rule to build the assemblies
#
assemblies: \
	assemblies/vertical_axis.stl \
	assemblies/horizontal_front.stl \
	assemblies/horizontal_left.stl \
	assemblies/horizontal_right.stl

#
# Rules to buld the parts provided by the external libraries
#
vitamins: \
	parts/vitamins/bearing_625.stl \
	parts/vitamins/gt2_pulley_20t_5mm.stl \
	parts/vitamins/nut_M3.stl \
	parts/vitamins/nut_M4.stl \
	parts/vitamins/nut_M5.stl \
	parts/vitamins/screw_M3x6.stl \
	parts/vitamins/screw_M5x8.stl \
	parts/vitamins/screw_M5x12.stl \
	parts/vitamins/screw_M5x30.stl \
	parts/vitamins/screw_M5x35.stl \
	parts/vitamins/stepper_nema14_long.stl \
	parts/vitamins/stepper_nema14_medium.stl \
	parts/vitamins/stepper_nema14_short.stl \
	parts/vitamins/stepper_nema17_long.stl \
	parts/vitamins/stepper_nema17_medium.stl \
	parts/vitamins/stepper_nema17_short.stl \
	parts/vitamins/stepper_nema23_long.stl \
	parts/vitamins/stepper_nema23_medium.stl \
	parts/vitamins/stepper_nema23_short.stl \
	parts/vitamins/vwheel_dbl_bearing.stl \
	parts/vitamins/vwheel_spacer.stl \
	parts/vitamins/washer_M3.stl \
	parts/vitamins/washer_M4.stl \
	parts/vitamins/washer_M5.stl

#
# Rules to assemble the BOM
#
bom: printer/printer_default.stl bom/bom.txt

bom/bom_raw_data.echo: printer/printer_default.stl printer/printer_default.scad bom/bom.scad
	$(OPENSCAD) -m make -o $@ -D WRITE_BOM=true printer/printer_default.scad 

bom/bom.txt: bom/bom_raw_data.echo bom/make_bom.pl 
	$(PERL) bom/make_bom.pl < $< > $@

# 
# Rules to fetch external libraries.
#
lib/nutsnbolts/cyl_head_bolt.scad: 
	$(GIT) submodule init
	$(GIT) submodule update

lib/MCAD/stepper.scad: 
	$(GIT) submodule init
	$(GIT) submodule update
