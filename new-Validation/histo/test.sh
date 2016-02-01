
exp[0]='B24_0'
exp[1]='B24_600'
exp[2]='B24_2000'
exp[3]='B12_0'
exp[4]='B12_600'
exp[5]='B12_2000'

exp[6]='M2R12K'
exp[7]='MERRA2'

exp[8]='B4_600'

for i in `seq 0 0`; do
 for sn in DJF; do 
   for reg in AR; do 

cat > ../${exp[$i]}/hist_$sn-$reg.agr <<EOF 
#
@version 50109
@    title "Rain amount distribution vs. rainrate, $reg $sn 2000-2009" 
@    title size 1.0
@    xaxis label "Rainrate (mm/d)"
@    yaxis label "Amount (mm/grid/day)"
@    xaxes scale Logarithmic
@    legend 0.984, 0.85
@    s0 legend "PRISM"
@    s1 legend "${exp[$i]}"
@    s0 line linewidth 3.0
@    s1 line linewidth 2.0
@    world xmin 1
@    world xmax 256
@    world ymin 0
@    world ymax 0.3


EOF
cat ../${exp[$i]}/hist_${sn}_prism-$reg.txt >> ../${exp[$i]}/hist_$sn-$reg.agr
echo '&' >> ../${exp[$i]}/hist_$sn-$reg.agr
cat ../${exp[$i]}/hist_${sn}_daily-$reg.txt >> ../${exp[$i]}/hist_$sn-$reg.agr

xmgrace -hardcopy -printfile ../${exp[$i]}/hist_$sn-$reg.ps ../${exp[$i]}/hist_$sn-$reg.agr

   done # reg
  done #sn 

done  # i



