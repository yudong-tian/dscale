

for yr in 2006 2007 2008 2009; do 
   for mon in `seq -w 12`; do 
    dir=$yr$mon
    if [ ! -d $dir ]; then 
     mkdir $dir 
    fi
    mv ST2rd${dir}* $dir
   done
done
