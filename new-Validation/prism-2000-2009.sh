
# dump prism daily data for 2000 

res[0]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
res[1]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
res[2]='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'
res[3]='/home/ytian/Climate-downscaling/Reference/PRISM-MERRA2-daily'

for i in `seq 0 3`; do

grads -bl <<EOF

open ${res[$i]}/ppt.ctl 
set time 1JAN2000 31DEC2009 
set gxout fwrite
set fwrite -be -st ${res[$i]}/2000-2009.1gd4r 
d ppt 
disable fwrite

quit

EOF

done 



