#!/bin/bash
# check missing STIV 24h.Z files 
for ayr in 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011; do
  for amn in 01 02 03 04 05 06 07 08 09 10 11 12;  do
  
   yrmn=$ayr$amn
   if [ ! -d $yrmn ]; then
    echo $yrmn does not exist!
    continue
   fi

   for ady in `cal $amn $ayr | tail +3`; do 
  
   if [ $ady -lt 10 ]; then 
     ady=0$ady
   fi
   if [ ! -f $yrmn/ST4.${yrmn}${ady}12.24h ]; then
      echo $yrmn/ST4.${yrmn}${ady}12.24h
   fi
   done
  done
done

