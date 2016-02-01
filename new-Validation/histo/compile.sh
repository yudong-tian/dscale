ifort -convert big_endian -assume byterecl -o log-PDF-mask log-PDF-mask.F90
ifort -convert big_endian -assume byterecl -o log-PDF-rel-mask log-PDF-rel-mask.F90

ifort -convert big_endian -assume byterecl -o log-PDF log-PDF.F90
ifort -convert big_endian -assume byterecl -o log-PDF-rel log-PDF-rel.F90
exit
