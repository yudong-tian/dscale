
* compute the difference in bias, rmse, and correlation over each Buko zone, for B4 intepolated and modeled. 
*   (other resolutions have too few data points) 
* layout: landscape, 3x2

* modeled 
modd='/home/ytian/Climate-downscaling/new-Validation/B4_600'
*  interpolated
intd='B4'

expname.1='Modeled'
expname.2='Interpolated'

*  common reference 
ref='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'

* col, metrics: old three: bias, rmse, corelation 
met.1='bias'
met.2='rmse'
met.3='cor'

*col.ir, DJF, bias, rmse, and correlation difference
clev.1.1='-15 -12 -9 -6 -3 0 3 6 9 12 15' 
clev.2.1='-15 -12 -9 -6 -3 0 3 6 9 12 15' 
clev.3.1='-0.25 -0.2 -0.15 -0.1 -0.05 0 0.05 0.1 0.15 0.2 0.25'

*col.ir, JJA
clev.1.2='-20 -15 -10 -5 0 5 10 15 20 25 30' 
clev.2.2='-20 -15 -10 -5 0 5 10 15 20 25 30' 
clev.1.2='-50 -40 -30 -20 -10 0 10 20 30 40 50' 
clev.2.2='-50 -40 -30 -20 -10 0 10 20 30 40 50' 
clev.3.2='-0.25 -0.2 -0.15 -0.1 -0.05 0 0.05 0.1 0.15 0.2 0.25'

ccols='25   24   23    22   21 20 30 31 32 33 34 35'

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

* row
sn.1='DJF'
sn.2='JJA'

'reinit'

* These are the BLUE shades
'set rgb 20 135 206 250'
'set rgb 21 0 191 255'
'set rgb 22 0 0 255'
'set rgb 23 0 0 205'
'set rgb 24 0 0 123'
'set rgb 25 0 0 83'
* These are the RED shades
'set rgb 30 245 222 179'
'set rgb 31 244 164 96'
'set rgb 32 210 105 30'
'set rgb 33 178 34 34'
'set rgb 34 165 42 42'
'set rgb 35 145 60 60'

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

'open 'ref'/'sn.ir'-clim.ctl'
'open 'modd'/'sn.ir'-clim.ctl'
'open 'intd'/'sn.ir'-clim.ctl'

  ireg=1
  while (ireg <= nregs)
   'open masks/'reg.ireg'.ctl' 
   'define xrain=maskout(rain,   mask.4(t=1))' 
   'define yrain=maskout(rain.2, mask.4(t=1))' 
   'define yrain0=maskout(rain.3, mask.4(t=1))' 
   'set x 1' 
   'set y 1' 
   'define mbias=amean(yrain-xrain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
   'define mbias0=amean(yrain0-xrain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
   'define bias=mbias-mbias0'

   'define mrmse=sqrt(amean((yrain-xrain)*(yrain-xrain), lon='lon1', lon='lon2', lat='lat1', lat='lat2'))'
   'define mrmse0=sqrt(amean((yrain0-xrain)*(yrain0-xrain), lon='lon1', lon='lon2', lat='lat1', lat='lat2'))'
   'define rmse=mrmse-mrmse0'

   'define mcor=scorr(xrain, yrain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
   'define mcor0=scorr(xrain, yrain0, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
   'define cor=mcor-mcor0' 
   'd 'met.ic
   value=subwrd(result, 4) 
   say ''met.ic'='value
   'set lat 'lat1' 'lat2
   'set lon 'lon1' 'lon2
   'set mproj scaled'
   'set gxout grfill'
   'set ccols 'ccols
   'set clevs 'clev.ic.ir 
   'd maskout('value'+0.000001*lat, mask.4(t=1))' 
   'draw title 'metname.ic' difference, modeled-interpolated 'sn.ir
   'close 4'
   
   ireg=ireg+1
  endwhile 
  'cbarn'
  'close 3'
  'close 2'
  'close 1'

 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 3000 -y 2000 3x3-met-diff-clim-zones.png'
'gxyat -x 1000 -y 800 sm-3x3-met-diff-clim-zones.png'



