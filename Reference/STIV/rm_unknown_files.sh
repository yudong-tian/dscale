


 for year in 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014; do
  for month in 01 02 03 04 05 06 07 08 09 10 11 12; do
    for day in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31; do
     for hour in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23; do

###  E.g.,
###   ST4.20040116

     file=${year}${month}/ST4.${year}${month}${day}
     rm ${file} 

    done
   done
  done
 done

 echo "done."

