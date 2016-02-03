#!/bin/bash
# check missing STIV 24h.Z files 
for ayr in 2006 2007 2008; do
  for amn in 01 02 03 04 05 06 07 08 09 10 11 12;  do
  
   yrmn=$ayr$amn
   if [ ! -d ../$yrmn ]; then
    echo $yrmn does not exist!
    mkdir ../$yrmn
   fi

  mv ST4.${yrmn}* ../$yrmn/

  done
done

