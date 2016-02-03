#!/bin/bash
# check missing 3B42RT 

#for ayr in 2003 2004 2005 2006 2007; do
for ayr in 2008; do
  for amn in 01 02 03 04 05 06 07 08 09 10 11 12;  do
   apwd=`pwd`
   if [ ! -d $ayr$amn ]; then
    echo $ayr$amn does not exist!
    continue
   fi
   cd $ayr$amn

cwd=`pwd`
yrmn=`basename $cwd`
mn=`date -d ${yrmn}01 +%m`
yy=`date -d ${yrmn}01 +%Y`
case $mn in 
    01) days=31;;
    02) days=28 ;;
    03) days=31 ;;
    04) days=30 ;;
    05) days=31 ;;
    06) days=30 ;;
    07) days=31 ;;
    08) days=31 ;;
    09) days=30 ;;
    10) days=31 ;;
    11) days=30 ;;
    12) days=31 ;;
    *) days=-1;;
esac

# find out if it is a leap year or not

if [ $mn -eq 02 ]; # if it is feb month then only check of leap year
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
  for hr in `seq -w 0 3 21`; do 
  #3B42RT.2005021815.1gd4r
   dfile=3B42RT.${yy}${mn}${day}${hr}.1gd4r
   if [ ! -f $dfile -o ! -s $dfile ]; then
      echo $dfile 
   fi
  done
done


 cd  $apwd
 done
done
