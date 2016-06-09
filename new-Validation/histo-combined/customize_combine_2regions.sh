
# manually edited the agr files to change the ymax values
xmgrace -hardcopy -printfile g3_hist_JJA-CA.ps g3_hist_JJA-CA.agr 
xmgrace -hardcopy -printfile g3_hist_JJA-ME.ps g3_hist_JJA-ME.agr 

xmgrace -hardcopy -printfile g3_hist_DJF-CA.ps g3_hist_DJF-CA.agr 
xmgrace -hardcopy -printfile g3_hist_DJF-ME.ps g3_hist_DJF-ME.agr 


ps2pdf2png.sh g3_hist_DJF-CA.ps g3_hist_DJF-ME.ps g3_hist_JJA-ME.ps g3_hist_JJA-CA.ps


#use montage to control gaps between images 

montage g3_hist_DJF-CA-trim-sm.png g3_hist_DJF-ME-trim-sm.png g3_hist_JJA-CA-trim-sm.png g3_hist_JJA-ME-trim-sm.png -geometry +20+20 CA-ME_combined_pdf.png

#convert +append g3_hist_DJF-CA-trim-sm.png g3_hist_DJF-ME-trim-sm.png tmp/row1.png 
#convert +append g3_hist_JJA-CA-trim-sm.png g3_hist_JJA-ME-trim-sm.png tmp/row2.png 
#convert -append tmp/row1.png tmp/row2.png CA-ME_combined_pdf.png


