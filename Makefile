###################################################################################################
##
## Deltonator main Makefile - magic starts here...
##
###################################################################################################

#
# phony target definitions (targets that are no files)
#
.PHONY: all clean assemblies printer video video-frames video-file vitamins bom bom-clean sizes sizes-clean

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
all: extrusions sheets vitamins printed bom sizes # assemblies printer

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
	$(RM) parts/vitamins/electromechanic/*.deps
	$(RM) parts/vitamins/electronic/*.deps
	$(RM) parts/vitamins/mechanic/*.deps
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
include $(wildcard parts/extrusions/*.deps)
include $(wildcard parts/printed/*.deps)
include $(wildcard parts/sheets/*.deps)
include $(wildcard parts/vitamins/electromechanic/*.deps)
include $(wildcard parts/vitamins/electronic/*.deps)
include $(wildcard parts/vitamins/mechanic/*.deps)
include $(wildcard assemblies/*.deps)
include $(wildcard printer/*.deps)

#
# Rule to build the printer model.
#
printer: assemblies \
	printer/printer_default.stl

#
# Rule to build the assemblies
#
assemblies: extrusions sheets vitamins printed \
	assemblies/vertical_axis.stl \
	assemblies/horizontal_front.stl \
	assemblies/horizontal_left.stl \
	assemblies/horizontal_right.stl

#
# Rule to build the printed parts
#
printed: vitamins \
	parts/printed/bed_bracket.stl \
	parts/printed/carriage.stl \
	parts/printed/carriage_ball_holder.stl \
	parts/printed/effector_base.stl \
	parts/printed/end_switch_bracket.stl \
	parts/printed/foot_rail.stl \
	parts/printed/foot_norail.stl \
	parts/printed/head.stl \
	parts/printed/magnet_holder_carriage.stl \
	parts/printed/magnet_holder_effector.stl \
	parts/printed/motor_bracket.stl \
	parts/printed/tensioner.stl

#
# Rule to build the extruded parts
#
extrusions: \
	parts/extrusions/makerslide_rail.stl \
	parts/extrusions/vslot_2020_side.stl

#
# Rule to build the parts fabricated out of sheet material
#
sheets: \
	parts/sheets/bed.stl \
	parts/sheets/enclosure_short_side.stl 

#
# Rules to buld the parts provided by the external libraries
#
vitamins: \
	parts/vitamins/electromechanic/stepper_nema14_long.stl \
	parts/vitamins/electromechanic/stepper_nema14_medium.stl \
	parts/vitamins/electromechanic/stepper_nema14_short.stl \
	parts/vitamins/electromechanic/stepper_nema17_long.stl \
	parts/vitamins/electromechanic/stepper_nema17_medium.stl \
	parts/vitamins/electromechanic/stepper_nema17_short.stl \
	parts/vitamins/electromechanic/stepper_nema23_long.stl \
	parts/vitamins/electromechanic/stepper_nema23_medium.stl \
	parts/vitamins/electromechanic/stepper_nema23_short.stl \
	parts/vitamins/mechanic/ball.stl \
	parts/vitamins/mechanic/bearing_f623.stl \
	parts/vitamins/mechanic/bearing_625.stl \
	parts/vitamins/mechanic/gt2_pulley_20t_5mm.stl \
	parts/vitamins/mechanic/insert_M3x7.stl \
	parts/vitamins/mechanic/magnet_ring.stl \
	parts/vitamins/mechanic/nut_M2.stl \
	parts/vitamins/mechanic/nut_M3.stl \
	parts/vitamins/mechanic/nut_M4.stl \
	parts/vitamins/mechanic/nut_M5.stl \
	parts/vitamins/mechanic/rail_bracket.stl \
	parts/vitamins/mechanic/rod.stl \
	parts/vitamins/mechanic/screw_M2x10.stl \
	parts/vitamins/mechanic/screw_M3x6.stl \
	parts/vitamins/mechanic/screw_M3x8.stl \
	parts/vitamins/mechanic/screw_M3x10.stl \
	parts/vitamins/mechanic/screw_M3x12.stl \
	parts/vitamins/mechanic/screw_M3x16.stl \
	parts/vitamins/mechanic/screw_M3x20.stl \
	parts/vitamins/mechanic/screw_M3x30.stl \
	parts/vitamins/mechanic/screw_M4x8.stl \
	parts/vitamins/mechanic/screw_M4x10.stl \
	parts/vitamins/mechanic/screw_M4x12.stl \
	parts/vitamins/mechanic/screw_M4x16.stl \
	parts/vitamins/mechanic/screw_M4x20.stl \
	parts/vitamins/mechanic/screw_M4x25.stl \
	parts/vitamins/mechanic/screw_M4x30.stl \
	parts/vitamins/mechanic/screw_M4x35.stl \
	parts/vitamins/mechanic/screw_M4x45.stl \
	parts/vitamins/mechanic/screw_M4x55.stl \
	parts/vitamins/mechanic/screw_M5x8.stl \
	parts/vitamins/mechanic/screw_M5x10.stl \
	parts/vitamins/mechanic/screw_M5x12.stl \
	parts/vitamins/mechanic/screw_M5x16.stl \
	parts/vitamins/mechanic/screw_M5x20.stl \
	parts/vitamins/mechanic/screw_M5x25.stl \
	parts/vitamins/mechanic/screw_M5x30.stl \
	parts/vitamins/mechanic/screw_M5x35.stl \
	parts/vitamins/mechanic/screw_M5x40.stl \
	parts/vitamins/mechanic/screw_M5x45.stl \
	parts/vitamins/mechanic/screw_M5x55.stl \
	parts/vitamins/mechanic/screw_M5x65.stl \
	parts/vitamins/mechanic/spring_5x20.stl \
	parts/vitamins/mechanic/vwheel_dbl_bearing.stl \
	parts/vitamins/mechanic/vwheel_spacer.stl \
	parts/vitamins/mechanic/washer_M3.stl \
	parts/vitamins/mechanic/washer_M4.stl \
	parts/vitamins/mechanic/washer_M5.stl \
	parts/vitamins/mechanic/washer_large_M3.stl \
	parts/vitamins/mechanic/washer_large_M4.stl \
	parts/vitamins/mechanic/washer_large_M5.stl

#
# Rules to assemble the BOM
#
bom: printed bom-clean bom/bom.txt 

bom/bom_raw_data.echo: printer/printer_default.scad bom/bom.scad
	$(OPENSCAD) -m make -o $@ -D WRITE_BOM=true printer/printer_default.scad 

bom/bom.txt: bom/bom_raw_data.echo bom/make_bom.pl 
	$(PERL) bom/make_bom.pl < $< > $@

bom-clean:
	$(RM) bom/bom.txt bom/bom_raw_data.echo

#
# Rules to generate the sizes table
#
sizes: sizes-clean tools/sizes/dump_sizes.echo

sizes-clean:
	$(RM) tools/sizes/dump_sizes.echo

tools/sizes/dump_sizes.scad: tools/sizes/generate_sizes_scad.pl \
	                         conf/printer_config.scad \
	                         conf/part_sizes.scad \
	                         conf/derived_sizes.scad
	$(PERL) tools/sizes/generate_sizes_scad.pl > $@

tools/sizes/dump_sizes.echo: tools/sizes/dump_sizes.scad
	$(OPENSCAD) -m make -o $@ -D WRITE_BOM=false $<

#
# Rules to render the video.
#
video: video-frames video-file

video-frames: printed vitamins extrusions 
	$(RM) video/frame*.png
	frames=1200 ; frame=1 ; while [[ $$frame -le $$frames ]] ; do \
		echo Rendering frame $$frame of $$frames ; \
		printf -v imgfile 'frame%05d.png' $$frame ; \
		$(OPENSCAD) -o video/$$imgfile --imgsize=2000,2000 -D WRITE_BOM=false -D animation_position=$$frame/$$frames printer/printer_hourglass.scad ; \
		((frame = frame + 1)) ; \
	done

video-file:
	$(RM) video/printer_hourglass.mp4
	$(FFMPEG) -r 25 -s 2000x2000 -i video/frame%05d.png -vcodec libx264 -crf 25  -pix_fmt yuv420p video/printer_hourglass.mp4

# 
# Rules to fetch external libraries.
#
lib/nutsnbolts/cyl_head_bolt.scad: 
	$(GIT) submodule init
	$(GIT) submodule update

lib/MCAD/stepper.scad: 
	$(GIT) submodule init
	$(GIT) submodule update

