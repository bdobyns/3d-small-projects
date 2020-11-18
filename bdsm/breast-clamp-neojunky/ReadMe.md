# Overview of /breast-clamp-neojunky

These were found on Cults3d as [breast-clamp-neojunky][bclamp] and I have printed only the short ones, because I have a [Creality CR-6 SE][cr6se] which cannot print the 330mm long ones.

Generally, these printed without modification and cleanup.  The only reason there's OpenSCAD files is to remix the threaded ends into a nut and a reusable part.

If I had a big enough printer for the 330mm long one I'd probably modify it to have a third threaded hole in the center of **Longbar1.stl** so the relative tension is better distributed.  I might be able to print it diagonally across the long diagonal of the build cube since that's 332mm but that sounds tricky.

[bclamp]: https://cults3d.com/en/3d-model/naughties/breast-clamp-neojunky
[netfabb]: https://service.netfabb.com/service.php
[crealitywhite]: https://www.amazon.com/dp/B08CL2D3Y8/
[meperperblue]: https://www.amazon.com/gp/product/B085K15P44/
[3dsolutech]: https://www.amazon.com/gp/product/B00MF03LAE/
[novamakerpink]: https://www.amazon.com/gp/product/B071G5QBRK/
[cr6se]: https://www.creality3dofficial.com/products/creality-cr-6-se-3d-printer
[gudteks]: https://www.amazon.com/gp/product/B01AP534LQ/
[wide]: https://cults3d.com/en/3d-model/naughties/pussy-clamp-wide-thecuddlesdom
[narrow]: https://cults3d.com/en/3d-model/naughties/pussy-clamp-narrow

## Printing Notes

* Good success printing with [Gudteks yellow PLA][gudteks], [Meperper blue PLA][meperperblue].
* Mediocre results with [Novamaker pink PLA][novamakerpink].
* The screw prints vertically with the knurled end down, one at a time.
* I usually print the bars one at a time.
* * Unlike the [pussy-clamp][wide] these threads are coarse enough to print correctly. 
* You can print **two** of the **Shortbar2.stl** which are unthreaded and use two **thread-nut.stl** on two **Screw.stl** to complete the build.  This also has a different and more symmetric esthetic as there's a knurled element on both the top and the bottom.


parameters | value
-------| -----------
printer |  [Creality CR-6 SE][cr6se] 
material | PLA
Hot End | 200 C
Bed | 60 C
Speed | 50mm/sec
infill | 80%, cubic
brim | yes 
support | yes
nozzle | 0.4mm
layer height | 0.2mm

## SCAD Files

scad files | description | source
----|----|----
**thread-end.scad** | whacking off just the threaded section to use in another build | **Shortbar1.stl**
**thread-nut.scad** | just the threaded section, but with a knurled outer surface. This gives me a matching nut that looks like the knurled head of the screw. | **Shortbar1.stl**

## STL Files

stl files | description | source
----|----|----
**Longbar1.stl** | 350mm bar for two breasts, threaded holes| [original][bclamp]
**Longbar2.stl** | 350mm bar for two breasts, smooth holes| [original][bclamp]
**Screw.stl** | 130mm screw, large knurled end | [original][bclamp] 
**Shortbar1.stl** | 220mm bar for two breasts, threaded holes| [original][bclamp]
**Shortbar2.stl** | 220mm bar for two breasts, threaded holes| [original][bclamp]
**thread-end.stl** | threaded end piece to fit **Screw.stl** | **thread-end.scad** 
**thread-end\_fixed.stl** | cleaned up **thread-end.stl** | [netfabb][netfabb]
**thread-nut.stl** | knurled threaded nut to fit **Screw.stl** | **thread-nut.scad**
**thread-nut\_fixed.stl** | cleaned up **thread-nut.stl** | [netfabb][netfabb]

## GCODE Files

gcode files | description | source | slicer
----|----|----|----
**breast\_Screw\_0.2mm\_80%\_PLA\_ENDER3\_2h20m.gcode** | long screw | **Screw.stl** | Prusa 2.2.0 
**3\_breast\_bar2\_0.2mm\_PLA\_ENDER3\_10h57m.gcode** | three of unthreaed | **Shortbar2.stl** | Prusa 2.2.0 
**4\_breast\_bar1\_0.2mm\_PLA\_ENDER3\_14h55m.gcode** | four of threaded | **Shortbar1.stl** | Prusa 2.2.0
**breast-bar2\_0.2mm\_80%\_PLA\_ENDER3\_4h40m.gcode** | one unthreaded | **Shortbar2.stl** | Prusa 2.2.0
**breast\_bar1\_0.2mm\_80%\_PLA\_ENDER3\_4h46m.gcode** | one threaded | **Shortbar1.stl** | Prusa 2.2.0
**thread-nut\_fixed\_0.2mm\_80%\_PLA\_ENDER3\_26m.gcode** | one threaded nut | **thread-nut\_fixed.stl** | Prusa 2.2.0
**breast-bar1.gcode** | one threaded | **Shortbar1.stl** | Cura 4.7.1
**breast-bar2.gcode** | one unthreaded | **Shortbar2.stl** | Cura 4.7.1 
**breast-screw.gcode** | long screw | **Screw.stl** | Cura 4.7.1
**nylon\_breast\_Screw.gcode** | nylon long screw | **Screw.stl** | Cura 4.7.1

