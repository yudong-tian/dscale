

# figuring out the subdirectory for a given run and year 
# example: 
# subdir 'B4' 2005
# return a string to the variable "sub_d". 

#B12 
#drwxr-sr-x 2 tiguchi3 s1457 131072 Jul 22 09:06 1999-2001
#drwxr-sr-x 2 tiguchi3 s1457 262144 Jul 27 16:48 2001-2003
#drwxr-sr-x 2 tiguchi3 s1457 262144 Aug  2 10:48 2003-2005
#drwxr-sr-x 2 tiguchi3 s1457 262144 Aug  7 21:15 2005-2007
#drwxr-sr-x 2 tiguchi3 s1457 262144 Aug 13 10:37 2007-2009
#drwxr-sr-x 2 tiguchi3 s1457 131072 Aug 16 16:31 2009-2010
#drwxr-sr-x 2 tiguchi3 s1457 131072 Aug 18 12:08 2010

function subdir() 
{ 
    local run=$1
    local year=$2
    local sub_d='' 
    if [ "$run" = 'B24' ]; then 
       sub_d='' 
    fi 
    if [ "$run" = 'B12' ]; then 
       case $year in 
       1999|2000)
           sub_d="1999-2001"
           ;; 
       2001|2002)
           sub_d="2001-2003"
           ;; 
       2003|2004)
           sub_d="2003-2005"
           ;; 
       2005|2006)
           sub_d="2005-2007"
           ;; 
       2007|2008)
           sub_d="2007-2009"
           ;; 
       2009)
           sub_d="2009-2010"
           ;; 
       2010)
           sub_d="2010"
           ;; 
       *)
           sub_d="!!!!!!!!!!!!!!!!!" 
           ;; 
       esac
     fi

    if [ "$run" = 'B4' ]; then
       case $year in
       1999|2000)
           sub_d="1999-2000"
           ;;
       2001)
           sub_d="2001"
           ;;
       2002)
           sub_d="2002"
           ;;
       2003)
           sub_d="2003"
           ;;
       2004)
           sub_d="2004"
           ;;
       2005|2006)
           sub_d="2005-2007"
           ;;
       2007|2008)
           sub_d="2007-2009"
           ;;
       2009)
           sub_d="2009-2010"
           ;;
       2010)
           sub_d="2010"
           ;;
       *)
           sub_d="!!!!!!!!!!!!!!!!!"
           ;;
       esac
     fi

       echo "$sub_d"
} 


# test
#echo subdir B12 2007
#echo `subdir B12 2007`
#echo subdir B12 2000
#echo `subdir B12 2000`
#echo subdir B4 2000
#echo `subdir B4 2000`
#echo subdir B4 2001
#echo `subdir B4 2001`
#

#t0="Nov 1 1999"   # starting time: 0Z
#t1="Jan 1 2001"   # end time: 0Z
#t0="Jan 1 2001"   # starting time: 0Z
#t1="Dec 31 2001"   # end time: 0Z
#t0="Jan 1 2002"   # starting time: 0Z
#t1="Dec 31 2002"   # end time: 0Z
t0="Jan 1 2003"   # starting time: 0Z
t1="Dec 31 2004"   # end time: 0Z

exp[0]='B24_0'
exp[1]='B24_600'
exp[2]='B24_2000'
exp[3]='B12_0'
exp[4]='B12_600'
exp[5]='B12_2000'
exp[6]='B4_600'

dpath[0]='/discover/nobackup/projects/dscale/tiguchi3/runs_hasw/merra2_10years_workdirect_lbcr3135_unnudge_B24'
dpath[1]='/discover/nobackup/projects/dscale/tiguchi3/runs_hasw/merra2_10years_workdirect_lbcr3135_nudge600_B24'
dpath[2]='/discover/nobackup/projects/dscale/tiguchi3/runs_hasw/merra2_10years_workdirect_lbcr3135_nudge2000_B24'
dpath[3]='/discover/nobackup/projects/dscale/tiguchi3/pub/lbc_r3135_outputs/B12_unnudge' 
dpath[4]='/discover/nobackup/projects/dscale/tiguchi3/pub/lbc_r3135_outputs/B12_nudge600km' 
dpath[5]='/discover/nobackup/projects/dscale/tiguchi3/pub/lbc_r3135_outputs/B12_nudge2000km' 
dpath[6]='/discover/nobackup/projects/dscale/tiguchi3/pub/lbc_r3135_outputs/B4_nudge600km' 

#for i in `seq 0 6`; do
for i in `seq 6 6`; do

sec0=`date -u -d "$t0" +%s`
sec1=`date -u -d "$t1" +%s`
let days=(sec1-sec0)/86400

for day in `seq 0 $days`; do
  t1=`date -u -d "$t0 $day day"`  # for new "date" command
  cyr=`date -u -d "$t1" +%Y`
  cmn=`date -u -d "$t1" +%m`
  cdy=`date -u -d "$t1" +%d`

  run=`echo ${exp[$i]} | cut -d '_' -f 1`
  sub_d=`subdir $run $cyr`

  opath=${exp[$i]}/$cyr$cmn$cdy
  mkdir -p $opath

  dfile=wrf2dout_d01_$cyr-$cmn-${cdy}_00:00:00

  echo dumping ${dpath[$i]}/$sub_d/$dfile

h5dump -d /RAINC -b BE -o $opath/rainc_${cyr}_${cmn}_${cdy}.1gd4r ${dpath[$i]}/$sub_d/$dfile
h5dump -d /RAINNC -b BE -o $opath/rainnc_${cyr}_${cmn}_${cdy}.1gd4r ${dpath[$i]}/$sub_d/$dfile

done

done 


