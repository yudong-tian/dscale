
* 12/10/2014
* dump colocated STIV and B12 data for DJF and JJA 

'open ppt.ctl' 

ssn='DJF'
stime ='01dec' 
etime ='28feb' 

'set gxout fwrite'
'set fwrite -be -st daily-'ssn'.1gd4r'
tsum=0
syr=1999
while (syr < 2010) 

 eyr=syr+1
 'set lat 25.0625 49.9375'
 'set lon -124.9375 -70.0625' 
 'set time 'stime''syr' 'etime''eyr 
 'q dims'
 line=sublin(result, 5) 
 t1=subwrd(line, 11)
 t2=subwrd(line, 13)
 say 't1= 't1'  t2='t2 
 'd ppt' 
 tsum=tsum+t2-t1+1

 syr=syr+1
endwhile
'disable fwrite' 
say "total time steps="tsum


ssn='JJA'
stime ='01jun' 
etime ='31aug' 

'set gxout fwrite'
'set fwrite -be -st daily-'ssn'.1gd4r'
tsum=0
syr=2000
while (syr < 2011)

 eyr=syr
 'set lat 25.0625 49.9375'
 'set lon -124.9375 -70.0625' 
 'set time 'stime''syr' 'etime''eyr
 'q dims'
 line=sublin(result, 5) 
 t1=subwrd(line, 11)
 t2=subwrd(line, 13)
 say 't1= 't1'  t2='t2 
 'd ppt' 
 tsum=tsum+t2-t1+1

 syr=syr+1
endwhile
'disable fwrite'
say "total time steps="tsum

'quit'


