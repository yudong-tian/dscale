*** script to compute diurnal cycle and save the data in a file. 
** deals with hourly ST4 data, interpolated to 0.25x0.25 latlon grid.
'reinit'
'open st4-latlon.ctl'
'set fwrite -be -st diurnal-JJA05.1gd4r'
'set gxout fwrite' 

* time interval spec
'set time 0Z01jun2005'
'q dims'
tmp=sublin(result, 5)
t0=subwrd(tmp, 9)
'set time 0Z31aug2005'
'q dims'
tmp=sublin(result, 5)
t1=subwrd(tmp, 9)
*say 't0='t0' t1='t1';' 

th0=0
th1=23
while(th0 <= th1)
 ts=t0+th0
 te=t1+th0
 'd ave(apcpsfc, t='ts', t='te', 24)'
 th0 = th0 + 1
endwhile 
'disable fwrite' 


