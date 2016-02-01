
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

#for i in `seq 0 8`; do
#for i in `seq 8 8`; do
for i in `seq 6 6`; do
#for i in `seq 9 11`; do

cd ${exp[$i]} 
 ps2pdf2png.sh *.ps
 chmod go+r *
cd ..


scp ${exp[$i]}/*.png sigma.umd.edu:/data/www/ytian/Climate-downscaling/new-Validation/${exp[$i]}/

done 




