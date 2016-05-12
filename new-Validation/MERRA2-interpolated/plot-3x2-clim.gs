
* compute the difference in bias, rmse, and correlation over each Buko zone, for B4 intepolated and modeled. 
*   (other resolutions have too few data points) 
* layout: landscape, 3x2

* row
sn.1='DJF'
sn.2='JJA'

* modeled, row 
exp.1='/home/ytian/Climate-downscaling/new-Validation/B4_600'
*  interpolated
exp.2='B4'
*  common reference 
exp.3='/home/ytian/Climate-downscaling/Reference/PRISM-0.04-daily'

expname.1='Modeled'
expname.2='Interpolated'
expname.3='Reference'

*.ir, 
*clev.1='0 2 4 8 16 32 64 128 256 512' 
*clev.2='0 2 4 8 16 32 64 128 256 512' 
clev.1='0 25 50 75 100 125 150 175 200 225 250' 
clev.2='0 25 50 75 100 125 150 175 200 225 250' 

'reinit'

*CONUS
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

parea='0.7 11.0 1.1 7.5'

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

   'open 'exp.ic'/'sn.ir'-clim.ctl'
   'set lat 'lat1' 'lat2
   'set lat 25 49' 
   'set lon 'lon1' 'lon2
   'set mproj scaled'
   'set gxout grfill'
   'set clevs 'clev.ir 
   'd rain' 
   'draw title 'expname.ic' 'sn.ir' Climatology' 
  'cbarn'
  'close 1'

 ic=ic+1
 endwhile
ir=ir+1
endwhile
'gxyat -x 3000 -y 2000 3x2-clim.png'
'gxyat -x 1000 -y 800 sm-3x2-clim.png'



