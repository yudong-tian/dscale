
exp[0]='B24_0'
exp[1]='B24_600'
exp[2]='B24_2000'
exp[3]='B12_0'
exp[4]='B12_600'
exp[5]='B12_2000'
exp[6]='B4_600'

exp[7]='M2R12K'
exp[8]='MERRA2'

#for i in `seq 0 6`; do
#for i in `seq 7 7`; do
for i in `seq 8 8`; do

cat > ../${exp[$i]}/rel-hist_2000.agr <<EOF 
@    title "Relative rain amount distribution vs. rainrate, 2000" 
@    title size 1.0
@    xaxis label "Rainrate (mm/d)"
@    yaxis label "Rel amount(%)"
@    xaxes scale Logarithmic
@    legend 0.984, 0.85
@    s0 legend "PRISM"
@    s1 legend "${exp[$i]}"
@    s0 line linewidth 3.0
@    s1 line linewidth 2.0
@    world xmin 1
@    world xmax 256
EOF
cat ../${exp[$i]}/rel-hist_2000_prism.txt >> ../${exp[$i]}/rel-hist_2000.agr
echo '&' >> ../${exp[$i]}/rel-hist_2000.agr
cat ../${exp[$i]}/rel-hist_2000_daily.txt >> ../${exp[$i]}/rel-hist_2000.agr

xmgrace -hardcopy -printfile ../${exp[$i]}/rel-hist_2000.ps ../${exp[$i]}/rel-hist_2000.agr

done



