
* daily to monthly 

exp.1='B24_0'
exp.2='B24_600'
exp.3='B24_2000' 
exp.4='B12_0' 
exp.5='B12_600' 
exp.6='B12_2000'
exp.7='M2R12K' 
exp.8='MERRA2' 

exp.9='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily' 
exp.10='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily' 
exp.11='/home/ytian/Climate-downscaling/Reference/PRISM-MERRA2-daily' 

exp.12='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily' 
exp.13='B4_600' 

#newer addition
exp.14='B24_600_BMJ' 
exp.15='B24_600_NKF' 
exp.16='B24_600_NSAS' 

mday = '31 28 31 30 31 30 31 31 30 31 30 31'
month = 'jan feb mar apr may jun jul aug sep oct nov dec'

#ndat=16 
ndat=12 

#id=1
id=12
while (id <= ndat) 

'reinit'

say 'opening 'exp.id'/2000-2009.ctl'
'open 'exp.id'/2000-2009.ctl' 
'!mkdir 'exp.id'/monthly' 

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
   'set fwrite -be -st 'exp.id'/monthly/'mc''yr'.1gd4r'
   'define mrain=sum(rain,time='time1',time='time2')'
   'd mrain' 
   'disable fwrite'
   imon = imon + 1
  endwhile
  yr = yr + 1
 endwhile

id=id+1

endwhile 

'quit'
