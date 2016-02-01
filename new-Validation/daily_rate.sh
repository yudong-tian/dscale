

cdir=`pwd`

#t0="Nov 1 1999"   # starting time: 0Z
#t1="Jan 1 2001"   # end time: 0Z
t0="Jan 1 2001"   # starting time: 0Z
t1="Dec 31 2009"   # end time: 0Z

exp[0]='B24_0'
exp[1]='B24_600'
exp[2]='B24_2000'
exp[3]='B12_0'
exp[4]='B12_600'
exp[5]='B12_2000'
exp[6]='B4_600'

for i in `seq 0 6`; do

cd ${exp[$i]} 

sec0=`date -u -d "$t0" +%s`
sec1=`date -u -d "$t1" +%s`
let days=(sec1-sec0)/86400

for day in `seq 0 $days`; do

  t1=`date -u -d "$t0 $day day"`  # for new "date" command
  cyr=`date -u -d "$t1" +%Y`
  cmn=`date -u -d "$t1" +%m`
  cdy=`date -u -d "$t1" +%d`
  ccmn=`date -u -d "$t1" +%b`

  ofile=$cyr$cmn$cdy/rain_daily.1gd4r

  tstr="0Z$cdy$ccmn$cyr"

echo $tstr

grads -bl <<EOF

open rainc.ctl
open rainnc.ctl
set time $tstr
define c=rainc-rainc(t-24)
define nc=rainnc.2-rainnc.2(t-24)
set gxout fwrite
set fwrite -be -st $ofile
d c+nc
disable fwrite

quit

EOF

done 

cd $cdir

done


