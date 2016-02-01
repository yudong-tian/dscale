#extract hourly prectot for 2000

# as of Aug. 27: 
# Nov 1, 1999 - Dec. 16, 2004
#dpath="/discover/nobackup/projects/gmao/osse2/stage/M2R12K_BETA7/M2R12K_nov1999/DATA/0.1250_deg/tavg/tavg1_2d_flx_Nx/"

# May 31, 2005 - Dec 31, 2009
dpath="/discover/nobackup/projects/gmao/osse2/stage/M2R12K_BETA7/M2R12K_may2005/DATA/0.1250_deg/tavg/tavg1_2d_flx_Nx/"


#t0="1 Jan 2000"   # starting time: 0Z
#t1="31 Dec 2000"   # end time: 0Z
t0="31 May 2005"   # starting time: 0Z
t1="31 Dec 2009"   # end time: 0Z

sec0=`date -u -d "$t0" +%s`
sec1=`date -u -d "$t1" +%s`
let days=(sec1-sec0)/86400

for day in `seq 0 $days`; do
  t1=`date -u -d "$t0 $day day"`  # for new "date" command
  cyr=`date -u -d "$t1" +%Y`
  cmn=`date -u -d "$t1" +%m`   
  cdy=`date -u -d "$t1" +%d`   
  cmd=`date -u -d "$t1" +Y%Y/M%m/D%d`   
 
  for hr in `seq 0 23`; do 
    let fm=hr*60+30   # GEOS5 hourly file name marks the middle of the hour. Output file marks the start of the hour 
    dfile=`date -u -d "$t1 $fm min" +M2R12K.tavg1_2d_flx_Nx.%Y%m%d_%H%Mz.nc4`
    ftime=`date -u -d "$t1 $fm min" +%H%M`
    otime=`date -u -d "$t1 $hr hour" +%H%M`
    fdir="M2R12K/$cyr$cmn$cdy"
    if [ ! -d $fdir ]; then
      mkdir -p $fdir
    fi
    echo extracting $dpath/$cmd/$dfile

grads -bl <<EOF1
sdfopen $dpath/$cmd/$dfile 
set fwrite -be -st $fdir/$otime.1gd4r
set gxout fwrite
*set lon -124.9375 -67.0625
*set lat 25.0625 52.9375
set x 441 904
set y 921 1144
*LON set to -125 -67.125
*LAT set to 25 52.875
d prectot*3600 
disable fwrite
quit

EOF1

 done   # for hr 
done   # for day
