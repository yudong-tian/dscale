#extract hourly prectot for 2000
# each file contains 24 hourly rainrates, global 

#year=2000
for year in `seq 2001 2009`; do 

stream="" 
if [ $year -lt 1990 ]; then 
   stream="MERRA2_100"
fi
if [ $year -ge 1990 ] && [ $year -lt 2000 ]; then 
   stream="MERRA2_200"
fi
if [ $year -ge 2000 ] && [ $year -lt 2010 ]; then 
   stream="MERRA2_300"
fi
if [ $year -ge 2010 ]; then 
   stream="MERRA2_400"
fi

dpath="/discover/nobackup/projects/gmao/merra2/merra2/scratch/$stream/stage/Y$year"

echo $dpath 

t0="1 Jan $year"   # starting time: 0Z
t1="31 Dec $year"   # end time: 0Z

sec0=`date -u -d "$t0" +%s`
sec1=`date -u -d "$t1" +%s`
let days=(sec1-sec0)/86400

for day in `seq 0 $days`; do
  t1=`date -u -d "$t0 $day day"`  # for new "date" command
  cyr=`date -u -d "$t1" +%Y`
  cmn=`date -u -d "$t1" +%m`   
  cdy=`date -u -d "$t1" +%d`   
  cmd=`date -u -d "$t1" +M%m`   
  dfile=`date -u -d "$t1" +$stream.tavg1_2d_flx_Nx.%Y%m%d.nc4`
  fdir="MERRA2/$cyr$cmn$cdy"
  if [ ! -d $fdir ]; then
     mkdir -p $fdir
  fi
  echo extracting $dpath/$cmd/$dfile

grads -bl <<EOF1
sdfopen $dpath/$cmd/$dfile 
set fwrite -be -st $fdir/hourly.24gd4r
set gxout fwrite
set t 1 24
set x 1 576
set y 1 361
d prectot*3600 
disable fwrite
quit

EOF1

done   # for day


done # for year
