#!/bin/bash
# wholesale script to convert a month-worth of huffman data to GraADS format
# Usage example:  convert-huffman2grads.sh /S1A3/DATA/HUFFMAN/200508

#for year in 2002 2003 2004 2005 2006; do
# for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do
for year in 2007; do
 for mon in 01 02 03 04 05 06 07 08 09 10 11; do
    dir="$year$mon"
     cd $dir
      ../aggr-to-gpcp1dd $year $mon
     cd ..
  done
done

