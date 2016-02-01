
exp[0]='B24_0'
exp[1]='B24_600'
exp[2]='B24_2000'
exp[3]='B12_0'
exp[4]='B12_600'
exp[5]='B12_2000'
exp[6]='B4_600'

exp[7]='M2R12K'
exp[8]='MERRA2'

#newer addition
exp[9]='B24_600_BMJ'
exp[10]='B24_600_NKF'
exp[11]='B24_600_NSAS'

ref[0]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[1]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[2]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[3]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[4]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[5]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[6]='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'

ref[7]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[8]='/home/ytian/Climate-downscaling/Reference/PRISM-MERRA2-daily'

ref[9]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[10]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[11]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'

#for i in `seq 0 8`; do
for i in `seq 6 6`; do
#for i in `seq 9 11`; do

 res=`echo ${exp[$i]} | cut -d '_' -f 1`
 dir=${exp[$i]}

# B24 ========================================================
 if [ $res == "B24" ]; then   
   echo $dir is $res
   cat > $dir/2000-2009.ctl<<EOF
DSET  ^2000-2009_daily.1gd4r
options big_endian template
TITLE  $dir 
UNDEF  -9.99E8
XDEF         232 LINEAR    -124.875    0.25
YDEF         112 LINEAR      25.125    0.25
ZDEF           1 LINEAR          1.0      1.0
TDEF     3653 LINEAR 0Z01Jan2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF

   cat > ${ref[$i]}/2000-2009.ctl<<EOF2
DSET  ^2000-2009.1gd4r
options big_endian template
TITLE  ${ref[$i]} 
UNDEF  -9.99E8
XDEF         232 LINEAR    -124.875    0.25
YDEF         112 LINEAR      25.125    0.25
ZDEF           1 LINEAR          1.0      1.0
TDEF     3653 LINEAR 0Z01Jan2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF2

 fi


# B12 ========================================================
 if [ $res == "B12" -o $res == "M2R12K" ]; then   
   echo ${exp[$i]} is $res

   cat > $dir/2000-2009.ctl<<EOF
DSET  ^2000-2009_daily.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9.99E8
XDEF         464 LINEAR    -124.9375    0.125
YDEF         224 LINEAR      25.0625    0.125
ZDEF           1 LINEAR          1.0      1.0
TDEF     3653 LINEAR 0Z01Jan2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF

   cat > ${ref[$i]}/2000-2009.ctl<<EOF2
DSET  ^2000-2009.1gd4r
options big_endian template
TITLE  ${ref[$i]}
UNDEF  -9.99E8
XDEF         464 LINEAR    -124.9375    0.125
YDEF         224 LINEAR      25.0625    0.125
ZDEF           1 LINEAR          1.0      1.0
TDEF     3653 LINEAR 0Z01Jan2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF2

 fi

# B4 ========================================================
 if [ $res == "B4" ]; then   
   echo ${exp[$i]} is $res 

   cat > $dir/1999-2004.ctl<<EOF
DSET  ^1999-2004_daily.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9.99E8
XDEF   1405 LINEAR        -125.00 0.04166667
YDEF   621 LINEAR         24.0833000   0.04166667
ZDEF           1 LINEAR          1.0      1.0
TDEF     1858 LINEAR 0Z01Dec1999     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF

   cat > ${ref[$i]}/1999-2004.ctl<<EOF2
DSET  ^1999-2004.1gd4r
options big_endian template
TITLE  ${ref[$i]}
UNDEF  -9.99E8
XDEF   1405 LINEAR        -125.00 0.04166667
YDEF   621 LINEAR         24.0833000   0.04166667
ZDEF           1 LINEAR          1.0      1.0
TDEF     1858 LINEAR 0Z01Dec1999     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF2

 fi

# MERRA2 ========================================================
 if [ $res == "MERRA2" ]; then
   echo ${exp[$i]} is $res

   cat > $dir/2000-2009.ctl<<EOF
DSET  ^2000-2009_daily.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9.99E8
XDEF         94 LINEAR    -125    0.625
YDEF         57 LINEAR      25    0.5
ZDEF           1 LINEAR          1.0      1.0
TDEF     3653 LINEAR 0Z01Jan2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF

   cat > ${ref[$i]}/2000-2009.ctl<<EOF2
DSET  ^2000-2009.1gd4r
options big_endian template
TITLE  ${ref[$i]}
UNDEF  -9.99E8
XDEF         94 LINEAR    -125    0.625
YDEF         57 LINEAR      25    0.5
ZDEF           1 LINEAR          1.0      1.0
TDEF     3653 LINEAR 0Z01Jan2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF2

 fi



done 


