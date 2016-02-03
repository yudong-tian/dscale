#!/bin/bash
# wholesale script to convert a month-worth of STIV polar to 0.04 latlon 
# Usage example:  convert-allyears.sh 
# run on trmm for access of ramdisk


for year in 2011; do
 for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do
#for year in 2006; do
# for mon in 01 02; do
     dir="$year$mon"
     mkdir $dir
     mv $year/ST4.${dir}*.Z $dir 
     for file in `ls $dir/*.01h.Z`; do
       uzfile=`echo $file |sed 's/.Z$//'`
       uzfile=`basename $uzfile` 
       ofile=${uzfile}-0.04.1gd4r
       gunzip -c $file > $TMPDIR/$uzfile
       echo "input: $file output $ofile"
       ./4km-0.04 $TMPDIR/$uzfile $dir/$ofile
       rm -f $TMPDIR/$uzfile
    done

  done
done

