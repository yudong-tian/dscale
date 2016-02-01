
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

#for i in `seq 0 7`; do
for i in `seq 9 11`; do
 for sn in DJF JJA; do 

cat > ../${exp[$i]}/hist_$sn.agr <<EOF 
@    title "Rain amount distribution vs. rainrate, $sn 2000-2009" 
@    title size 1.0
@    xaxis label "Rainrate (mm/d)"
@    yaxis label "Amount (mm/grid/day)"
@    xaxes scale Logarithmic
@    legend 0.884, 0.85
@    s0 legend "PRISM"
@    s1 legend "${exp[$i]}"
@    s0 line linewidth 3.0
@    s1 line linewidth 2.0
@    world xmin 1
@    world xmax 256
EOF
cat ../${exp[$i]}/hist_${sn}_prism.txt >> ../${exp[$i]}/hist_$sn.agr
echo '&' >> ../${exp[$i]}/hist_$sn.agr
cat ../${exp[$i]}/hist_${sn}_daily.txt >> ../${exp[$i]}/hist_$sn.agr

xmgrace -hardcopy -printfile ../${exp[$i]}/hist_$sn.ps ../${exp[$i]}/hist_$sn.agr


cat > ../${exp[$i]}/rel-hist_$sn.agr <<EOF1
@    title "Relative rain amount distribution vs. rainrate, $sn 2000-2009"
@    title size 1.0
@    xaxis label "Rainrate (mm/d)"
@    yaxis label "Rel amount(%)"
@    xaxes scale Logarithmic
@    legend 0.884, 0.85
@    s0 legend "PRISM"
@    s1 legend "${exp[$i]}"
@    s0 line linewidth 3.0
@    s1 line linewidth 2.0
@    world xmin 1
@    world xmax 256
EOF1
cat ../${exp[$i]}/rel-hist_${sn}_prism.txt >> ../${exp[$i]}/rel-hist_$sn.agr
echo '&' >> ../${exp[$i]}/rel-hist_$sn.agr
cat ../${exp[$i]}/rel-hist_${sn}_daily.txt >> ../${exp[$i]}/rel-hist_$sn.agr

xmgrace -hardcopy -printfile ../${exp[$i]}/rel-hist_$sn.ps ../${exp[$i]}/rel-hist_$sn.agr

  done #sn 

done  # i



