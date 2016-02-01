
 'reinit'
 'open /home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily/ppt.ctl'
 'open rain_daily.ctl'

'set time 1Jan2000' 
'set lon -125 -66.5'
'set lat 24.0833 49.9166'
'define xbar=ave(ppt, time=1Jan2000, time=31Dec2000)'
'define sigmax2=ave( (ppt-xbar)*(ppt-xbar), time=1Jan2000, time=31Dec2000)'
'define ybar=ave(rain.2, time=1Jan2000, time=31Dec2000)'
'define xbyb=ave((rain.2-ybar)*(ppt-xbar), time=1Jan2000, time=31Dec2000)'
'define xb2=ave( (ppt-xbar)*(ppt-xbar), time=1Jan2000, time=31Dec2000)'
'define lamda=xbyb/xb2'
'define delta=ybar/lamda-xbar'
'define sigma2=ave( (rain.2 - lamda * (ppt + delta))*(rain.2 - lamda * (ppt + delta)),  time=1Jan2000, time=31Dec2000)'

'define sigma=sqrt(sigma2)'
'define sR=lamda*sqrt(sigmax2/(lamda*lamda*sigmax2 + sigma2))'
'define bias=ybar-xbar'
* sR can be compared with the following ts
*'define ts=scorr(rain.2, ppt, time=1Jan2000, time=31Dec2000)'

* now we have lamda, delta, sigma, and SR. Display them in 2x2

*** panel layout, portrait
cols=2
rows=3
hgap=0.1
vgap=0.2
vh=11/rows
vw=8.5/cols

* ic.ir, in km
*var.1.1='delta'
var.1.1='xbar'
var.2.1='ybar'
var.1.2='bias'
var.2.2='sR'
var.1.3='lamda'
var.2.3='sigma'

*ttl.1.1='Adjusted bias (K)'
ttl.1.1='PRISM mean (mm/d)'
ttl.2.1='B24_2000 mean (mm/d)'
ttl.1.2='Bias (mm/d)'
ttl.2.2='Temporal correlation'
ttl.1.3='Scale error'
ttl.2.3='Random error (mm/d)'

*vrg.1.1='-40 -20 0 20 40 60 80 100 120'
vrg.1.1='0 1 2 3 4 5 6 7 8 9 10'
vrg.2.1='0 1 2 3 4 5 6 7 8 9 10'
vrg.1.2='-5 -4 -3 -2 -1 0 1 2 3 4 5'
vrg.2.2='0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0'
vrg.1.3='0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0'
vrg.2.3='0 2 4 6 8 10 12 14 16 18 20'

parea='0.7 10.2 1.0 8.0'

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
 'set mpdset hires'
 'set gxout shaded'
 'set clevs 'vrg.ic.ir
 'set t 1'
 'set xlopts 1 0.5 0.15'
 'set ylopts 1 0.5 0.15'
 'd 'var.ic.ir
 'cbarn'
 'draw title 2000 'ttl.ic.ir
 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 3000 -y 4000 daily-2x3-metrics-vs-xy.png'
'gxyat -x 750 -y 1000 sm-daily-2x3-metrics-vs-xy.png'

quit

