#!/bin/bash
# wholesale script to convert a month-worth of STIV polar to 0.25 latlon 
# Usage example:  convert-allyears.sh 


for year in 2011; do
 for mon in 01 02; do
     dir="$year$mon"
     cd $dir
     gunzip *.24h.Z
     for file in `ls *.24h`; do
       ofile=${file}.lis_grid.1gd4r
       echo "input: $file output $ofile"
       ../4km-0.25-daily-0.125_grid $file $ofile
     done
     cd ..
  done
done


for year in 2005 2006 2007 2008 2009 2010; do
 for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do
     dir="$year$mon"
     cd $dir
     gunzip *.24h.Z
     for file in `ls *.24h`; do
       ofile=${file}.lis_grid.1gd4r
       echo "input: $file output $ofile"
       ../4km-0.25-daily-0.125_grid $file $ofile
     done
     cd ..
  done
done


mail -s "st4 is done" "ling.tang@nasa.gov" <<EOF
St4 daily is done. 
Location: lis-disk/MET_FORCING/STIV-yudong/STIV/yyyymm/ST4.yyyymmdd12.24h.lis_grid.1gd4r

0.25-degree, lat/lon
XDEF   240 LINEAR        -130.125 0.25
YDEF   120 LINEAR         20.875 0.25

.
EOF
