
* dump DJF and JJA for 2000-2009  (B4: 2000-2001)  

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


* skip B4_600 and PRISM-0.04
ndat=16 

id=14
while (id <= ndat) 

'reinit'

say 'opening 'exp.id'/2000-2009.ctl'
'open 'exp.id'/2000-2009.ctl' 

ssn='DJF'

'set gxout fwrite'
'set fwex' 
'set fwrite -be -st 'exp.id'/daily-'ssn'.1gd4r'

syr=2000
tsum=0
while (syr <= 2008) 

 eyr=syr+1
 'set time 0Z1DEC'syr' 0Z28FEB'eyr 
 'q dims'
 line=sublin(result, 5) 
 t1=subwrd(line, 11)
 t2=subwrd(line, 13)
 say 't1= 't1'  t2='t2 
 'd rain' 
 tsum=tsum+t2-t1+1

 syr=syr+1
endwhile

'disable fwrite' 
say "DJF total time steps="tsum

ssn='JJA'
stime ='01jun' 
etime ='31aug' 

'set gxout fwrite'
'set fwex' 
'set fwrite -be -st 'exp.id'/daily-'ssn'.1gd4r'

tsum=0
syr=2000
while (syr <= 2009)

 eyr=syr
 'set time 0Z1JUN'syr' 0Z31AUG'eyr 
 'q dims'
 line=sublin(result, 5) 
 t1=subwrd(line, 11)
 t2=subwrd(line, 13)
 say 't1= 't1'  t2='t2 
 'd rain' 
 tsum=tsum+t2-t1+1

 syr=syr+1
endwhile
'disable fwrite'
say "JJA total time steps="tsum

id=id+1
endwhile

'quit'


