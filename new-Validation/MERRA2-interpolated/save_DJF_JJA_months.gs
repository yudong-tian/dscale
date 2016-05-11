
* dump all the DJF and JJA months for 2000-2004 (5year, total 15 months), 
* 2000: 2000-JF
* 2001: 2000-D 2001-JF
* 2002: 2001-D 2002-JF
* 2003: 2002-D 2003-JF
* 2004: 2004-3 2004-JF 
* 2005: 2005-D 
* to compute winter and summer climatology 

* year.sn
nsn.1=6
nsn.2=5
name.1='DJF'
name.2='JJA'

sn.1.1='1Jan2000 1Feb2000'
sn.2.1='1Dec2000 1Feb2001'
sn.3.1='1Dec2001 1Feb2002'
sn.4.1='1Dec2002 1Feb2003'
sn.5.1='1Dec2003 1Feb2004'
sn.6.1='1Dec2004' 

sn.1.2='1Jun2000 1Aug2000'
sn.2.2='1Jun2001 1Aug2001'
sn.3.2='1Jun2002 1Aug2002'
sn.4.2='1Jun2003 1Aug2003'
sn.5.2='1Jun2004 1Aug2004'

exp.1='B24'
exp.2='B12'
exp.3='B4' 

exp.4='../B24_600'
exp.5='../B12_600'
exp.6='../B4_600' 

exp.7='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
exp.8='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
exp.9='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'


* exps
id=1
 while (id <= 9) 

* seasons
  is=1
  while (is <= 2) 

'reinit'
say 'opening 'exp.id'/monthly.ctl'
'open 'exp.id'/monthly.ctl' 

'set gxout fwrite'
'set fwex' 
'set fwrite -be -st 'exp.id'/'name.is'-monthly.1gd4r'

*year
  iy=1
  while (iy <= nsn.is) 

   'set time 'sn.iy.is 
   'd rain' 

   iy=iy+1 
   endwhile
  'disable fwrite' 

  is=is+1
  endwhile

id=id+1
endwhile 

'quit'


