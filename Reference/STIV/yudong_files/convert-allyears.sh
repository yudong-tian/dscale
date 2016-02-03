#!/bin/bash
# wholesale script to convert a month-worth of STIV polar to 0.25 latlon 
# Usage example:  convert-allyears.sh 
# run on trmm for access of ramdisk

pwd=`pwd`
tmpdir=/tmp 

#for year in 2004; do
# for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do
for year in 2007; do
 for mon in 08 09 10 11 12; do
     dir="$year$mon"
     cd $dir
     for file in `ls *.01h.Z`; do
       uzfile=`echo $file |sed 's/.Z$//'`
       ofile=${uzfile}.1gd4r
       gunzip -c $file > $tmpdir/$uzfile
       echo "input: $file output $ofile"
       ../4km-0.25 $tmpdir/$uzfile $ofile
       rm -f $tmpdir/$uzfile
     done
     cd $pwd
  done
done

for year in 2008; do
 for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do
     dir="$year$mon"
     cd $dir
     for file in `ls *.01h.Z`; do
       uzfile=`echo $file |sed 's/.Z$//'`
       ofile=${uzfile}.1gd4r
       gunzip -c $file > $tmpdir/$uzfile
       echo "input: $file output $ofile"
       ../4km-0.25 $tmpdir/$uzfile $ofile
       rm -f $tmpdir/$uzfile
     done
     cd $pwd
  done
done


