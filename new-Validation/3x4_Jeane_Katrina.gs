
*newer addition
exp.0='B24_600_BMJ'
exp.1='B24_600_NKF'
exp.2='B24_600_NSAS'

exp.3='B24_0'
exp.4='B24_2000'
exp.5='B24_600'
exp.6='B12_0'
exp.7='B12_2000'
exp.8='B12_600'

exp.9='MERRA2'
exp.10='M2R12K'
exp.11='PRISM'

pg.1='Jeanne'
pg.2='Katrina'
ip=1
while (ip <= 2) 

'reinit'

*number of time steps
tmax=120

lon1=-125
lon2=-66.5
lat1=24.0833
lat2=49.9166

cols=3
rows=4
hgap=0.1
vgap=0.2
vh=8.5/rows
vw=11/cols

parea='0.7 10.4 0.5 5.0'

ttl.1='Total precip (mm)'
ttl.2='Total precip (mm)'
t1.1='26Sep2004'
t2.1='27Sep2004'
t1.2='28Aug2005'
t2.2='31Aug2005'

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

say 'opening 'exp.id'/2000-2009.ctl' 

 'open 'exp.id'/2000-2009.ctl' 

'set t 1'
'set gxout shaded'
'set clevs 0 25 50 75 100 125 150 175 200 225' 
'd sum(rain, time='t1.ip', time='t2.ip')' 
'draw title 'exp.id' 'ttl.ip 
'close 1' 

 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 4000 -y 3000 3x4_'pg.ip'.png'
'gxyat -x 1000 -y 750 sm-3x4_'pg.ip'.png'

ip=ip+1
endwhile
