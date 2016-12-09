# CAUTION - WORK IN PROGRESS

If you happen to read this, beware - this has not been validated or tried out yet. So far, it is only a theoretical model.

# The Deltonator

You might also call it YAFDP - yet another f-word delta printer. It's a machine based on the linear delta kinematic
system like the famous [Rostock](http://reprap.org/wiki/Rostock) or [Kossel](http://reprap.org/wiki/Kossel). 

<a href="http://www.youtube.com/watch?feature=player_embedded&v=K8tiYmS-2c0" target="_blank"><img src="http://img.youtube.com/vi/K8tiYmS-2c0/0.jpg" alt="Deltonator Movement Simulation" width="560" height="315" border="10" /></a>

## Design Goals

When  setting out to build my own delta printer, I didn't find exactly what I was looking for, so - like many other 
people, many of which have considerable more experience than I have - I decided to design my own version, with the 
following design goals in mind:

 * Use the [MakerSlide](https://www.inventables.com/technologies/makerslide) system with V-shaped wheels for the 
   vertical axes.
 * Use a magnetic bearing system somewhat similar to the one designed by [Bert Broeren](http://www.thingiverse.com/thing:1239984), 
   that is, the magnets do not have to hold the weight of the effector.
 * Keep the effectors easily exchangeable to support different tool heads - various 3D printing heads, maybe a small 
   motor for PCB milling or a laser engraving module at some time.
 * Create an enclosed build volumes - for stable printing conditions, to prevent chips from flying all over the place 
   when milling and to contain the fumes when laser engraving.
 * Create a parametric design to be able to determine (and change) the sizes of key parts later on.
 * Keep the entire design open source, and use FOSS wherever possible.

At the current stage, the plans are incomplete and unproven, and any input is welcome. 

## OpenSCAD coding conventions

* global constants in UPPERCASE
* modules and functions lower_case_with_underscores
* things that are intended to be kept local begin with an _underscore