#!/bin/bash
# check missing STIV 01h.Z files 
for ayr in 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014; do
  for amn in 01 02 03 04 05 06 07 08 09 10 11 12;  do
   apwd=`pwd`
   if [ ! -d $ayr$amn ]; then
    echo $ayr$amn does not exist!
    continue
   fi
   cd $ayr$amn

cwd=`pwd`
yrmn=`basename $cwd`
mn=`date -d ${yrmn}01 +%-m`
yy=`date -d ${yrmn}01 +%Y`
case $mn in 
    1) days=31;;
    2) days=28 ;;
    3) days=31 ;;
    4) days=30 ;;
    5) days=31 ;;
    6) days=30 ;;
    7) days=31 ;;
    8) days=31 ;;
    9) days=30 ;;
    10) days=31 ;;
    11) days=30 ;;
    12) days=31 ;;
    *) days=-1;;
esac

# find out if it is a leap year or not

if [ $mn -eq 2 ]; # if it is feb month then only check of leap year
then
	if [ $((yy % 4)) -ne 0 ] ; then
	   : #  not a leap year : means do nothing and use old value of days
	elif [ $((yy % 400)) -eq 0 ] ; then
	   # yes, it's a leap year
	   days=29
	elif [ $((yy % 100)) -eq 0 ] ; then
	   : # not a leap year do nothing and use old value of days
	else
	   # it is a leap year
	   days=29
	fi
fi

for day in `seq -w $days`; do 
  for hr in `seq -w 0 23`; do 
#   if [ ! -f ST4.${yrmn}${day}${hr}.01h.Z ]; then
#      echo ST4.${yrmn}${day}${hr}.01h.Z
   if [ ! -f ST4.${yrmn}${day}${hr}.01h ]; then
      echo ST4.${yrmn}${day}${hr}.01h
   fi
  done
done

cd $apwd
done
done
