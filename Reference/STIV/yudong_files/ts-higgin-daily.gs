*** script to plot time series plots of Higgins vs. stage IV daily precip, 
** averaged over a 5x5 grid box
'reinit'
*** panel layout
cols=2
rows=3
hgap=0.1
vgap=0.2
vh=11/rows
vw=8.5/cols

parea='1.5 10.0 1.0 7.4'

*** size (degree) and LL lat-lon.row.col sample boxes
bsize=5
minlon.1.1=-120
minlat.1.1=42
range.1.1=2.4
minlon.2.1=-110
minlat.2.1=42
range.2.1=3.5
minlon.3.1=-100
minlat.3.1=42
range.3.1=8

minlon.1.2=-120
minlat.1.2=36
range.1.2=0.1
minlon.2.2=-105
minlat.2.2=33
range.2.2=8
minlon.3.2=-90
minlat.3.2=33
range.3.2=21


'enable print higgins-st4-ts.gx'
'open ../STIV-daily-bin.ctl' 
'open ../higgins.ctl' 
'set time 1jul2005 31jul2005'
col=1
while(col <= cols)
  row = 1
  while (row <= rows)

  vx1=(col-1)*vw+hgap
  vx2=col*vw-hgap
  vy1=(rows-row)*vh+vgap
  vy2=vy1+vh-vgap
  'set vpage 'vx1' 'vx2' 'vy1' 'vy2
  'set grads off'
  'set mproj scaled'
  'set parea 'parea

  minx=minlon.row.col
  miny=minlat.row.col
  maxx=minx+bsize
  maxy=miny+bsize
*  'define radar=aave(apcpsfc, lon='minx', lon='maxx', lat='miny', lat='maxy')'
*  'define gage=aave(rain.2*25.4, lon='minx', lon='maxx', lat='miny', lat='maxy')'
  'set lat 'miny
  'set lon 'minx
  'set vrange 0 'range.row.col
*  'set vrange2 0 'range.row.col
  'set cmark 0'
  'd rain.2*25.4'
  'set cmark 0'
  'd apcpsfc'
  'draw title Daily precip (mm), Aug. 2005 ('minx', 'miny')'
  'cbar_l -x 2.2 -y 6.0 -n 2 -t "Higgins" "STIV"'

 row = row+1
endwhile
col = col + 1
endwhile
'printim higgins-st4-ts.gif gif'
'print'
'disable print'


