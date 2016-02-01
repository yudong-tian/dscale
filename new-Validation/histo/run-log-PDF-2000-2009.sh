
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

dim[0]='232 112 3653'
dim[1]='232 112 3653'
dim[2]='232 112 3653'
dim[3]='464 224 3653'
dim[4]='464 224 3653'
dim[5]='464 224 3653'
dim[6]='1405 621 3653'

dim[7]='464 224 3653'
dim[8]='94 57 3653'

#newer addition
dim[9]='232 112 3653'
dim[10]='232 112 3653'
dim[11]='232 112 3653'

#for i in `seq 0 4`; do
#for i in `seq 5 5`; do
#for i in `seq 7 7`; do
#for i in `seq 8 8`; do
#for i in `seq 7 7`; do
#for i in `seq 3 5`; do
for i in `seq 9 11`; do

 ./log-PDF ../${exp[$i]}/2000-2009_daily.1gd4r ${dim[$i]}  > ../${exp[$i]}/hist_2000-2009_daily.txt 
 ./log-PDF ${ref[$i]}/2000-2009.1gd4r ${dim[$i]}  > ../${exp[$i]}/hist_2000-2009_prism.txt 

 ./log-PDF-rel ../${exp[$i]}/2000-2009_daily.1gd4r ${dim[$i]}  > ../${exp[$i]}/rel-hist_2000-2009_daily.txt 
 ./log-PDF-rel ${ref[$i]}/2000-2009.1gd4r ${dim[$i]}  > ../${exp[$i]}/rel-hist_2000-2009_prism.txt 

done



