
* dump colocated STIV and B12 data for DJF and JJA 

'open ppt.ctl' 
'set lat 25.125 49.875'
'set lon -124.875 -70.125'

mday = '31 28 31 30 31 30 31 31 30 31 30 31'
month = 'jan feb mar apr may jun jul aug sep oct nov dec'

yr=1999
while(yr<=2010)
  leap = 0
  if(math_mod(yr,400) = 0 | math_mod(yr,4) = 0 & math_mod(yr,100) != 0)
   leap = 1
   say yr' is a leap year.'
  endif
  imon = 1
  while(imon <= 12)
   md = subwrd(mday,imon)
   mc = subwrd(month,imon)
   if(imon = 2); md = md + leap; endif;
   time1 = '01'mc''yr
   time2 = md''mc''yr
   say time1' 'time2
   'set gxout fwrite'
   'set fwrite -be -st monthly/'mc''yr'.1gd4r' 
   'd sum(ppt,time='time1',time='time2')'
   'disable fwrite'
   imon = imon + 1
  endwhile
  yr = yr + 1
 endwhile

'quit'


