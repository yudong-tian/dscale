
* compute temporal correlation over each grid point, for DJF and JJA 
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

*row 
dat.1='Modeled'
dat.2='Interpolated' 

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

'set rgb 100 255 0 255' 
'set rgb 101 191 0 255' 
'set rgb 102 64 0 255' 
'set rgb 103 0 0 255' 
'set rgb 104 0 128 255' 
'set rgb 105 0 191 255' 
'set rgb 106 0 255 255' 
'set rgb 107 0 255 128'
'set rgb 108 0 255 0' 
'set rgb 109 64 255 0' 
'reinit'

nsn=2
snname.1='DJF'
snname.2='JJA'

*CONUS
lon1=-125
lon2=-66.5
lat1=25
lat2=49

cols=3
rows=3
hgap=0.1
vgap=0.2
vh=8.5/rows
vw=11/cols

parea='0.7 11.0 1.1 7.5'

ttl="Correlation"

isn=1
while (isn <= nsn)
'reinit'

ir=1
while (ir <= 2 ) 
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

 say 'open 'ref.ic'/'snname.isn'-monthly.ctl' 
 'open 'ref.ic'/'snname.isn'-monthly.ctl' 
if (ir = 1) 
 say 'open 'exp.ic'/'snname.isn'-monthly.ctl' 
 'open 'exp.ic'/'snname.isn'-monthly.ctl' 
else 
 say 'open 'int.ic'/'snname.isn'-monthly.ctl' 
 'open 'int.ic'/'snname.isn'-monthly.ctl' 
endif 

'set lat 'lat1' 'lat2
'set lon 'lon1' 'lon2
'set t 1' 

'define xbar=ave(rain, t=1, t=15)'
'define xb2=ave( (rain-xbar)*(rain-xbar), t=1, t=15)'

'define ybar=ave(rain.2, t=1, t=15)'
'define xbyb=ave((rain.2-ybar)*(rain-xbar), t=1, t=15)'

'define lamda=xbyb/xb2'
'define delta=ybar/lamda-xbar'
'define sigma2=ave( (rain.2 - lamda * (rain + delta))*(rain.2 - lamda * (rain + delta)),  t=1, t=15)'

'define sigma=sqrt(sigma2)'
'define corr=lamda*sqrt(xb2/(lamda*lamda*xb2 + sigma2))'
'define bias=ybar-xbar'

'set xlopts 1 0.5 0.18'
'set ylopts 1 0.5 0.18'

'set mproj scaled'
'set gxout grfill'
'set ccols 100 101 102 103 104 105 106 107 108 109' 
'set clevs  0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0'
'd corr' 
if (ir=2) 
'cbarn' 
endif
'draw title 'dat.ir' 'snname.isn' 'int.ic' Correlation'

'close 2' 
'close 1' 

 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 3000 -y 2000 3x3-monthly-vs-xy-'snname.isn'.png'
'gxyat -x 1000 -y 800 sm-3x3-monthly-vs-xy-'snname.isn'.png'

isn=isn+1
endwhile 

