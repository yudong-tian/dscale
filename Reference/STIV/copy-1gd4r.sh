#!/bin/bash
# move 1gd4r data from lis to here 
for ayr in 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014; do
  for amn in 01 02 03 04 05 06 07 08 09 10 11 12;  do
   mkdir $ayr$amn
   cp -p /home/ytian/proj-disk/MET_FORCING/STIV/$ayr$amn/*.1gd4r $ayr$amn/
   rm -rf /home/ytian/proj-disk/MET_FORCING/STIV/$ayr$amn/*.1gd4r
  done 
done

