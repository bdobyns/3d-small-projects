#!/bin/bash

if [ -z $2 ] ; then
    echo "usage:"
    echo $0 oldname newname
    echo '	'renames files containing oldname as PART of the filename 
    echo '	'to contain newname instead.
    echo '	'Tries to "'git mv'" first, and if that fails then just "'mv'"
    echo "examples:"
    echo '	'$0 CCR6SE CR6
    echo '	'$0 fixed netfabb    
    exit
fi

find . -iname '*'$1'*' | while read f
do
   j=$( echo $f | sed -e s/$1/$2/ )
   if ! git mv "$f" "$j"
   then mv "$f" "$j"
   fi
 done

