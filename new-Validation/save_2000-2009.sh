

cdir=`pwd`

exp[0]='B24_0'
exp[1]='B24_600'
exp[2]='B24_2000'
exp[3]='B12_0'
exp[4]='B12_600'
exp[5]='B12_2000'
exp[6]='B4_600'

exp[7]='M2R12K'
exp[8]='MERRA2'

#newer addition
exp[9]='B24_600_BMJ'
exp[10]='B24_600_NKF'
exp[11]='B24_600_NSAS'

ref[0]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[1]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[2]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[3]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[4]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[5]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[6]='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'

ref[7]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[8]='/home/ytian/Climate-downscaling/Reference/PRISM-MERRA2-daily'

#newer addition
ref[9]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[10]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[11]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'

lon[0]='set lon -124.875 -67.125'
lat[0]='set lat 25.125 52.875'
lon[1]='set lon -124.875 -67.125'
lat[1]='set lat 25.125 52.875'
lon[2]='set lon -124.875 -67.125'
lat[2]='set lat 25.125 52.875'

lon[3]='set lon -124.9375 -67.0625'
lat[3]='set lat 25.0625 52.9375'
lon[4]='set lon -124.9375 -67.0625'
lat[4]='set lat 25.0625 52.9375'
lon[5]='set lon -124.9375 -67.0625'
lat[5]='set lat 25.0625 52.9375'

lon[6]='set lon -125 -66.5'
lat[6]='set lat 24.0833 49.9166'

lon[7]='set lon -124.9375 -67.0625'
lat[7]='set lat 25.0625 52.9375'

lon[8]='set lon -125 -66.875' 
lat[8]='set lat 25 53' 

#newer addition
lon[9]='set lon -124.875 -67.125'
lat[9]='set lat 25.125 52.875'
lon[10]='set lon -124.875 -67.125'
lat[10]='set lat 25.125 52.875'
lon[11]='set lon -124.875 -67.125'
lat[11]='set lat 25.125 52.875'

#for i in `seq 3 3`; do
#for i in `seq 0 1`; do
#for i in `seq 2 2`; do
#for i in `seq 4 4`; do
#for i in `seq 5 5`; do
#for i in `seq 8 8`; do
#for i in `seq 7 7`; do
#for i in `seq 3 5`; do

for i in `seq 9 11`; do

cd ${exp[$i]} 

echo ${lon[$i]}
echo ${lat[$i]}

grads -bl <<EOF

open rain_daily.ctl
open ${ref[$i]}/ppt.ctl 
set time 1JAN2000 31DEC2009
set gxout fwrite
#set fwex
set fwrite -be -st 2000-2009_daily.1gd4r
${lon[$i]}
${lat[$i]}
d maskout(rain, ppt.2(t=1))
disable fwrite

quit

EOF

cd $cdir
done


