
#idir=/home/ytian/proj-disk/MET_FORCING/NLDAS2.FORCING/
idir=/home/ytian/Climate-downscaling/Reference/NLDAS-0.125/
odir=/home/ytian/Climate-downscaling/Reference/NLDAS-0.22/

sdate="Nov 1 2005"
edate="Aug 31 2006"

ssec=`date -d "$sdate" +%s`
esec=`date -d "$edate" +%s`

# how many days-1 in a year
let ndays=(esec-ssec)/86400
echo $ndays 

for id in `seq 0 $ndays`; do 
 cyr=`date -u -d "$sdate $id days" +%Y`
 cymd=`date -u -d "$sdate $id days" +%Y%m%d`
 od=$odir/$cyr/$cymd
 if [ ! -d $od ]; then
   mkdir -p $od
 fi

 for hr in `seq -w 0 23`; do 
  
   #ifile=$idir/$cyr/$cymd/APCP-a.ctl 
   ifile=$idir/APCP-a.ctl 
   ofile=$od/APCP_$cymd$hr.bin 
   gtime=`date -u -d "$sdate $id days $hr hours" +%H:%MZ%d%b%Y`

/home/dao_ops/operations/GrADS/Linux-1.9-rc1-gmao/grads -bl <<EOF
open $ifile
set time $gtime
set gxout fwrite
set fwrite -be -st $ofile 
d re(apcpsfc, 264, linear, -124.89, 0.22, 128, linear, 25.11, 0.22)
disable fwrite
quit
EOF

 done

done 


