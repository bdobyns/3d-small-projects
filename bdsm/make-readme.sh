#/bin/bash

if [ ! -z $1] ; then 
	ofile=$1
else 
	ofile=ReadMe.md
fi	


if [ ! -s $ofile ] ; then
	cat >>$ofile <<EOF



EOF
else
(
	echo'# Overview of '/$( pwd ) >>$OFILE
cat >>$ofile <<EOF
These were remixed from 

These were modified to

## Printing Notes

[bclamp]: https://cults3d.com/en/3d-model/naughties/breast-clamp-neojunky
[netfabb]: https://service.netfabb.com/service.php
[crealitywhite]: https://www.amazon.com/dp/B08CL2D3Y8/
[meperperblue]: https://www.amazon.com/gp/product/B085K15P44/
[3dsolutech]: https://www.amazon.com/gp/product/B00MF03LAE/
[novamakerpink]: https://www.amazon.com/gp/product/B071G5QBRK/
[cr6se]: https://www.creality3dofficial.com/products/creality-cr-6-se-3d-printer
[gudteks]: https://www.amazon.com/gp/product/B01AP534LQ/

* Good results with [Creality White PLA][crealitywhite], [Gudteks yellow PLA][gudteks], [Meperper Blue PLA][meperperblue], [3d Solutech PLA][3dsolutech]
* Terrible results with [NovaMaker pink PLA][novamakerpink] which is  especially troublesome.
* The screw prints vertically with the knurled end down. I've only ever tried to print one at a time.
* I usually print all the parts one at a time.


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
  
EOF		
	
fi

for j in scad stl gcode
do
    export $j
    echo >>$ofile
    echo >>$ofile
    echo '##' $( echo $j | tr a-z A-Z ) Files >>$ofile
    echo >>$ofile
    
    echo $j files '| description | source ' >>$ofile
    echo '----|----|----'>>$ofile

    ls -1 *$j | while read i
    do
	echo '**'$i'** | | ' >>$ofile
    done
done   
