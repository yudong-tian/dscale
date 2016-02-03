
idir=/home/ytian/proj-disk/MET_FORCING/NLDAS2.FORCING/
odir=/home/ytian/Climate-downscaling/Reference/NLDAS-0.125/

#sdate="Nov 1 2005"
#edate="Aug 31 2006"

#sdate="Nov 1 1999"
#edate="Oct 31 2005" 

sdate="Aug 30 2006"
edate="Sep 2  2006" 

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
   ifile=$idir/$cyr/$cymd/$cymd$hr.nldasforce-a.grb
   ofile=$od/APCP_$cymd$hr.bin 
   wgrib -d 10 -nh -o $ofile $ifile 
 done

done 


