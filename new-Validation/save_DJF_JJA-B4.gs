
* dump DJF and JJA for 2000-2009  (B4: 2000-2004)  

exp.12='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'
exp.13='B4_600'

*  B4_600 and PRISM-0.04
ndat=13 

id=12
while (id <= ndat) 

'reinit'

say 'opening 'exp.id'/1999-2004.ctl'
'open 'exp.id'/1999-2004.ctl' 

ssn='DJF'

'set gxout fwrite'
'set fwex' 
'set fwrite -be -st 'exp.id'/daily-'ssn'.1gd4r'

syr=1999
tsum=0
while (syr <= 2003) 

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
while (syr <= 2004)

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


