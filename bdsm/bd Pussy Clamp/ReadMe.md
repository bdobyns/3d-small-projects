## Overview of /bd-Pussy-Clamp

This is a remix of several designs that came from Cult3d where I felt like the inner radius of the outer sides of the large clamp was simply wrong.

**nut.stl** and **bolt.stl** 
are the original nut and bolt to hold the parts together.  The bolt is a 4" long imperial 1/4-28 bolt, and can take imperial 1/4-28 nuts.  You could also use metal 1/4-28 hardware, or metric M8 hardware.  

These are particularly tricky to print, and I don't know why they used 1/4-28 instead of 1/4-20 which is a coarser thread and would print better.  Even so, it can be done, and both the nut and the bolt are much better after being threaded with piece a few times.   If you can find an especially hardened metal nut or screw, that's even better. 

**Large Pussy Clamp.scad** contains the redesigned sides for the large one.  The center hole here is a full circle.  There's actually two versions of a design for this in the directory. This one has outer sides that is flush with the inner piece when closed, and is a full redesign, including both the main radius and the ears.  

**Large-Pussy-Clamp-v2.scad** The other is redesigned with just the full radius, but the ears are taken from the old one, and amount to a standoff so you can't get the flesh clamped in there too tight.  The originals had a letter embossed in the surface, but the letters never made any sense to me and made it hard to print, so that's now removed.

**narrow Pussy Clamp.scad** contains the unmodified sides and clamps from the original, but the txt has been removed.

**Medium Pussy Clamp** gcode is just the narrow one scaled up by 150% in the Y direction.   if you scale it 200% in the Y direction, then the center hole becomes a circle the same size as Large Pussy Clamp. 


## Printing tips

I've tried to print these all together in one big print but that is sometimes very tricky.  
So its better to print one piece at a time. especially troublesome.

The surfaces that touch the flesh you're clamping need less cleanup if you print flat. You need supports whether you print flat on it's side, or standing up (the 'normal' orientation in the original STL files).  

Good results with [Creality White PLA][crealitywhite], [Meperper Blue PLA][meperperblue], [3d Solutech PLA][3dsolutech]

Terrible results with [NovaMaker pink PLA][novamakerpink]

[crealitywhite]: https://www.amazon.com/dp/B08CL2D3Y8/
[meperperblue]: https://www.amazon.com/gp/product/B085K15P44/
[3dsolutech]: https://www.amazon.com/gp/product/B00MF03LAE/
[novamakerpink]: https://www.amazon.com/gp/product/B071G5QBRK/

parameters | value
-------| -----------
material | PLA
Hot End | 200 C
Bed | 60 C
Speed | 50mm/sec
infill | 50% to 80% 
brim | yes 
support | yes
nozzle | 0.4mm
layer height | 0.2mm

## SCAD Fles
file | description
-----|----
**Large Pussy Clamp.scad** | my first attempt at replacement sides. sides fully scratch designed. fits flush against the side of the body piece with no enforced gap. imports **large body.stl**. | 
**Large-Pussy-Clamp-v2.scad** | second attempt at replacement sides. same arc as v1. but reused the ears from the original. which include a standoff. removed the embossed text. imports **large body.stl** and **large side.stl**  | 
**narrow Pussy Clamp.scad** | both the sides and body are original. but removed all the embossed text. this has a acceptable curve and standoffs in the ears. Can be scaled 150% Y to get a slightly wider center hole. imports **narrow body.stl** and **narrow\_side.stl**  | 
**cubeX.scad** | a library for rounded boxes |  
**cubeX-test.scad** | a test for the cubeX lib | 

## Ready-To-Print GCODE files 

gcode file | description | orient | brim | supports | infill | slicer
------|------|--------|-----|----|----|---
**6SE\_4\_bolt flat.gcode** | all four of the bolts | flat | no | supports | 80% | Cura 4.8.0
**6SE\_large body flat.gcode** | the large body, with the text still | flat | no | supports | 80% | Cura 4.8.0
**6SE\_narrow body flat.gcode** | narrow body | flat | no | supports | 80% |Cura 4.8.0
**6SE\_narrow\_side flat.gcode** | narrow side 1 pc | flat | no | supports | 80% |Cura 4.8.0
**CE3\_large body flat.gcode** | large body | flat | brim | supports | 80% |Cura 4.7.1
**CE3\_narrow body flat.gcode** | narrow body | flat | brim | supports | 80% |Cura 4.7.1
**CE3\_narrow\_side flat.gcode** | narrow side 1 pc | flat | brim | supports | 80% |Cura 4.7.1
**Large Pussy Clamp All\_0.2mm\_50%\_PLA\_ENDER3\_4h4m.gcode** | large body, side 2 pc, no text | flat | brim | supports | 50% |Prusa 2.2
**Medium Pussy Clamp all\_0.2mm\_50%\_PLA\_ENDER3\_4h27m.gcode** | medium body, side 2 pc, no text, narrow at 150% Y | flat | brim | supports | 50% | Prusa 2.2
**narrow Pussy Clamp all\_0.2mm\_50%\_PLA\_ENDER3\_3h21m.gcode** | narrow body, side 2 pc, no text | flat | brim | supports | 50% | Prusa 2.2


## STL Files
File Name | description | origin | place
----|----|----|---
**Large Pussy Clamp all.stl** | large body, sides 2 pc | **Large Pussy Clamp.scad** | scad
**narrow Pussy Clamp all.stl** | narrow body, sides 2 pc | **narrow Pussy Clamp.scad** | scad
**narrow sides Pussy Clamp.stl** | sides 2 pc | **narrow Pussy Clamp.scad** | scad
**bolt.stl** | one bolt | pussy-clamp-wide-thecuddlesdom | cult3d
**large body.stl** | large body | pussy-clamp-wide-thecuddlesdom | cult3d
**large side.stl** | large side | pussy-clamp-wide-thecuddlesdom | cult3d
**narrow body.stl** | narrow body | pussy-clamp-narrow | cult3d
**narrow_side.stl** | narrow side | pussy-clamp-narrow | cult3d
**nut.stl** | one knurled nut | pussy-clamp-wide-thecuddlesdom | cult3d




