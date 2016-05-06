

# interpolates MERRA2 monthly to B24/B12/B4 monthly 

idir=/home/ytian/Climate-downscaling/new-Validation/MERRA2
odir=/home/ytian/Climate-downscaling/new-Validation/MERRA2-interpolated

  cd $odir
  mkdir -p B24/monthly
  mkdir -p B12/monthly
  mkdir -p B4/monthly

  for year in `seq 2000 2010`; do 
    for mon in jan feb mar apr may jun jul aug sep oct nov dec; do 

    sdate="1 $mon $year"   # 1 feb 2010 
    gtime=`date -u -d "$sdate" +%H:%MZ%d%b%Y`

    ifile=$idir/monthly.ctl

    echo $gtime

# B24
ofile=$odir/B24/monthly/$mon$year.1gd4r 
/home/dao_ops/operations/GrADS/Linux-1.9-rc1-gmao/grads -bl <<EOF
open $ifile
set time $gtime
set gxout fwrite
set fwrite -be -st $ofile
d re(rain, 232, linear, -124.875, 0.25, 112, linear, 25.125, 0.25)
disable fwrite
quit
EOF

# B12
ofile=$odir/B12/monthly/$mon$year.1gd4r
/home/dao_ops/operations/GrADS/Linux-1.9-rc1-gmao/grads -bl <<EOF1
open $ifile
set time $gtime
set gxout fwrite
set fwrite -be -st $ofile
d re(rain, 464, linear, -124.9375, 0.125, 224, linear, 25.0625, 0.125)
disable fwrite
quit
EOF1

# B4
ofile=$odir/B4/monthly/$mon$year.1gd4r
/home/dao_ops/operations/GrADS/Linux-1.9-rc1-gmao/grads -bl <<EOF2
open $ifile
set time $gtime
set gxout fwrite
set fwrite -be -st $ofile
d re(rain, 1405, linear, -125.0, 0.04166667, 621, linear, 24.0833, 0.04166667)
disable fwrite
quit
EOF2


   done  # mon
 done  # year 



