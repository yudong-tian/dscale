#!/bin/bash
# wholesale script to convert a month-worth of huffman data to GraADS format
# Usage example:  convert-huffman2grads.sh /S1A3/DATA/HUFFMAN/200508

#for year in 2002 2003 2004 2005; do
for year in 2008; do
 for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do
    dir="$year$mon"
    if [ ! -d $dir ]; then
     mkdir $dir
    fi
     #mv $year/3B42RT.$dir* $dir
     cd $dir
     gunzip *.gz
     for file in `ls *.bin`; do
       ofile=`echo $file|sed -e 's/.bin$/.1gd4r/'`
       echo "input: $file output $ofile"
       ../rd3B42RT $file $ofile
     done
     rm *.bin
     cd ..
  done
done

