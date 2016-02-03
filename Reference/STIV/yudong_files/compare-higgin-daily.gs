*** script to plot scatter plots of Higgins vs. stage IV daily precip, 
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
range.1.1=18
minlon.2.1=-110
minlat.2.1=42
range.2.1=16
minlon.3.1=-100
minlat.3.1=42
range.3.1=20

minlon.1.2=-120
minlat.1.2=36
range.1.2=20
minlon.2.2=-105
minlat.2.2=33
range.2.2=15
minlon.3.2=-90
minlat.3.2=33
range.3.2=30


'enable print higgins-st4-scatter.gx'
'open ../STIV-daily-bin.ctl' 
'open ../higgins-0.5.ctl' 
'set time 1jan2005 31dec2005'
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
  'set gxout scatter' 
  'set parea 'parea

  minx=minlon.row.col
  miny=minlat.row.col
  maxx=minx+bsize
  maxy=miny+bsize
  'define radar=aave(apcpsfc, lon='minx', lon='maxx', lat='miny', lat='maxy')'
  'define gage=aave(rain.2*25.4, lon='minx', lon='maxx', lat='miny', lat='maxy')'
  'set lat 'minx
  'set lon 'miny
  'set vrange 0 'range.row.col
  'set vrange2 0 'range.row.col
  'd gage;radar'
  'draw xlab Higgins'
  'draw ylab STIV'
  'draw title Daily precip (mm), 2005 ('minx', 'miny')'

 row = row+1
endwhile
col = col + 1
endwhile
'printim higgins-st4-scatter.gif gif white x1200 y1600'
'print'
'disable print'


