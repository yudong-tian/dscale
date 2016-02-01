
# dump prism daily data for 12/1/1999-12/31/2002 

res[0]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
res[1]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
res[2]='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'
res[3]='/home/ytian/Climate-downscaling/Reference/PRISM-MERRA2-daily'

#for i in `seq 0 3`; do
for i in `seq 2 2`; do

grads -bl <<EOF

open ${res[$i]}/ppt.ctl 
set time 1DEC1999 31DEC2002 
set gxout fwrite
set fwrite -be -st ${res[$i]}/1999-2002.1gd4r 
d ppt 
disable fwrite

quit

EOF

done 



