###################################################################################################
##
## Deltonator main Makefile - magic starts here...
##
###################################################################################################

#
# phony target definitions (targets that are no files)
#
.PHONY: all clean assemblies printer # parts demos printer

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
all: assemblies printer # demos

clean:
# do NOT clean the STL files in the parts directories because not all of them are built automatically!
	$(RM) parts/vitamins/*.deps
	$(RM) parts/extrusions/*.deps
	$(RM) parts/printed/*.deps
	$(RM) assemblies/*.deps
	$(RM) assemblies/*.stl
	$(RM) printer/*.deps
	$(RM) printer/*.stl
# 	$(RM) lib/*.deps
# 	$(RM) lib/*.dxf 
# 	$(RM) lib/*.stl
# 	$(RM) lib/prepared
# 	$(RM) parts/*.deps

#
# file-type specific build rules
#
%.stl: %.scad 
	$(OPENSCAD) -m make -o $@ -d $@.deps $<

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
assemblies: assemblies/vertical_axis.stl

# #
# # Rule to build the individual parts.
# #
# parts: parts/lower_foot.stl parts/motor_bracket.stl

# #
# # Rule to build additional demo files. These are not intended to be printed, but to double-check 
# # the individual parts.
# # 
# demos: lib/extrusions_demo.stl lib/mech_parts_demo.stl \
# 	   parts/lower_foot_demo.stl parts/motor_bracket_demo.stl

# #
# # Some preparation is required for the libraries - we need to copy in some contributed files.
# #
# lib/prepared: lib/makerslide.dxf lib/vslot-2020.dxf lib/nema17.stl
# 	touch $@

# lib/makerslide.dxf: external/MakerSlide/makerslide_extrusion_profile.dxf
# 	$(CP) $< $@

# lib/vslot-2020.dxf: external/OpenBuilds/V-slot_2020_fullscale.dxf
# 	$(CP) $< $@

# lib/nema17.stl: external/StepperMotorNema17/Stepper_Motor_5mm_Shaft_NEMA_17.stl
# 	$(CP) $< $@

