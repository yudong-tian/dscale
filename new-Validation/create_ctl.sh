
exp[0]='B24_0'
exp[1]='B24_600'
exp[2]='B24_2000'
exp[3]='B12_0'
exp[4]='B12_600'
exp[5]='B12_2000'
exp[6]='B4_600'

#newer addition
exp[7]='B24_600_BMJ'
exp[8]='B24_600_NKF'
exp[9]='B24_600_NSAS'

#
exp[10]='B24_600_G3D_0sh'
exp[11]='B24_600_BMJ_0sh'
exp[12]='B24_600_NKF_0sh'
exp[13]='B24_600_NSAS_0sh'

#for i in `seq 0 6`; do
#for i in `seq 7 9`; do
for i in `seq 10 13`; do

 res=`echo ${exp[$i]} | cut -d '_' -f 1`
 dir=${exp[$i]}

# B12 ========================================================
 if [ $res == "B24" ]; then   
   echo $dir is B24 
   cat > $dir/rainc.ctl<<EOF
DSET  ^%y4%m2%d2/rainc_%y4_%m2_%d2.1gd4r
options big_endian template
TITLE  $dir 
UNDEF  -9999
pdef 331 156 lcc 36.2989 -93.6219 166 78 15 15 -93 24000 24000
XDEF   331 LINEAR        -130.125 0.25
YDEF   156 LINEAR         20.875 0.25
ZDEF    1   LINEAR           1    1
TDEF   96432 LINEAR  00Z01nov1999    1hr
VARS     1
rainc   1  99  accum rain (mm)
ENDVARS
EOF


   cat > $dir/rainnc.ctl <<EOF1
DSET  ^%y4%m2%d2/rainnc_%y4_%m2_%d2.1gd4r
options big_endian template
TITLE  $dir 
UNDEF  -9999
pdef 331 156 lcc 36.2989 -93.6219 166 78 15 15 -93 24000 24000
XDEF   331 LINEAR        -130.125 0.25
YDEF   156 LINEAR         20.875 0.25
ZDEF    1   LINEAR           1    1
TDEF   96432 LINEAR  00Z01nov1999    1hr
VARS     1
rainnc   1  99  accum rain (mm)
ENDVARS
EOF1

   cat > $dir/rain_daily.ctl <<EOF2
DSET  ^%y4%m2%d2/rain_daily.1gd4r
options big_endian template
TITLE  $dir 
UNDEF  -9.99E8
XDEF   331 LINEAR        -130.125 0.25
YDEF   156 LINEAR         20.875 0.25
ZDEF    1   LINEAR           1    1
TDEF   4018 LINEAR  00Z01nov1999    24hr
VARS     1
rain   1  99  accum rain (mm)
ENDVARS
EOF2

 fi


# B12 ========================================================
 if [ $res == "B12" ]; then   
   echo ${exp[$i]} is B12 

   cat > $dir/rainc.ctl<<EOF3
DSET  ^%y4%m2%d2/rainc_%y4_%m2_%d2.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9999
pdef 662 312 lcc 36.2989 -93.6219 331 156 15 15 -93 12000 12000
XDEF         464 LINEAR    -124.9375    0.125
YDEF         224 LINEAR      25.0625    0.125
ZDEF    1   LINEAR           1    1
TDEF   96432 LINEAR  00Z01nov1999    1hr
VARS     1
rainc   1  99  accum rain (mm)
ENDVARS
EOF3


   cat > $dir/rainnc.ctl <<EOF4
DSET  ^%y4%m2%d2/rainnc_%y4_%m2_%d2.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9999
pdef 662 312 lcc 36.2989 -93.6219 331 156 15 15 -93 12000 12000
XDEF         464 LINEAR    -124.9375    0.125
YDEF         224 LINEAR      25.0625    0.125
ZDEF    1   LINEAR           1    1
TDEF   96432 LINEAR  00Z01nov1999    1hr
VARS     1
rainnc   1  99  accum rain (mm)
ENDVARS
EOF4

   cat > $dir/rain_daily.ctl <<EOF5
DSET  ^%y4%m2%d2/rain_daily.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9.99E8
XDEF         464 LINEAR    -124.9375    0.125
YDEF         224 LINEAR      25.0625    0.125
ZDEF    1   LINEAR           1    1
TDEF   4018 LINEAR  00Z01nov1999    24hr
VARS     1
rain   1  99  accum rain (mm)
ENDVARS
EOF5

 fi

# B4 ========================================================
 if [ $res == "B4" ]; then   
   echo ${exp[$i]} is B4 

   cat > $dir/rainc.ctl<<EOF6
DSET  ^%y4%m2%d2/rainc_%y4_%m2_%d2.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9999
pdef 1986 936 lcc 36.299 -93.6222 993 468 15 15 -93 4000 4000
XDEF   1405 LINEAR        -125.00 0.04166667
YDEF   621 LINEAR         24.0833000   0.04166667
ZDEF    1   LINEAR           1    1
TDEF   96432 LINEAR  00Z01nov1999    1hr
VARS     1
rainc   1  99  accum rain (mm)
ENDVARS
EOF6


   cat > $dir/rainnc.ctl <<EOF7
DSET  ^%y4%m2%d2/rainnc_%y4_%m2_%d2.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9999
pdef 1986 936 lcc 36.299 -93.6222 993 468 15 15 -93 4000 4000
XDEF   1405 LINEAR        -125.00 0.04166667
YDEF   621 LINEAR         24.0833000   0.04166667
ZDEF    1   LINEAR           1    1
TDEF   96432 LINEAR  00Z01nov1999    1hr
VARS     1
rainnc   1  99  accum rain (mm)
ENDVARS
EOF7

   cat > $dir/rain_daily.ctl <<EOF8
DSET  ^%y4%m2%d2/rain_daily.1gd4r
options big_endian template
TITLE  $dir
UNDEF  -9.99E8
XDEF   1405 LINEAR        -125.00 0.04166667
YDEF   621 LINEAR         24.0833000   0.04166667
ZDEF    1   LINEAR           1    1
TDEF   4018 LINEAR  00Z01nov1999    24hr
VARS     1
rain   1  99  accum rain (mm)
ENDVARS
EOF8

 fi

done 


