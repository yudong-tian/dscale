#!/bin/bash
# check missing STIV 01h.Z files 
for ayr in 2004; do
  for amn in 01 02 03 04 05 06 07 08 09 10 11 12;  do
   apwd=`pwd`
   if [ ! -d $ayr$amn ]; then
    echo $ayr$amn does not exist!
    continue
   fi
   cd $ayr$amn
   gzip -S .Z *.??h

cd $apwd
done
done
