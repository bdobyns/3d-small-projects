## Overview of /bd-Pussy-Clamp

This is a remix of two designs that came from Cult3d [pussy-clamp-wide][wide] and [pussy-clamp-narrow][narrow].  It started because I felt like the inner radius of the outer side pieces of the [pussy-clamp-wide][wide] was simply wrong.

[wide]: https://cults3d.com/en/3d-model/naughties/pussy-clamp-wide-thecuddlesdom
[narrow]: https://cults3d.com/en/3d-model/naughties/pussy-clamp-narrow
[crealitywhite]: https://www.amazon.com/dp/B08CL2D3Y8/
[meperperblue]: https://www.amazon.com/gp/product/B085K15P44/
[3dsolutech]: https://www.amazon.com/gp/product/B00MF03LAE/
[novamakerpink]: https://www.amazon.com/gp/product/B071G5QBRK/
[cr6se]: https://www.creality3dofficial.com/products/creality-cr-6-se-3d-printer

## TL;DR 

param | **nut.stl** | **bolt.stl** | body | sides
----|----|----|----|----
printer | [CR-6 SE][cr6se] | [CR-6 SE][cr6se] | [CR-6 SE][cr6se] | [CR-6 SE][cr6se]
orientation | lay flat | hole vertical | lay flat | lay flat
layer height | 0.12 | 0.12 | 0.20 | 0.20
print speed | 25mm/s | 25mm/s | 50mm/s | 50mm/s
raft layers | 3 | 3 | no | no
brim | no | no | yes | yes
glue stick | yes | yes | yes | yes
supports | no | no | yes | yes
hot end | 200C | 200C | 200C | 200C


### **nut.stl** and **bolt.stl** 
are the [original][wide] nut and bolt to hold the parts together. Both *nut.stl* and *bolt.stl* are compatible with imperial 1/4-28 nuts from your hardware store. The *bolt.stl* is a 4" threaded rod with no head. The *nut.stl* has a knurled outer surface (easier to grip than a hex nut).  

You should print both *nut.stl* and *bolt.stl* at a **0.12 layer height** so that the threads actually work. *bolt.stl* benefits from rotating in your slicer so it **lays flat** printing on a **3-layer raft**, and I've successfully printed eight at a time with a raft.



You could also substitute metal 1/4-28 hardware, or metric M8 hardware if you find *nut.stl* and *bolt.stl* too difficult to print.  Substituting metal makes the whole assembly heavier, which may be fine by your victim, or not.

I should redesign these to use a 1/4-20 coarse thread which you can also get at your hardware store.  It's tempting to go even coarser, say to 1/4-16 thread which would probably print easier but you can't get that at the hardware store to use for cleanup of your printed parts.

The threads of *nut.stl* and the *bolt.stl* can be cleaned up by being threaded onto a common metal 1/4-28 nut or bolt a half-dozen times. If you had a [tap and die set][tap-and-die] that's even better. 

[tap-and-die]: https://www.amazon.com/Standard-Screw-Extractor-Remover-Thread/dp/B07YCTT43T/

### **Large Pussy Clamp.scad** 
contains the redesigned sides for the [large clamp][wide].  The *large body.stl* is [unchanged][wide]. The center hole of *large body.stl* is a 63mm or 2.5" circle, which is very large indeed. 

**Instead** of *large side.stl* we have and is a full redesign.  This one has *sides* that are flush with the outside radius of the *large body.stl* when closed, at about 75mm or 3", and the ears are flush as well.  This uses just four *nut.stl* because the ears are flush.

There's also some copies of *nut.stl* and a redesigned *bolt.stl* inside that has a knurled end on one end of the bolt so you can grip it.  These are commented out, and I recommend you don't try to print them at the same time as the sides and body.

### **Large-Pussy-Clamp-v2.scad** 
The *large body.stl* is [unchanged][wide].

This is a redesign of *large side.stl* with the radius changed. The ears are taken from the *large side.stl*, and amount to a standoff so you can't get the flesh clamped in there too tight.  The originals had a letter embossed in the surface, but the letters never made any sense to me and made that surface hard to print, so that's now removed. 

This uses **eight** *nut.stl* and two *bolt.stl*, two on either side of the *large body.stl* and two on the outside of the *large side.stl*. This is because the *large side.stl* has an integrated standoff, so there's room for two inner *nut.stl* to hold the *bolt.stl* in place. It works best if you either make a half-height *nut.stl* or a brass 1/4-28 nut for the inner ones, so there's room.

### **narrow Pussy Clamp.scad** 
contains the unmodified *narrow body.stl* and two *narrow_side.stl* from the [original][narrow], but the text has been removed. This uses **eight** *nut.stl* and two *bolt.stl*, as above.

