
*newer addition, row.col
exp.1.1='B24_600'
exp.2.1='B24_600_BMJ'
exp.3.1='B24_600_NKF'
exp.4.1='B24_600_NSAS'

exp.1.2='B24_600_G3D_0sh'
exp.2.2='B24_600_BMJ_0sh'
exp.3.2='B24_600_NKF_0sh'
exp.4.2='B24_600_NSAS_0sh'

'reinit'

*number of time steps

lon1=-125
lon2=-66.5
lat1=24.0833
lat2=49.9166

cols=2
rows=4
hgap=0.1
vgap=0.2
vh=11/rows
vw=8.5/cols

parea='0.7 8.4 0.7 4.9'

ttl.1="Mean precip (mm/day)"

vrange.1='0 0.5 1.0 1.5 2.0 2.5 3.0 3.5 4 4.5 5 5.5 6' 

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

say 'opening 'exp.ir.ic'/rain_daily.ctl' 
'open 'exp.ir.ic'/rain_daily.ctl' 

'set time 1Jun2000'
'set lat 'lat1' 'lat2
'set lon 'lon1' 'lon2
'define xbar=mean(rain, time=1Jun2000, time=31Aug2000)' 
'set gxout shaded'
'set clevs 'vrange.1
'd xbar' 
'cbarn' 
'draw title 'exp.ir.ic' 'ttl.1 
'close 1' 

 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 3000 -y 4000 daily-JJA2000.png'
'gxyat -x 750 -y 1000 sm-daily-JJA2000.png'

