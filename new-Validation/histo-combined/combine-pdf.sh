
#for g in 1 2 3 4 5; do 
#for g in 6; do 
for g in 7; do 
  
  # size 3808x2878
  for sn in DJF JJA; do
    convert -resize 1904x1439 g${g}_hist_$sn-trim.png tmp/$sn.png
    for reg in AR MCS NE SE; do
      convert -resize 952x720 g${g}_hist_$sn-$reg-trim.png tmp/$sn-$reg.png
    done
  done
  convert +append tmp/DJF.png tmp/JJA.png tmp/row2.png
  convert +append tmp/DJF-AR.png tmp/DJF-NE.png tmp/JJA-AR.png tmp/JJA-NE.png tmp/row3.png
  convert +append tmp/DJF-MCS.png tmp/DJF-SE.png tmp/JJA-MCS.png tmp/JJA-SE.png tmp/row4.png

convert -append g${g}_hist-trim.png tmp/row2.png tmp/row3.png tmp/row4.png g${g}_combined_pdf.png

done

