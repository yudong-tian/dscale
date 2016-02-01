
exp[0]='B24_0'
exp[1]='B24_600'
exp[2]='B24_2000'
exp[3]='B12_0'
exp[4]='B12_600'
exp[5]='B12_2000'

exp[6]='M2R12K'
exp[7]='MERRA2'

exp[8]='B4_600'

#newer addition
exp[9]='B24_600_BMJ'
exp[10]='B24_600_NKF'
exp[11]='B24_600_NSAS'

res[0]='B24'
res[1]='B24'
res[2]='B24'
res[3]='B12'
res[4]='B12'
res[5]='B12'
res[6]='B12'
res[7]='MERRA2'
res[8]='B4'

res[9]='B24'
res[10]='B24'
res[11]='B24'

ref[0]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[1]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[2]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[3]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[4]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[5]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'

ref[6]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[7]='/home/ytian/Climate-downscaling/Reference/PRISM-MERRA2-daily'

ref[8]='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'

ref[9]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[10]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[11]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'

dim[0]='232 112' 
dim[1]='232 112' 
dim[2]='232 112' 
dim[3]='464 224' 
dim[4]='464 224' 
dim[5]='464 224' 

dim[6]='464 224' 
dim[7]='94 57' 

dim[8]='1405 621' 

#newer addition
dim[9]='232 112'
dim[10]='232 112'
dim[11]='232 112'

# time steps
DJF='810'
JJA='920'


#for i in `seq 0 6`; do
#for i in `seq 7 7`; do
for i in `seq 8 8`; do
#for i in `seq 9 11`; do
  if [ ${res[$i]} == 'B4' ]; then 
    DJF='450'
    JJA='460'
  fi
 
  for reg in AR MCS NE SE; do 
  #for reg in MCS; do 
    mfile=/home/ytian/Climate-downscaling/Buko_regions/${reg}-${res[$i]}.1gd4r

 ./log-PDF-mask ../${exp[$i]}/daily-DJF.1gd4r ${dim[$i]} $DJF $mfile > ../${exp[$i]}/hist_DJF_daily-$reg.txt 
 ./log-PDF-mask ${ref[$i]}/daily-DJF.1gd4r ${dim[$i]} $DJF $mfile > ../${exp[$i]}/hist_DJF_prism-$reg.txt 

 ./log-PDF-rel-mask ../${exp[$i]}/daily-DJF.1gd4r ${dim[$i]} $DJF $mfile > ../${exp[$i]}/rel-hist_DJF_daily-$reg.txt 
 ./log-PDF-rel-mask ${ref[$i]}/daily-DJF.1gd4r ${dim[$i]}  $DJF $mfile > ../${exp[$i]}/rel-hist_DJF_prism-$reg.txt 

 ./log-PDF-mask ../${exp[$i]}/daily-JJA.1gd4r ${dim[$i]} $JJA $mfile  > ../${exp[$i]}/hist_JJA_daily-$reg.txt 
 ./log-PDF-mask ${ref[$i]}/daily-JJA.1gd4r ${dim[$i]} $JJA $mfile > ../${exp[$i]}/hist_JJA_prism-$reg.txt 

 ./log-PDF-rel-mask ../${exp[$i]}/daily-JJA.1gd4r ${dim[$i]} $JJA $mfile > ../${exp[$i]}/rel-hist_JJA_daily-$reg.txt 
 ./log-PDF-rel-mask ${ref[$i]}/daily-JJA.1gd4r ${dim[$i]} $JJA $mfile > ../${exp[$i]}/rel-hist_JJA_prism-$reg.txt 

  done

done


