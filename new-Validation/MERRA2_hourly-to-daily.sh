#Accumulate hourly to daily 


#t0="1 Jan 2000"   # starting time: 0Z
#t1="31 Dec 2000"   # end time: 0Z
t0="1 Jan 2001"   # starting time: 0Z
t1="31 Dec 2009"   # end time: 0Z

sec0=`date -u -d "$t0" +%s`
sec1=`date -u -d "$t1" +%s`
let days=(sec1-sec0)/86400

for day in `seq 0 $days`; do
  t1=`date -u -d "$t0 $day day"`  # for new "date" command
  time0=`date -u -d "$t1" +00Z%d%b%Y`
  time1=`date -u -d "$t1" +23Z%d%b%Y`

  cyr=`date -u -d "$t1" +%Y`
  cmn=`date -u -d "$t1" +%m`   
  cdy=`date -u -d "$t1" +%d`   
  fdir="MERRA2/$cyr$cmn$cdy"
 
  echo extracting $time0 $time1 

grads -bl <<EOF1
open MERRA2/rain_hourly.ctl 
set fwrite -be -st $fdir/daily.1gd4r
set gxout fwrite
set x 1 576
set y 1 361
d sum(rain, time=$time0, time=$time1) 
disable fwrite
quit

EOF1

done   # for day
