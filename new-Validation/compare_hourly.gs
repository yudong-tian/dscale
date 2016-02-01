
exp.0='B24_600_BMJ'
exp.1='B24_600_NKF'
exp.2='B24_600_NSAS'

exp.3='B24_0'
exp.4='B24_600'
exp.5='B24_2000'
exp.6='B12_0'
exp.7='B12_600'
exp.8='B12_2000'
exp.9='B4_600'

ref.1='M2R12K/rain_hourly.ctl'
ref.2='STIV'

* select only a few
exp.0='B24_600'
exp.1='B12_600'
exp.2='B4_600'

id=0
while(id <= 2) 
  'open 'exp.id'/rainc.ctl'
  'open 'exp.id'/rainnc.ctl'
  'set time 23Z31May2004 23Z31Aug2004' 
  'set time 23Z31May2004 23Z11Jun2004' 
  'set lat 35'
  'set lon -95' 
  'define c=tloop(rainc-rainc(t-1))'
  'define nc=tloop(rainnc.2-rainnc.2(t-1))'
  'set time 23Z31May2004 23Z31Aug2004' 
  'set time 0Z1Jun2004 23Z11Jun2004' 
  'set vrange 0 24'
  'set cmark 0'
  'd c+nc' 
  'close 2' 
  'close 1'
  
 id=id+1
endwhile 

* add ref data
  
  'open 'ref.1 
  'set lat 35'
  'set lon -95' 
  'set time 23Z31May2004 23Z31Aug2004' 
  'set time 0Z1Jun2004 23Z11Jun2004' 
  'set vrange 0 24'
  'set cmark 0'
  'd rain' 
 
'gxyat -x 1000 -y 750 compare_hourly.png' 