The *narrow body.stl* is about 29mm or 1.15" in the inner width along the short axis, which may be too narrow to get *certain* things thru it, but is certainly large enough for a finger.  

There's a 2mm gap between *narrow body.stl* and two *narrow_side.stl* when the screws are all the way down, because of the standoffs.  The outer width along the short axis of the *narrow body.stl* is about 39mm or 1.55".  The inner width of the sides about 42mm or 1.6" between the two *narrow_side.stl* short axis. 

### **Medium Pussy Clamp** 
Only as gcode, this  is just the [narrow scad][narrow] stl scaled up by 150% in the Y direction (the narrow axis). Scaling it this way also makes the ears that the *bolt.stl* runs thru wider, as well as the radii under stress, which probably makes the whole thing stronger. 

Frankly you should probably start with this one as it's less likely to break.

If you scale it 200% in the Y direction, then the center hole becomes a circle the same size as *Large Pussy Clamp.scad]. 


## Printing Notes

[cr6se]: https://www.creality3dofficial.com/products/creality-cr-6-se-3d-printer

* I'm using a [Creality CR-6 SE][cr6se] to print.  No, mine does not catch fire.
* I've tried to print everything (body, 8 nuts, 2 sides, 2 bolts) together in one big print but that pretty much always fails.  
* I almost always succeed when I print only one side or body at a time.
* I can print the two sides and body together, but often the brim starts to curl when I do this, which is an annoyance at cleanup time, but actually doesn't affect the parts you care about.
* The surfaces that touch the flesh you're clamping need less cleanup and sanding if you print flat. 
* Printing flat makes the thry holes in the body or side for *bolt.stl* droop sometimes, even with support.
* You need supports whether you print flat on it's side, or standing up (the 'normal' orientation in the original STL files).  
* Good results with [Creality White PLA][crealitywhite], [Meperper Blue PLA][meperperblue], [3d Solutech PLA][3dsolutech]
* Terrible results with [NovaMaker pink PLA][novamakerpink] which is  especially troublesome.


parameters | value
-------| -----------
printer |  [Creality CR-6 SE][cr6se] 
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
**CR6\_large body flat.gcode** | the large body, with the text still | flat | no | supports | 80% | Cura 4.8.0
**CR6\_narrow body flat.gcode** | narrow body | flat | no | supports | 80% |Cura 4.8.0
**CR6\_narrow\_side flat.gcode** | narrow side 1 pc | flat | no | supports | 80% |Cura 4.8.0
**CE3\_large body flat.gcode** | large body | flat | brim | supports | 80% |Cura 4.7.1
**CE3\_narrow body flat.gcode** | narrow body | flat | brim | supports | 80% |Cura 4.7.1
**CE3\_narrow\_side flat.gcode** | narrow side 1 pc | flat | brim | supports | 80% |Cura 4.7.1
**Large Pussy Clamp All\_0.2mm\_50%\_PLA\_ENDER3\_4h4m.gcode** | large body, side 2 pc, no text | flat | brim | supports | 50% |Prusa 2.2
**Medium Pussy Clamp all\_0.2mm\_50%\_PLA\_ENDER3\_4h27m.gcode** | medium body, side 2 pc, no text, narrow at 150% Y | flat | brim | supports | 50% | Prusa 2.2
**narrow Pussy Clamp all\_0.2mm\_50%\_PLA\_ENDER3\_3h21m.gcode** | narrow body, side 2 pc, no text | flat | brim | supports | 50% | Prusa 2.2

[netfabb]: https://service.netfabb.com/service.php

## STL Files
file Name | description | origin | from
----|----|----|---
**Large Pussy Clamp all.stl** | large body, sides 2 pc | **Large Pussy Clamp.scad** | scad
**narrow Pussy Clamp all.stl** | narrow body, sides 2 pc | **narrow Pussy Clamp.scad** | scad
**narrow sides Pussy Clamp.stl** | sides 2 pc | **narrow Pussy Clamp.scad** | scad
**bolt.stl** | one bolt |  [pussy-clamp-wide][wide]  | cults3d
**bolt_fixed.stl** | one bolt |  **bolt.stl**  | [netfabb][netfabb]
**large body.stl** | large body |  [pussy-clamp-wide][wide]  | cults3d
**large side.stl** | large side | [pussy-clamp-wide][wide]  | cults3d
**narrow body.stl** | narrow body |  [pussy-clamp-narrow][narrow]  | cults3d
**narrow_side.stl** | narrow side |  [pussy-clamp-narrow][narrow] | cults3d
**nut.stl** | one knurled nut |  [pussy-clamp-wide][wide]  | cults3d




