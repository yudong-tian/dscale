
exp[0]='B24'
exp[1]='B12'
exp[2]='B4'

xdim[0]='XDEF   232 LINEAR    -124.875    0.25'
ydim[0]='YDEF   112 LINEAR      25.125    0.25'
xdim[1]='XDEF   464 LINEAR    -124.9375    0.125'
ydim[1]='YDEF   224 LINEAR      25.0625    0.125'
xdim[2]='XDEF   1405 LINEAR     -125.00 0.04166667'
ydim[2]='YDEF   621 LINEAR    24.0833000   0.04166667'

for i in `seq 0 2`; do

 dir=${exp[$i]}

 xline=${xdim[$i]}
 yline=${ydim[$i]}

   cat > $dir/DJF-monthly.ctl<<EOF
DSET  ^DJF-monthly.1gd4r
options big_endian template
TITLE  $dir 
UNDEF  -9.99E8
$xline
$yline
ZDEF           1 LINEAR          1.0      1.0
TDEF     15    LINEAR 0Z01Jan2000     1mo
VARS     1
rain   1  99  accum rain (mm/mo)
ENDVARS
EOF

   cat > $dir/JJA-monthly.ctl<<EOF2
DSET  ^JJA-monthly.1gd4r
options big_endian template
TITLE  $dir 
UNDEF  -9.99E8
$xline
$yline
ZDEF           1 LINEAR          1.0      1.0
TDEF     15  LINEAR 0Z01Jun2000     1mo
VARS     1
rain   1  99  accum rain (mm/mo)
ENDVARS
EOF2

done 



