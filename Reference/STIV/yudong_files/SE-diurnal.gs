* Plot diurnal cycles at SE sites for STIV, 3B42V6 and CMORPH
*
'reinit'
*** panel layout
cols=1
rows=4
hgap=0.2
vgap=0.1

vh=11/rows
vw=8.5/cols
**** lables for each col
resolution.1='0.25-deg'
resolution.2='1-km'

*** site 1 coordinates
slat.1 = 30.25 
slon.1 = -81.5
name.1='Jacksonville'
*** site 2 coordinates
slat.2 = 28.0 
slon.2 = -82.5 
name.2='Tampa'
*** site 3 coordinates
slat.3 = 28.5
slon.3 = -81.5 
name.3='Orlando'
*** site 4 coordinates
slat.4 = 30.5
slon.4 = -84.25
name.4='Tallahassee'

** satellites ****
ccol.1='1'
ccol.2='3'
ccol.3='9'
legd.1='STIV'
legd.2='3B42V6'
legd.3='CMORPH'
*
varout.1 = 'apcpsfc'
varout.2 = 'rain'
varout.3 = 'cmorph'
*** var.site of vrange
rng.1='0 2700'
rng.2='0 2700'
rng.3='0 2700'

*** scale of var
scale.1=3600*3
scale.2=3600*3
unit.1='mm'
unit.2='mm'

parea='1.5 10.0 0.5 8.4'

*
inittime = 1
maxtime = 2919

 'reinit'
 'enable print diurnal-SE-4cities.gx' 
**** input data
'open diurnal-jja05.ctl'
'open ../3B42-V6/diurnal-jja05.ctl' 
'open ../CMORPH0.25-3hrly/diurnal-jja05.ctl' 

site=1
maxsite=rows
while (site <= maxsite)
*
col=1
while(col <= cols)
*compute vpage
  vx1=(col-1)*vw+hgap
  vx2=col*vw-hgap
  vy1=(rows-site)*vh+vgap
  vy2=vy1+vh-vgap
  'set vpage 'vx1' 'vx2' 'vy1' 'vy2
  'set grads off'
  'set parea 'parea

'set lat 'slat.site
'set lon 'slon.site

'set vrange 0 1'
'set dfile 1'
'set t 1 24'
'd apcpsfc'

'set dfile 2'
'd rain'

'set dfile 3'
'd cmorph' 
'set strsiz 0.05 0.1'
'cbar_l -x 2.2 -y 1.9 -n 3 -t "STIV" "3B42V6" "CMORPH"' 
'draw title Precip (mm/h) 'name.site' JJA05 LST=UTC-5'

col = col + 1
endwhile
site = site + 1
endwhile
'printim  diurnal-SE-4cities.gif gif'
'print'
'disable print'


