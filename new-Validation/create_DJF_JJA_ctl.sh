
exp[0]='B24_0'
exp[1]='B24_600'
exp[2]='B24_2000'
exp[3]='B12_0'
exp[4]='B12_600'
exp[5]='B12_2000'
exp[6]='B4_600'
exp[7]='M2R12K'
exp[8]='MERRA2'
exp[9]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
exp[10]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
exp[11]='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'
exp[12]='/home/ytian/Climate-downscaling/Reference/PRISM-MERRA2-daily'

#newer addition
exp[13]='B24_600_BMJ'
exp[14]='B24_600_NKF'
exp[15]='B24_600_NSAS'

resolution[0]='B24'
resolution[1]='B24'
resolution[2]='B24'
resolution[3]='B12'
resolution[4]='B12' 
resolution[5]='B12'
resolution[6]='B4' 
resolution[7]='M2R12K' 
resolution[8]='MERRA2'
resolution[9]='B24' 
resolution[10]='B12' 
resolution[11]='B4' 
resolution[12]='MERRA2' 
resolution[13]='B24'
resolution[14]='B24'
resolution[15]='B24'

#for i in `seq 0 15`; do
for i in `seq 6 6`; do

 res=${resolution[$i]} 
 dir=${exp[$i]}

# B24 ========================================================
 if [ $res == "B24" ]; then   
   echo $dir is $res
   cat > $dir/daily-DJF.ctl<<EOF
DSET  ^daily-DJF.1gd4r
options big_endian template
TITLE  $dir 
UNDEF  -9.99E8
XDEF         232 LINEAR    -124.875    0.25
YDEF         112 LINEAR      25.125    0.25
ZDEF           1 LINEAR          1.0      1.0
TDEF     810   LINEAR 0Z01Dec2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF

   cat > $dir/daily-JJA.ctl<<EOF2
DSET  ^daily-JJA.1gd4r
options big_endian template
TITLE  $dir 
UNDEF  -9.99E8
XDEF         232 LINEAR    -124.875    0.25
YDEF         112 LINEAR      25.125    0.25
ZDEF           1 LINEAR          1.0      1.0
TDEF     920 LINEAR 0Z01Jun2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF2

 fi


# B12 ========================================================
 if [ $res == "B12" -o $res == "M2R12K" ]; then   
   echo ${exp[$i]} is $res

   cat > $dir/daily-DJF.ctl<<EOF
DSET  ^daily-DJF.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9.99E8
XDEF         464 LINEAR    -124.9375    0.125
YDEF         224 LINEAR      25.0625    0.125
ZDEF           1 LINEAR          1.0      1.0
TDEF     810   LINEAR 0Z01Dec2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF

   cat > $dir/daily-JJA.ctl<<EOF2
DSET  ^daily-JJA.1gd4r
options big_endian template
TITLE  $dir 
UNDEF  -9.99E8
XDEF         464 LINEAR    -124.9375    0.125
YDEF         224 LINEAR      25.0625    0.125
ZDEF           1 LINEAR          1.0      1.0
TDEF     920 LINEAR 0Z01Jun2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF2

 fi

# B4 ========================================================
 if [ $res == "B4" ]; then   
   echo ${exp[$i]} is $res 

   cat > $dir/daily-DJF.ctl<<EOF
DSET  ^daily-DJF.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9.99E8
XDEF   1405 LINEAR        -125.00 0.04166667
YDEF   621 LINEAR         24.0833000   0.04166667
ZDEF           1 LINEAR          1.0      1.0
TDEF     450   LINEAR 0Z01Dec2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF

   cat > $dir/daily-JJA.ctl<<EOF2
DSET  ^daily-JJA.1gd4r
options big_endian template
TITLE  $dir 
UNDEF  -9.99E8
XDEF   1405 LINEAR        -125.00 0.04166667
YDEF   621 LINEAR         24.0833000   0.04166667
ZDEF           1 LINEAR          1.0      1.0
TDEF     460 LINEAR 0Z01Jun2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF2

 fi

# MERRA2 ========================================================
 if [ $res == "MERRA2" ]; then
   echo ${exp[$i]} is $res

   cat > $dir/daily-DJF.ctl<<EOF
DSET  ^daily-DJF.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9.99E8
XDEF         94 LINEAR    -125    0.625
YDEF         57 LINEAR      25    0.5
ZDEF           1 LINEAR          1.0      1.0
TDEF     810   LINEAR 0Z01Dec2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF

   cat > $dir/daily-JJA.ctl<<EOF2
DSET  ^daily-JJA.1gd4r
options big_endian template
TITLE  $dir 
UNDEF  -9.99E8
XDEF         94 LINEAR    -125    0.625
YDEF         57 LINEAR      25    0.5
ZDEF           1 LINEAR          1.0      1.0
TDEF     920 LINEAR 0Z01Jun2000     24hr
VARS     1
rain   1  99  accum rain (mm/d)
ENDVARS
EOF2

 fi



done 


