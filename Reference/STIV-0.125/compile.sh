#f90 -P -o 4km-0.25 4km-0.25.f ../LIB/iplib_32_pclinux ../LIB/w3lib_32_pclinux ../LIB/bacio_32_pclinux 
#libpath="/trmm1/halem/LISv4.2/src/lib/pc-32/linux_absoft"
#libpath="/data1/jim/lis/4.0/release-4.0/lib/pc-32/linux_absoft"
libpath="$HOME/lib"
echo $libpath


ifort -g -convert big_endian -assume byterecl -o 4km-0.125 4km-0.125.F90 $libpath/iplib_64 $libpath/w3lib.a $libpath/libbacio.a

exit 

ifort -g -convert big_endian -assume byterecl -o 4km-0.04 4km-0.04.F90 $libpath/iplib_64 $libpath/w3lib.a $libpath/libbacio.a
ifort -g -convert big_endian -assume byterecl -o 4km-0.25 4km-0.25.F90 $libpath/iplib_64 $libpath/w3lib.a $libpath/libbacio.a
ifort -g -convert big_endian -assume byterecl -o 4km-0.25-daily 4km-0.25-daily.F90 $libpath/iplib_64 $libpath/w3lib.a $libpath/libbacio.a
#ifort  -o 4km-0.04 4km-0.04.F90 $libpath/iplib/iplib.a $libpath/w3lib.a $libpath/libbacio.a


exit

f90 -YEXT_NAMES=LCS -s -B108 -YCFRL=1 -o 4km-0.25 4km-0.25.F90 $libpath/iplib_32_pclinux $libpath/w3lib_32_pclinux $libpath/bacio_32_pclinux -lU77
f90 -YEXT_NAMES=LCS -s -B108 -YCFRL=1 -o 4km-0.25-daily 4km-0.25-daily.F90 $libpath/iplib_32_pclinux $libpath/w3lib_32_pclinux $libpath/bacio_32_pclinux -lU77

f90 -YEXT_NAMES=LCS -s -B108 -YCFRL=1 -o 4km-0.04 4km-0.04.F90 $libpath/iplib_32_pclinux $libpath/w3lib_32_pclinux $libpath/bacio_32_pclinux -lU77

