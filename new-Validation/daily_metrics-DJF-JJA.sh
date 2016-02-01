
cdir=`pwd`

exp[0]='B24_0'
exp[1]='B24_600'
exp[2]='B24_2000'
exp[3]='B12_0'
exp[4]='B12_600'
exp[5]='B12_2000'
exp[6]='B4_600'

exp[7]='M2R12K'
exp[8]='MERRA2'
#newer addition
exp[9]='B24_600_BMJ'
exp[10]='B24_600_NKF'
exp[11]='B24_600_NSAS'

ref[0]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[1]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[2]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[3]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[4]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[5]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[6]='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'

ref[7]='/home/ytian/Climate-downscaling/Reference/PRISM-0.125-daily'
ref[8]='/home/ytian/Climate-downscaling/Reference/PRISM-MERRA2-daily'
#newer addition
ref[9]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[10]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'
ref[11]='/home/ytian/Climate-downscaling/Reference/PRISM-0.25-daily'

for i in `seq 0 11`; do
#for i in `seq 0 0`; do
 tDJF=810
 tJJA=920
 # special handling for B4
 if [ $i -eq 6 ]; then 
  tDJF=450
  tJJA=460
 fi 


cd ${exp[$i]} 

cat > daily_metrics-DJF-JJA.gs<<EOF

sn.1='DJF'
sn.2='JJA'
tmax.1=$tDJF
tmax.2=$tJJA 

is=1
while (is<=2) 

 'reinit'
 'open ${ref[$i]}/daily-'sn.is'.ctl'
 'open daily-'sn.is'.ctl'

'set t 1' 
'set lon -125 -66.5'
'set lat 24.0833 49.9166'
'define xbar=ave(rain, t=1, t='tmax.is')'
'define sigmax2=ave( (rain-xbar)*(rain-xbar), t=1, t='tmax.is')'
'define ybar=ave(rain.2, t=1, t='tmax.is')'
'define xbyb=ave((rain.2-ybar)*(rain-xbar), t=1, t='tmax.is')'
'define xb2=ave( (rain-xbar)*(rain-xbar), t=1, t='tmax.is')'
'define lamda=xbyb/xb2'
'define delta=ybar/lamda-xbar'
'define sigma2=ave( (rain.2 - lamda * (rain + delta))*(rain.2 - lamda * (rain + delta)),  t=1, t='tmax.is')'

'define sigma=sqrt(sigma2)'
'define sR=lamda*sqrt(sigmax2/(lamda*lamda*sigmax2 + sigma2))'
'define bias=ybar-xbar'
* sR can be compared with the following ts
*'define ts=scorr(rain.2, rain, t=1, t='tmax.is')'

* now we have lamda, delta, sigma, and SR. Display them in 2x2

*** panel layout, landscape 
cols=2
rows=2
hgap=0.1
vgap=0.2
vh=8.5/rows
vw=11/cols

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
ttl.2.1='${exp[$i]} mean (mm/d)'
ttl.1.2='Bias (mm/d)'
ttl.2.2='Temporal correlation'
ttl.1.3='Scale error'
ttl.2.3='Random error (mm/d)'

*vrg.1.1='-40 -20 0 20 40 60 80 100 120'
vrg.1.1='0 1 2 3 4 5 6 7 8 9 10'
vrg.2.1='0 1 2 3 4 5 6 7 8 9 10'
vrg.1.2='-3.5 -3 -2.5 -2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3 3.5'
*vrg.1.2='-8 -4 -2 -1 -0.05 -0.025 0 0.025 0.05 1 2 4 8'
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
 'draw title 'sn.is' 'ttl.ic.ir
 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 4000 -y 3000 'sn.is'-daily-metrics-vs-xy.png'
'gxyat -x 1000 -y 750 sm-'sn.is'-daily-metrics-vs-xy.png'

is=is+1
endwhile 

quit

EOF

grads -blc "run daily_metrics-DJF-JJA.gs"

cd $cdir

done 

