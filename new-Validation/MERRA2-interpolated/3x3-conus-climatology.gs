
* show DJF and JJA climatology of CONUS precip 

* col
res.1='B24'
res.2='B12'
res.3='B4'

*row 
dat.1='Modeled'
dat.2='Interpolated' 
dat.3='Reference' 

* col.row
* modeled 
exp.1.1='../B24_600'
exp.2.1='../B12_600' 
exp.3.1='../B4_600' 

* interpolated 
exp.1.2='B24'
exp.2.2='B12' 
exp.3.2='B4' 

* reference 
exp.1.3='../../Reference/PRISM-0.25-daily' 
exp.2.3='../../Reference/PRISM-0.125-daily' 
exp.3.3='../../Reference/PRISM-0.04-daily' 

pg.1='DJF'
pg.2='JJA'
ttl.1='Winter (DJF) Climatology (mm/mon)'
ttl.2='Summer (JJA) Climatology (mm/mon)'

ip=1
while (ip <= 2) 

'reinit'

*number of time steps (months) 
tmax=15

lon1=-125
lon2=-66.5
lat1=25.
lat2=49.

cols=3
rows=3
hgap=0.1
vgap=0.2
vh=8.5/rows
vw=11/cols

parea='0.7 11.0 1.1 7.5'

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
'set xlopts 1 0.5 0.18'
'set ylopts 1 0.5 0.18'

 say 'opening 'exp.ic.ir'/'pg.ip'-monthly.ctl' 
 'open 'exp.ic.ir'/'pg.ip'-monthly.ctl' 

  'set gxout fwrite' 
  'set fwrite -be -st 'exp.ic.ir'/'pg.ip'-clim.1gd4r'
  'set fwex'
  'd ave(rain, t=1, t='tmax')' 
  'disable fwrite' 

  'set mproj scaled'
  'set lat 'lat1' 'lat2
  'set lon 'lon1' 'lon2
  'set t 1'

  'set gxout grfill'
  'set clevs 0 25 50 75 100 125 150 175 200 225' 
  'd ave(rain, t=1, t='tmax')' 
  'draw title 'res.ic' 'dat.ir' 'pg.ip' (mm/mon)' 
  if (ir=3) 
   'cbarn' 
  endif 
 'close 1' 

 ic=ic+1
 endwhile
ir=ir+1
endwhile

'gxyat -x 4000 -y 3000 3x3_'pg.ip'_conus_clim.png'
'gxyat -x 1000 -y 750 sm-3x4_'pg.ip'_conus_clim.png'

ip=ip+1
endwhile
