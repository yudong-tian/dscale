
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

lon1=-125
lon2=-66.5
lat1=24.0833
lat2=49.9166

cols=3
rows=3
hgap=0.1
vgap=0.2
vh=8.5/rows
vw=11/cols

parea='0.7 10.4 0.5 7.5'

ttl.1="Bias (mm/month)"
ttl.2="Correlation"
var.1="ybar-xbar"
var.2="tc"
var3.1="ybar3-xbar3"
var3.2="tc3"

vrange.1='-25 50' 
vrange.2='0 80' 
vrange.3='0.5 1' 

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

'set time 1jan2000 1dec2009' 
'set x 1' 
'set y 1' 
'set xlopts 1 0.5 0.25'
'set ylopts 1 0.5 0.25'

'define expcor=scorr(rain.2, rain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
'define intcor=scorr(rain.3, rain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'

'define refbar=amean(rain, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
'define expbar=amean(rain.2, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'
'define intbar=amean(rain.3, lon='lon1', lon='lon2', lat='lat1', lat='lat2')'

'define expbias=expbar - refbar'
'define intbias=intbar - refbar'
'define base=0'

'define exprmse=sqrt(amean((rain.2-rain)*(rain.2-rain), lon='lon1', lon='lon2', lat='lat1', lat='lat2'))'
'define intrmse=sqrt(amean((rain.3-rain)*(rain.3-rain), lon='lon1', lon='lon2', lat='lat1', lat='lat2'))'

'set vrange 'vrange.ir 
'set cmark 0'
'set cthick 6'
'd exp'met.ir 
'set cmark 0'
'set cthick 6'
'set ccolor 14'
'd int'met.ir 
'set cthick 2'
'set ccolor 1'
'set cmark 0'
'd base'
'set strsiz 0.2 0.25'
'draw title 'int.ic' 'metname.ir
'my_cbar_l -x 7.5 -y 1.5 -n 2 -t "Modeled" "Interpolated"'

'close 3' 
'close 2' 
'close 1' 

 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 3000 -y 2000 3x3-monthly-vs-t.png'
'gxyat -x 1000 -y 800 sm-3x3-monthly-vs-t.png'

