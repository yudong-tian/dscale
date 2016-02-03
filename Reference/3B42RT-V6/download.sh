#!/bin/bash
# wholesale script to download 3B42RT raw data. 
# 

#for year in 2002 2003 2004 2005; do
for year in 2008; do
 for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do
    dir="$year$mon"
    mkdir $dir
     cd $dir
     wget --passive-ftp ftp://trmmopen.gsfc.nasa.gov/pub/merged/mergeIRMicro/V5/$year/3B42RT.${year}${mon}*
     cd ..
  done
done




