#!/bin/bash
# Copy file over and convert to nctcdf 

idir=/discover/nobackup/projects/dscale/ytian/Reference/STIV/

for year in 2005 2006; do
 for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do

     dir="$year$mon"
     mkdir $dir
     cp -p $idir/$dir/*01h.1gd4r $dir/
     
     mkdir tmp
     for file in `ls $dir/*01h.1gd4r`; do
       bname=`basename $file`
       ctl=${bname}.ctl
       nfile=`echo $dir/${bname} |sed 's/.1gd4r$/-0.25.1gd4r/'`
       # insert 0.25 in filename 
       mv $file $nfile 
       ncfile=`echo $nfile |sed 's/.1gd4r$/.nc/'`
       cat > tmp/$ctl<<EOF
DSET  $nfile 
options big_endian 
TITLE  ST4 reprojected to 0.04
UNDEF  -9999
XDEF   240 LINEAR        -130.125 0.25
YDEF   120 LINEAR         20.875 0.25
ZDEF    1   LINEAR           1    1
VARS     1
apcpsfc  1  99  rain (mm)
ENDVARS
 
EOF
      cdo -f nc import_binary tmp/$ctl $ncfile 
     done

  done
done

