
exp[0]='B24_600_BMJ'
exp[1]='B24_600_NKF'
exp[2]='B24_600_NSAS'
exp[3]='B24_0'
exp[4]='B24_600'
exp[5]='B24_2000'
exp[6]='B12_0'
exp[7]='B12_600'
exp[8]='B12_2000'
exp[9]='M2R12K'
exp[10]='MERRA2'
exp[11]='B4_600'


# bias 
for row in `seq 4`; do 
 for col in `seq 3`; do 
   let i=(row-1)*3+col-1
  
   img=${exp[$i]}/sm-DJF-daily-metrics-vs-xy.png
   new=${exp[$i]}/tmp-bias-vs-xy.png 
   lnew=${exp[$i]}/sm-bias-vs-xy.png 
   convert -crop 500x375+0+375 $img $new 
   #convert -pointsize 55 -font helvetica -fill black -draw "text 100,100 '${exp[$i]}'"        $new $lnew 
   convert -pointsize 55 -font helvetica -fill green -draw "text 100,100 '${exp[$i]}'"  -fill red -draw "rectangle 64 0 100 128"      $new $lnew 
 done
   convert +append ${exp[$i]}/sm-bias-vs-xy.png ${exp[$i]}/sm-bias-vs-xy.png ${exp[$i]}/sm-bias-vs-xy.png row_${row}.png
done

convert -append row_1.png row_2.png row_3.png row_4.png sm-bias-vs-xy.png 

