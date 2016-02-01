
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

for i in `seq 0 11`; do

cd ${exp[$i]} 
 chmod go+r *daily*.png
cd ..


scp ${exp[$i]}/*daily*.png sigma.umd.edu:/data/www/ytian/Climate-downscaling/new-Validation/${exp[$i]}/

done 




