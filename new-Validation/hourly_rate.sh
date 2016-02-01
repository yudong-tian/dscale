

# compute hourly rain rate from total accumulation 

t0="Nov 1 2005"   # starting time: 0Z
t1="Sep 1 2006"   # end time: 0Z

sec0=`date -u -d "$t0" +%s`
sec1=`date -u -d "$t1" +%s`
let days=(sec1-sec0)/86400

for day in `seq 0 $days`; do


  t1=`date -u -d "$t0 $day day"`  # for new "date" command
  cyr=`date -u -d "$t1" +%Y`
  cmn=`date -u -d "$t1" +%m`
  cdy=`date -u -d "$t1" +%d`
  ccmn=`date -u -d "$t1" +%b`

  #yesterday's data needed 
  let yday=day-1
  t2=`date -u -d "$t0 $yday day"`  # for new "date" command
  ycyr=`date -u -d "$t2" +%Y`
  ycdy=`date -u -d "$t2" +%d`
  yccmn=`date -u -d "$t2" +%b`

  ofile=rain_hourly_$cyr-$cmn-${cdy}.1gd4r

  tstr="0Z$cdy$ccmn$cyr 23Z$cdy$ccmn$cyr"
  tstr2="23Z$ycdy$yccmn$ycyr 23Z$cdy$ccmn$cyr"

echo $tstr
echo $tstr2

grads -bl <<EOF

open rainc.ctl
open rainnc.ctl
set time $tstr2
define c=tloop(rainc-rainc(t-1))
define nc=tloop(rainnc.2-rainnc.2(t-1))
set gxout fwrite
set fwrite -be -st $ofile
set time $tstr
d c+nc
disable fwrite 

quit
EOF


done
