
* compute bias, rmse, and correlation over each Buko zone, for B4 resolution only 
*   (other resolutions have too few data points) 
* layout: landscape, 3x2

* modeled , row1
exp.1='/home/ytian/Climate-downscaling/new-Validation/B4_600'

*  interpolated, row2 
exp.2='B4'

expname.1='Modeled'
expname.2='Interpolated'

*  common reference 
ref='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'

* col, metrics: old three: bias, rmse, corelation 
met.1='bias'
met.2='rmse'
met.3='cor'

*col.is, DJF
clev.1.1='-6 -3 0 3 6 9 12 15 18 21' 
clev.2.1='0 5 10 15 20 25 30 35 40 45 50' 
clev.3.1='0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1'

clev.1.2='-10 -5 0 5 10 15 20 25 30 35 40' 
clev.2.2='0 10 20 30 40 50 60 70 80' 
clev.3.2='0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1'


metname.1='Bias (mm/mon)'
metname.2='RMSE (mm/mon)'
metname.3='Correlation'

'reinit'

nregs=17
reg.1='Southwest'
reg.2='Southeast'
reg.3='SRockies'
reg.4='SPlains'
reg.5='Prairie'
reg.6='PacificSW'
reg.7='PacificNW'
reg.8='NorthAtlantic'
reg.9='NRockies'
reg.10='NPlains'
reg.11='MidAtlantic'
reg.12='Mezquital'
reg.13='GreatLakes'
reg.14='GreatBasin'
reg.15='DeepSouth'
reg.16='CPlains'
reg.17='Appalachia'

*CONUS
lon1=-125
lon2=-66.5
lat1=24.0833
lat2=49.9166

plon=lon1+360

cols=3
rows=3
hgap=0.1
vgap=0.2
vh=8.5/rows
vw=11/cols

parea='0.7 11.0 1.1 7.5'

sn.1='DJF'
sn.2='JJA'

* season 
is=1
while(is<=2) 
'reinit'

ir=1
while (ir <= 2)
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
'set xlopts 1 0.5 0.20'
'set ylopts 1 0.5 0.20'

'open 'ref'/'sn.is'-clim.ctl'
'open 'exp.ir'/'sn.is'-clim.ctl'

  ireg=1
  while (ireg <= nregs)
   'open masks/'reg.ireg'.ctl' 
   'define xrain=maskout(rain,   mask.3(t=1))' 
   'define yrain=maskout(rain.2, mask.3(t=1))' 
   'set x 1' 
   'set y 1' 
   'define bias=amean(yrain-xrain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
   'define rmse=sqrt(amean((yrain-xrain)*(yrain-xrain), lon='lon1', lon='lon2', lat='lat1', lat='lat2'))'
   'define cor=scorr(xrain, yrain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
   'd 'met.ic
   value=subwrd(result, 4) 
   say ''met.ic'='value
   'set lat 'lat1' 'lat2
   'set lon 'lon1' 'lon2
   'set mproj scaled'
   'set gxout grfill'
   'set clevs 'clev.ic.is 
   'd maskout('value'+0.000001*lat, mask.3(t=1))' 
   'draw title 'metname.ic' of 'expname.ir' 'sn.is' Climatology' 
   'close 3'
   
   ireg=ireg+1
  endwhile 
  'cbarn'
  'close 2'
  'close 1'

 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 3000 -y 2000 3x3-met-clim-zones-'sn.is'.png'
'gxyat -x 1000 -y 800 sm-3x3-met-clim-zones-'sn.is'.png'

is=is+1
endwhile


