#!/bin/bash
# wholesale script to convert a month-worth of STIV polar to 0.04 latlon 
# Usage example:  convert-allyears.sh 
# run on trmm for access of ramdisk

idir=/home/ytian/proj-disk/MET_FORCING/STIV/

for year in 2005 2006; do
 for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do

     dir="$year$mon"
     mkdir $dir
     for file in `ls $idir/$dir/*.01h`; do
       uzfile=`basename $file` 
       ofile=${uzfile}-0.04.1gd4r
       echo "input: $file output $ofile"
         ./4km-0.04 $file $dir/$ofile
     done

  done
done

