
* only show the first five years
* compute bias, rmse, and correlation over three regions: CONUS, W. US. and E. US. 
* layout: landscape, 3x3
*newer addition
* col, model runs 
exp.1='/home/ytian/Climate-downscaling/new-Validation/B24_600'
exp.2='/home/ytian/Climate-downscaling/new-Validation/B12_600'
exp.3='/home/ytian/Climate-downscaling/new-Validation/B4_600'

* col, interpolated 
int.1='B24'
int.2='B12'
int.3='B4'

* col, common reference 
ref.1='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref.2='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref.3='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'

* row, metrics: old three: bias, rmse, corelation 
met.1='bias'
met.2='rmse'
met.3='cor'

metname.1='Bias (mm/mon)'
metname.2='RMSE (mm/mon)'
metname.3='Correlation'

'reinit'

*number of time steps
tmax=120

nregs=4
regname.1='CONUS'
regname.2='W_US'
regname.3='E_US'
regname.4='C_US'

*CONUS
lon1.1=-125
lon2.1=-66.5
lat1.1=24.0833
lat2.1=49.9166

*W. US 
lon1.2=-125
lon2.2=-105 
lat1.2=24.0833
lat2.2=49.9166

*E. US 
lon1.3=-100
lon2.3=-66.5
lat1.3=24.0833
lat2.3=49.9166

*C. US 
lon1.4=-110
lon2.4=-105
lat1.4=36
lat2.4=42

cols=3
rows=3
hgap=0.1
vgap=0.2
vh=8.5/rows
vw=11/cols

parea='0.7 10.4 0.8 7.5'

ttl.1="Bias (mm/month)"
ttl.2="Correlation"
var.1="ybar-xbar"
var.2="tc"
var3.1="ybar3-xbar3"
var3.2="tc3"

* var.ireg
vrange.1.1='-25 50' 
vrange.2.1='0 80' 
vrange.3.1='0.5 1' 

vrange.1.2='-25 50' 
vrange.2.2='0 80' 
vrange.3.2='0.3 1' 

vrange.1.3='-30 60' 
vrange.2.3='0 100' 
vrange.3.3='0.3 1' 

vrange.1.4='-30 60' 
vrange.2.4='0 100' 
vrange.3.4='0.3 1' 

ireg=1
while (ireg <= nregs)
'reinit'

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

say 'opening 'ref.ic'/monthly.ctl' 
say 'opening 'exp.ic'/monthly.ctl' 
say 'opening 'int.ic'/monthly.ctl' 

'open 'ref.ic'/monthly.ctl' 
'open 'exp.ic'/monthly.ctl' 
'open 'int.ic'/monthly.ctl' 

'set time 1jan2000 1dec2004' 
'set x 1' 
'set y 1' 
'set xlopts 1 0.5 0.20'
'set ylopts 1 0.5 0.20'

'define expcor=scorr(rain.2, rain, lon='lon1.ireg', lon='lon2.ireg', lat='lat1.ireg', lat='lat2.ireg')'
'define intcor=scorr(rain.3, rain, lon='lon1.ireg', lon='lon2.ireg', lat='lat1.ireg', lat='lat2.ireg')'

'define refbar=amean(rain, lon='lon1.ireg', lon='lon2.ireg', lat='lat1.ireg', lat='lat2.ireg')'
'define expbar=amean(rain.2, lon='lon1.ireg', lon='lon2.ireg', lat='lat1.ireg', lat='lat2.ireg')'
'define intbar=amean(rain.3, lon='lon1.ireg', lon='lon2.ireg', lat='lat1.ireg', lat='lat2.ireg')'

'define expbias=expbar - refbar'
'define intbias=intbar - refbar'
'define base=0'

'define exprmse=sqrt(amean((rain.2-rain)*(rain.2-rain), lon='lon1.ireg', lon='lon2.ireg', lat='lat1.ireg', lat='lat2.ireg'))'
'define intrmse=sqrt(amean((rain.3-rain)*(rain.3-rain), lon='lon1.ireg', lon='lon2.ireg', lat='lat1.ireg', lat='lat2.ireg'))'

'set vrange 'vrange.ir.ireg 
'set cmark 0'
'set cthick 6'
'd exp'met.ir 
'set cmark 0'
'set cthick 6'
'set ccolor 2'
'd int'met.ir 
'set cthick 2'
'set ccolor 1'
'set cmark 0'
'd base'
'set strsiz 0.2 0.25'
'draw title 'int.ic' 'metname.ir' 'regname.ireg
'my_cbar_l2 -x 7.5 -y 1.5 -n 2 -t "Modeled" "Interpolated"'

'close 3' 
'close 2' 
'close 1' 

 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 3000 -y 2000 3x3-monthly-vs-t-'regname.ireg'-5yr.png'
'gxyat -x 1000 -y 800 sm-3x3-monthly-vs-t-'regname.ireg'-5yr.png'

ireg=ireg+1
endwhile 

