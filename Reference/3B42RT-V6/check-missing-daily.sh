

for yr in 02 03 04 05 06 07 08; do 
  lyr=20$yr
 for mon in 01 02 03 04 05 06 07 08 09 10 11 12; do 
  cd $lyr$mon
  for dy in `cal $mon $lyr |tail -n +3`; do
        ldy=$dy
        if [ $dy -lt 10 ]; then
          ldy="0$dy"
        fi
        dfile=3B42RT.${lyr}${mon}${ldy}
        if [ ! -f $dfile -o ! -s $dfile ]; then
           echo $dfile
        fi

   done
  cd ..

 done
done
