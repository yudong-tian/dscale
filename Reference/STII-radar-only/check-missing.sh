

for yr in 2006 2007 2008 2009; do 
   for mon in `seq -w 12`; do 
     dir=$yr$mon
     for dy in `cal $mon $yr |tail +3`; do 
      ldy=$dy
      if [ $dy -lt 10 ]; then
          ldy=0$dy
      fi
      for hr in `seq -w 0 23`; do 
        file=$dir/ST2rd${dir}${ldy}${hr}.Grb.Z 
        if [ ! -f $file ]; then
         echo $file is missing 
        fi
     done
    done
  done
done
