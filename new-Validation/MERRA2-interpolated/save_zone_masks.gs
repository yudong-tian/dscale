
* intepolate 17 Buko zones to 4km and save each 

'reinit'

nregs=17
bdir='/discover/nobackup/projects/dscale/jkim8/gis/mask/buko'
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

plon1=lon1+360
plon2=lon2+360

  ireg=1
  while (ireg <= nregs)
   'reinit'
   say 'sdfopen 'bdir'/'reg.ireg'.nc' 
   'sdfopen 'bdir'/'reg.ireg'.nc' 
   'set lon 'plon1' 'plon2 
   'set lat 'lat1' 'lat2
   'define reg1km=const(mask, 0, -u)'
   'define mask1km=maskout(reg1km, reg1km-0.5)' 
   'set gxout fwrite' 
   'set fwrite -be -st masks/'reg.ireg'.1gd4r'
*   'set fwex'
   'd re(mask1km, 1405, linear, 'lon1', 0.04166667, 621, linear, 'lat1', 0.04166667)'
   'disable fwrite' 
  ireg=ireg+1
  endwhile 
   
