#!/bin/bash
# wholesale script to convert a month-worth of STIV polar to 0.25 latlon 
# Usage example:  convert-allyears.sh 

for year in `seq 2002 2008`; do
 for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do
     dir="$year$mon"
     cd $dir
     gunzip *.24h.Z 
     cd ..
  done
done

