

PRECTOT is the proper hourly precipitation rate to use.

the 12.500_km data is on the native cubed-sphere grid. You should look at the 0.1250_deg output (conservatively regridded to a 1/8th deg latlon)

You can freely use all AR winters in each of the 3 streams.  The downscaling is being run in 3 streams, so you have at this point 6 AR winters to examine.


William M Putman
Global Modeling and Assimilation Office
NASA Goddard Space Flight Center
Cell: 240-778-5697
Desk: 301-286-2599

________________________________________
From: Kim, Jinwon [jkim@atmos.ucla.edu]
Sent: Monday, July 27, 2015 3:21 PM
To: Putman, William M. (GSFC-6101); climate-downscaling@lists.nasa.gov
Subject: RE: GEOS-5 Downscaling data

Thanks. I've went through the files in the directory and have a few questions.

(1) What is the difference between "PRECTOT" and "PRECTOTCORR" in the files under "tavg1_2d_flx_Nx"? Both are labeled "total precipitation" with the same units (mm/sec).

(2) The longitude and latitude values in the files under the "12.500_km" directory does not make sense. For example, longitudes vary from 1 to 720 with units specified as "degrees east". Does it need special conversion to recover values in "degrees east"? Same questions for the latitude values.

Looks like there are multiple runs covering different periods. After inspecting the time range, I'm inclined towards using the data under "M2R12K_may2005" for the AR-related metrics as the run provides three complete AR winters (NDJFM).  Other runs provides only two (M2R12K_nov1999) or one (M2R12K_nov2010) AR winter(s). Any suggestions about the data choice?



-----------------------------------------------------------------
Jinwon Kim
Joint Institute for Regional Earth System Science and Engineering and Dept. Atmospheric and Oceanic Sciences
University of California, Los Angeles
607 Charles E Young Drive East, Young Hall, Room 4242, Los Angeles, CA 90095-7228, USA
jkim@atmos.ucla.edu; 310-206-2828
________________________________________
From: climate-downscaling-bounces@lists.nasa.gov [climate-downscaling-bounces@lists.nasa.gov] on behalf of Putman, William M. (GSFC-6101) [william.m.putman@nasa.gov]
Sent: Monday, July 27, 2015 9:39 AM
To: climate-downscaling@lists.nasa.gov
Subject: [climate-downscaling] GEOS-5 Downscaling data

All of the GEOS-5 downscaling data are in:

/discover/nobackup/projects/gmao/osse2/stage/M2R12K_BETA7

There are 3 streams with output data on three different grids:

0.1250_deg lat/long grid
0.5000_deg lat/long grid
12.500_km cubed-sphere grid

You can get an idea of where data are in the streams from this resource file:

/discover/nobackup/projects/gmao/osse2//M2R12K_may2005/HISTORY.rc

William M Putman
Global Modeling and Assimilation Office
NASA Goddard Space Flight Center
Cell: 240-778-5697
Desk: 301-286-2599

