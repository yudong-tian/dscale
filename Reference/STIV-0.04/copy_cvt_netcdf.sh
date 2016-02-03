#!/bin/bash
# Copy file over and convert to nctcdf 

idir=/discover/nobackup/projects/dscale/ytian/Reference/STIV/

for year in 2005 2006; do
 for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do

     dir="$year$mon"
     mkdir $dir
     cp -p $idir/$dir/*-0.04.1gd4r $dir/
     
     mkdir tmp
     for file in `ls $dir/*.1gd4r`; do
       ctl=`basename $file`.ctl
       ncfile=`echo $file |sed 's/.1gd4r$/.nc/'`
       cat > tmp/$ctl<<EOF
DSET  $file 
options big_endian 
TITLE  ST4 reprojected to 0.04
UNDEF  -9999
XDEF   1375 LINEAR        -125.02 0.04
YDEF   600 LINEAR         24.06 0.04
ZDEF    1   LINEAR           1    1
TDEF   1 LINEAR  00Z01nov2005    1hr
VARS     1
apcpsfc  1  99  rain (mm)
ENDVARS
 
EOF

      cdo -f nc import_binary tmp/$ctl $ncfile 
     done

  done
done

