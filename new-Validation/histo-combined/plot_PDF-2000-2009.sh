
#plot in three groups

exp[0]='B24_0'
exp[1]='B24_2000'
exp[2]='B24_600'

exp[3]='B12_0'
exp[4]='B12_2000'
exp[5]='B12_600'

#exp[6]='MERRA2'
#exp[7]='M2R12K'
exp[6]='B24_600'
exp[7]='B12_600'
exp[8]='B4_600'

#newer addition
exp[9]='B24_600_BMJ'
exp[10]='B24_600_NKF'
exp[11]='B24_600_NSAS'

exp[12]='MERRA2'
exp[13]='M2R12K'
exp[14]='B4_600'

for g in 1 2 3 4 5; do 
 let ga=(g-1)*3
 let gb=(g-1)*3+1
 let gc=(g-1)*3+2

echo ga=$ga gb=$gb gc=$gc
agrf=g${g}_hist.agr
psf=g${g}_hist.ps 
cat > $agrf <<EOF
@version 50109
@    title "Rain amount distribution vs. rainrate, 2000-2009" 
@    title size 1.6
@    xaxis label char size 1.6
@    xaxis ticklabel char size 1.2
@    yaxis label char size 1.6
@    yaxis ticklabel char size 1.2
@    xaxis label "Rainrate (mm/d)"
@    yaxis label "Amount (mm/grid/day)"
@    yaxis tick major 0.05 
@    xaxes scale Logarithmic
@    xaxis tick major 2 
@    legend 0.80, 0.85
@    s0 legend "PRISM"
@    s1 legend "${exp[$ga]}"
@    s2 legend "${exp[$gb]}"
@    s3 legend "${exp[$gc]}"
@    s0 line linewidth 3.0
@    s1 line linewidth 2.0
@    s2 line linewidth 2.0
@    s3 line linewidth 2.0
@    s3 linestyle 3
@    world xmin 1
@    world xmax 256
@    world ymin 0
@    world ymax 0.3
EOF
cat ../${exp[$gc]}/hist_2000-2009_prism.txt >> $agrf 
echo '&' >> $agrf 
 cat ../${exp[$ga]}/hist_2000-2009_daily.txt >> $agrf 
 echo '&' >> $agrf 
 cat ../${exp[$gb]}/hist_2000-2009_daily.txt >> $agrf 
 echo '&' >> $agrf 
 cat ../${exp[$gc]}/hist_2000-2009_daily.txt >> $agrf 

xmgrace -hardcopy -printfile $psf $agrf

# separate seasons
  for sn in DJF JJA; do

agrf=g${g}_hist_$sn.agr
psf=g${g}_hist_$sn.ps
cat > $agrf <<EOF
@version 50109
@    title "Rain amount distribution vs. rainrate, $sn 2000-2009"
@    title size 1.6
@    xaxis label char size 1.6
@    xaxis ticklabel char size 1.2
@    yaxis label char size 1.6
@    yaxis ticklabel char size 1.2
@    xaxis label "Rainrate (mm/d)"
@    yaxis label "Amount (mm/grid/day)"
@    yaxis tick major 0.05
@    xaxes scale Logarithmic
@    xaxis tick major 2
@    legend 0.80, 0.85
@    s0 legend "PRISM"
@    s1 legend "${exp[$ga]}"
@    s2 legend "${exp[$gb]}"
@    s3 legend "${exp[$gc]}"
@    s0 line linewidth 3.0
@    s1 line linewidth 2.0
@    s2 line linewidth 2.0
@    s3 line linewidth 2.0
@    s3 linestyle 3
@    world xmin 1
@    world xmax 256
@    world ymin 0
@    world ymax 0.3
EOF
cat ../${exp[$gc]}/hist_${sn}_prism.txt >> $agrf
echo '&' >> $agrf
 cat ../${exp[$ga]}/hist_${sn}_daily.txt >> $agrf
 echo '&' >> $agrf
 cat ../${exp[$gb]}/hist_${sn}_daily.txt >> $agrf
 echo '&' >> $agrf
 cat ../${exp[$gc]}/hist_${sn}_daily.txt >> $agrf

xmgrace -hardcopy -printfile $psf $agrf

# four regions 
  for reg in AR MCS NE SE; do
  agrf=g${g}_hist_$sn-$reg.agr
  psf=g${g}_hist_$sn-$reg.ps

cat > $agrf <<EOF
@version 50109
@    title "Rain amount distribution vs. rainrate, $reg $sn 2000-2009"
@    title size 1.6
@    xaxis label char size 1.6
@    xaxis ticklabel char size 1.2
@    yaxis label char size 1.6
@    yaxis ticklabel char size 1.2
@    xaxis label "Rainrate (mm/d)"
@    yaxis label "Amount (mm/grid/day)"
@    yaxis tick major 0.05
@    xaxes scale Logarithmic
@    xaxis tick major 2
@    legend 0.85, 0.85
@    s0 legend "PRISM"
@    s1 legend "${exp[$ga]}"
@    s2 legend "${exp[$gb]}"
@    s3 legend "${exp[$gc]}"
@    s0 line linewidth 3.0
@    s1 line linewidth 3.0
@    s2 line linewidth 3.0
@    s3 line linewidth 3.0
@    s3 linestyle 3
@    world xmin 1
@    world xmax 256
@    world ymin 0
@    world ymax 0.3
EOF
cat ../${exp[$gc]}/hist_${sn}_prism-$reg.txt >> $agrf
echo '&' >> $agrf
 cat ../${exp[$ga]}/hist_${sn}_daily-$reg.txt >> $agrf
 echo '&' >> $agrf
 cat ../${exp[$gb]}/hist_${sn}_daily-$reg.txt >> $agrf
 echo '&' >> $agrf
 cat ../${exp[$gc]}/hist_${sn}_daily-$reg.txt >> $agrf

xmgrace -hardcopy -printfile $psf $agrf

  done #region 

 done #season



done   #group


