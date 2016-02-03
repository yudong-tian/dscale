* Computer metrics for 2005, STIV vs. Higgins 
*
'reinit'
*** panel layout
cols=1
rows=2
hgap=0.1
vgap=0.1
vh=11/rows
vw=8.5/cols

parea='1.5 10.0 1.0 7.4'

* rainfall threshold, mm/day
threshold = 1
*

  minlat = 25
  maxlat = 50
  minlon = -130
  maxlon = -70

var.1='POD'
var.2='FAR'
'enable print pod-st4-higgins.gx' 
'open ../STIV-daily-bin.ctl'
'open ../higgins.ctl'
'set time 1jan2005 31dec2005'
'set mpdset hires'
  obsvar = 'rain.2*25.4'
  modvar = 'apcpsfc' 
  tmin=1
  tmax=365
  'define npts = 'tmax
  'set lat 'minlat' 'maxlat
  'set lon 'minlon' 'maxlon
  'set gxout grfill'

* reduce observed and modeled results to occurrence basis (positive/negative)
      'define obsocc = const(const(maskout('obsvar','obsvar'-'threshold'),1),0,-u)'
      'define modocc = const(const(maskout('modvar','modvar'-'threshold'),1),0,-u)'
      hits = 0
      misses = 0
      alarms = 0
      zeros = 0

* calculate occurrence-based metric fundamentals:  Hits (modeled correct positives)
      'define hitgr = obsocc * modocc'
      'define hits = sum(hitgr, t='tmin', t='tmax')' 
* calculate occurrence-based metric fundamentals:  Misses (modeled incorrect negatives)
      'define missgr = obsocc - hitgr'
      'define misses = sum(missgr, t='tmin', t='tmax')' 
* calculate occurrence-based metric fundamentals:  False Alarms (modeled incorr positives)
      'define alarmgr = modocc - hitgr'
      'define alarms = sum(alarmgr, t='tmin', t='tmax')'
* calculate occurrence-based metric fundamentals:  Zeros (modeled correct negatives)
*-     'define zeros = npts - hits - misses - alarms'
* calculate occurrence-based metric:  Bias Score (BS)
*-      'define BS = (hits + alarms) / (hits + misses)'
* calculate occurrence-based metric:  Probability of Detection (POD)
      'define POD = hits / (hits + misses)'
* calculate occurrence-based metric:  False Alarm Ratio (FAR)
      'define FAR = alarms / (hits + alarms)'
* calculate occurrence-based metric:  Threat Score (TS) or Critical Success Index (CSI)
*-      'define TS = hits / (hits + alarms + misses)'
* calculate occurrence-based metric:  Equitable Threat Score (ETS)
*-      'define kern = (zeros * hits) - (alarms * misses)'
*-      'define ETS = kern / (npts * (alarms + misses) + kern)'

row=1
col=1
while (row<=rows)
  vx1=(col-1)*vw+hgap
  vx2=col*vw-hgap
  vy1=(rows-row)*vh+vgap
  vy2=vy1+vh-vgap
  'set vpage 'vx1' 'vx2' 'vy1' 'vy2
  'set parea 'parea

     'set clevs 0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0' 
     'set grads off'
     'set mpdset hires'
     'set t 'tmin
     'set gxout grfill' 
     'd 'var.row 
     'cbarn'
     'draw title 'var.row' STIV vs. Higgins, 2005' 
 row=row+1
endwhile
 'print'
 'printim pod-st4-higgins.gif gif' 
 'disable print'

