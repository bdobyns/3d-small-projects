for j in scad stl gcode; do export $j ;  echo >>ReadMe.md; echo $j files >>ReadMe.md; echo >>ReadMe.md;  ls -1 *$j | while read i; do echo '**'$i'** | | ' >>ReadMe.md ; done    ; done
done
