
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
for i in `seq 0 11`; do 
  # size 3808x2878 
  for sn in DJF JJA; do 
    convert -resize 1904x1439 ${exp[$i]}/hist_$sn-trim.png /tmp/$sn.png 
    for reg in AR MCS NE SE; do 
      convert -resize 952x720 ${exp[$i]}/hist_$sn-$reg-trim.png /tmp/$sn-$reg.png 
    done
  done 
  convert +append /tmp/DJF.png /tmp/JJA.png /tmp/row2.png 
  convert +append /tmp/DJF-AR.png /tmp/DJF-NE.png /tmp/JJA-AR.png /tmp/JJA-NE.png /tmp/row3.png 
  convert +append /tmp/DJF-MCS.png /tmp/DJF-SE.png /tmp/JJA-MCS.png /tmp/JJA-SE.png /tmp/row4.png 

convert -append ${exp[$i]}/hist_2000_2009-trim.png /tmp/row2.png /tmp/row3.png /tmp/row4.png ${exp[$i]}/combined_pdf.png 

done

