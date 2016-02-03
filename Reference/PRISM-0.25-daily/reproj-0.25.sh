
idir=/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily/
odir=/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily/ 

#sdate="Nov 1 1999"
#edate="Oct 31 2010"
sdate="Oct 30 2010" 
edate="Nov 1 2010"

ssec=`date -d "$sdate" +%s`
esec=`date -d "$edate" +%s`

# how many days in a year
let ndays=(esec-ssec)/86400
echo $ndays 

for id in `seq 0 $ndays`; do 
 cyr=`date -u -d "$sdate $id days" +%Y`
 cymd=`date -u -d "$sdate $id days" +%Y%m%d`
 od=$odir/$cyr
 if [ ! -d $od ]; then
   mkdir -p $od
 fi

 ifile=$idir/ppt.ctl 
 ofile=$od/$cymd.bin 
 gtime=`date -u -d "$sdate $id days" +%H:%MZ%d%b%Y`

/home/dao_ops/operations/GrADS/Linux-1.9-rc1-gmao/grads -bl <<EOF
open $ifile
set time $gtime
set gxout fwrite
set fwrite -be -st $ofile 
d re(ppt, 232, linear, -124.875, 0.25, 112, linear, 25.125, 0.25)
disable fwrite
quit
EOF


done 


