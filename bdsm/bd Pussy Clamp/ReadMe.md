## bd Pussy Clamp

This is a remix of several designs that came from Cult3d where I felt like the inner radius of the outer sides of the large clamp was simply wrong.

**nut.stl** and **bolt.stl** 
are the original nut and bolt to hold the parts together.  The bolt is a 4" long imperial 1/4-28 bolt, and can take imperial 1/4-28 nuts.  You could also use metal 1/4-28 hardware, or metric M8 hardware.  

These are particularly tricky to print, and I don't know why they used 1/4-28 instead of 1/4-20 which is a coarser thread and would print better.  Even so, it can be done, and both the nut and the bolt are much better after being threaded with piece a few times.   If you can find an especially hardened metal nut or screw, that's even better. 

**Large Pussy Clamp.scad** contains the redesigned sides for the large one.  The center hole here is a full circle.  There's actually two versions of a design for this in the directory. This one has outer sides that is flush with the inner piece when closed, and is a full redesign, including both the main radius and the ears.  

**Large-Pussy-Clamp-v2.scad** The other is redesigned with just the full radius, but the ears are taken from the old one, and amount to a standoff so you can't get the flesh clamped in there too tight.  The originals had a letter embossed in the surface, but the letters never made any sense to me and made it hard to print, so that's now removed.

**narrow Pussy Clamp.scad** contains the unmodified sides and clamps from the original, but the txt has been removed.

**Medium Pussy Clamp** gcode is just the narrow one scaled up by 150% in the Y direction.   if you scale it 200% in the Y direction, then the center hole becomes a circle the same size as Large Pussy Clamp. 


## Printing tips

I've tried to print these all together in one big print but that always seems to fail.  So its better to print one piece at a time.

In PLA printing, I usually

thing | value
------| -----------
slicer | Cura 4.7.1 or PrusaSlicer 2.2 (doesn't seem to make much difference)
material | PLA (except the damn Novamaker PLA)
Hot End | 200 C
Bed | 60 C
Speed | 50mm/sec
infill | 50% to 80% 
brim | yes 
support | yes (this fills in the hole so it doesn't sag)
nozzle | 0.4mm
layer height | 0.2mm
