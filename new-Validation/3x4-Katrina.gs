
*newer addition
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

exp.10='M2R12K'
exp.11='MERRA2'

*newer addition
ref.0='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.1='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.2='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.3='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.4='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.5='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.6='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref.7='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref.8='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref.9='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'

ref.10='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref.11='/home/ytian/Climate-downscaling/Reference/PRISM-MERRA2-daily'

pg.1='bias'
pg.2='corr'
ip=1
while (ip <= 2) 

'reinit'

*number of time steps
tmax=120

lon1=-125
lon2=-66.5
lat1=24.0833
lat2=49.9166

cols=2
rows=6
hgap=0.1
vgap=0.2
vh=11/rows
vw=8.5/cols

parea='0.7 8.4 0.5 3.0'

ttl.1="Bias (mm/month)"
ttl.2="Correlation"
var.1="ybar-xbar"
var.2="tc"
vrange.1='-25 50' 
vrange.2='0 1' 

ir=1
while (ir <= rows)
 ic=1
 while (ic <= cols)

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

id=(ir-1)*cols+ic-1

say 'opening 'ref.id'/monthly.ctl' 
say 'opening 'exp.id'/monthly.ctl' 

 'open 'ref.id'/monthly.ctl' 
 'open 'exp.id'/monthly.ctl' 

'set t 1 'tmax
'set x 1' 
'set y 1' 
'define tc=scorr(rain.2, rain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
'define xbar=amean(rain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
'define ybar=amean(rain.2, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
'set vrange 'vrange.ip 
'set cmark 0'
'set cthick 6'
'd 'var.ip 
'draw title 'exp.id' 'ttl.ip 
'close 2' 
'close 1' 

 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 3000 -y 4000 monthly-'pg.ip'-vs-t.png'
'gxyat -x 750 -y 1000 sm-monthly-'pg.ip'-vs-t.png'

ip=ip+1
endwhile
