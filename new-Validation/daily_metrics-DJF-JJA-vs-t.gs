
exp.0='B24_0'
exp.1='B24_600'
exp.2='B24_2000'
exp.3='B12_0'
exp.4='B12_600'
exp.5='B12_2000'
exp.6='B4_600'

exp.7='M2R12K'
exp.8='MERRA2'
*newer addition
exp.9='B24_600_BMJ'
exp.10='B24_600_NKF'
exp.11='B24_600_NSAS'

ref.0='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.1='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.2='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.3='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref.4='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref.5='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref.6='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'

ref.7='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref.8='/home/ytian/Climate-downscaling/Reference/PRISM-MERRA2-daily'
*newer addition
ref.9='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.10='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.11='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'

* B4
*  tDJF=270
*  tJJA=276

sn.1='DJF'
sn.2='JJA'
tmax.1=810 
tmax.2=920 

lon1=-125
lon2=-66.5
lat1=24.0833
lat2=49.9166

*ttl.1.1='Adjusted bias (K)'
ttl.1='Spatial correlation, DJF'
ttl.2='Spatial correlation, JJA'
*ttl.1='Bias (mm/d), DJF'
*ttl.2='Bias (mm/d), JJA'

cols=1
rows=2
hgap=0.1
vgap=0.2
vh=8.5/rows
vw=11/cols

parea='0.7 10.2 1.0 8.0'

ir=1
while (ir <= 2)
 ic=1
 while (ic <= 1)

*compute vpage
 vx1=(ic-1)*vw+hgap
 vx2=ic*vw-hgap
 vy1=(rows-ir)*vh+vgap
 vy2=vy1+vh-vgap

'set vpage 'vx1' 'vx2' 'vy1' 'vy2
'set grads off'
'set parea 'parea
'set xlopts 1 0.5 0.15'
'set ylopts 1 0.5 0.15'

 id=0 
  while (id<=11) 

say 'opening 'ref.id'/daily-'sn.ir'.ctl'
say 'opening 'exp.id'/daily-'sn.ir'.ctl'

 'open 'ref.id'/daily-'sn.ir'.ctl'
 'open 'exp.id'/daily-'sn.ir'.ctl'

'set t 1 'tmax.ir 
'set x 1' 
'set y 1' 
'define tc=scorr(rain.2, rain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
*'define xbar=amean(rain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
*'define ybar=amean(rain.2, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
*'set vrange -5 5' 
'set vrange -0.2 1.2'
'set cmark 0'
'set xlab off'
'd tc'
*'d ybar-xbar'
'draw title 'ttl.ir 
'close 2' 
'close 1' 

  id=id+1 
  endwhile 

 ic=ic+1
 endwhile
ir=ir+1
endwhile
*'gxyat -x 4000 -y 3000 daily-metrics-vs-t.png'
*'gxyat -x 1000 -y 750 sm-daily-metrics-vs-t.png'
'gxyat -x 4000 -y 3000 daily-corr-vs-t.png'
'gxyat -x 1000 -y 750 sm-daily-corr-vs-t.png'

