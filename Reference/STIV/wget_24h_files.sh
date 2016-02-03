
 ftpsite=ftp://data.eol.ucar.edu/pub/download/data/krist


# year=2002
# ftppath=${ftpsite}30792
# ftppath=${ftpsite}1066

# year=2003
# ftppath=${ftpsite}18710
# ftppath=${ftpsite}18448

# year=2004
# ftppath=${ftpsite}27188
# ftppath=${ftpsite}6247

# year=2005
# ftppath=${ftpsite}17335
# ftppath=${ftpsite}9586

# year=2006
# ftppath=${ftpsite}24931
# ftppath=${ftpsite}25430

# year=2007
# ftppath=${ftpsite}4757
# ftppath=${ftpsite}21816

# year=2008
# ftppath=${ftpsite}24004
# ftppath=${ftpsite}29310

# year=2009
# ftppath=${ftpsite}12838
# ftppath=${ftpsite}2951

# year=2010
# ftppath=${ftpsite}22106
# ftppath=${ftpsite}11385

# year=2011
# ftppath=${ftpsite}27266
# ftppath=${ftpsite}28023

# year=2012
# ftppath=${ftpsite}32544
# ftppath=${ftpsite}30555

 year=2013
# ftppath=${ftpsite}8462
# ftppath=${ftpsite}16206
 ftppath=${ftpsite}16206

# year=2014
# ftppath=${ftpsite}14820
# ftppath=${ftpsite}20432

  for month in 01 02 03 04 05 06 07 08 09 10 11 12; do
    mkdir -p ${year}${month}
    cd ${year}${month}

     for day in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31; do

###  E.g.,
###   wget ftp://128.117.82.216/pub/download/data/krist17335/ST4.2005010212.24h.Z

     file=ST4.${year}${month}${day}12.24h

#     if [ ${year} -ge "2014" ]; then
     if [ ${year} -ge "2013" ]; then
       wget ${ftppath}/${file}.gz
       gunzip  ${file}.gz
     else
       wget ${ftppath}/${file}.Z
       gunzip  ${file}.Z
     fi

     chmod 775 ${file}

    done
    cd ../
  done

 echo "done."

