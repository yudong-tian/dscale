      PROGRAM st4proj
!-----------------------------------------------------------------
!  Description:  This program reproject the NCEP stage IV data 
!    to lat-lon grid at 0.25 degree, using the ipolates lib. 
!
!  Input:  Data file of stIV 
!  Output:  Data transformed to new grid
!
!  Note:  This program is set for regular grid format but
!         can be modified to fit other projections as well.
!  Source: Kristi
!  Modified: Yudong Tian 
!  $Id: 4km-0.25.F90,v 1.3 2006/04/19 15:20:32 lis Exp $ 
!  Usage: 
!  ./4km-0.25 inputfile outputfile 
!-----------------------------------------------------------------
      implicit none

      integer, parameter :: icols=1121, irows=881   !** input grid
      integer, parameter :: MI = icols * irows       !** map to 1D 
      integer, parameter :: ncols=240, nrows=120  !** 0.25 
      integer, parameter :: NLDAS = ncols * nrows     !** map to 1D 
      real, parameter :: xres = 1/4.0          !** 5km res
      real, parameter :: yres = 1/4.0
      real  IFRAC(icols, irows) 

      Character*80 ofile  !** output files
      Character*80 ifile  !** input file 
      Character*80 ctmp

      real :: ogfrac(ncols,nrows)  !** output array
      integer :: i, j, ic, ir, iargc
      real :: glat, glon
      real gfrac(MI)       !** input mapped to 1D

!***  Declare inputs and outputs
      integer icount, count1

!*** grib stuff 
      integer JPDS(200), JGDS(200), LUGB, LUGI, JSKIP
      integer KF,K,KPDS(200)
      integer IP,IPOPT(20),KGDSI(200)
      integer NKGDSO(200)
      integer KM, IBI
      integer NNO, NIBO, IRET, NIRET
      real Ngfrac(NLDAS)       !** output mapped to 1D
      real NRLAT(NLDAS), NRLON(NLDAS)  !** output lat/lon

      logical*1 LI(MI), NLO(NLDAS)     !** bitmap 

      If (iargc().NE.2) Then
       call getarg(0, ctmp) !** get program name
       Write(*, *) "Usage: ", trim(ctmp)," inputf outputf"
         Stop
      End If
    
      call getarg(1, ifile)
      call getarg(2, ofile)

!*** read in raw data 
!  Unpack data and obtain required information for interpolation
!  This subroutine call gets and automatically generates KGDSI
!   information to be used oas input into ipolates subroutine
 
!**!!NOTE FOR stage IV*************************************
!    * It is a 1121x881 polar stereographic grid.
!    * Point (1,1) is at 23.117N 119.023W.
!    * Point (1,881) is at 53.509N 134.039W.
!    * Point (1121,1) is at 19.805N 80.750W.
!    * Point (1121,881) is at 45.619N 59.959W.
!    * The y-axis is parallel to 105W.
!    * The resolution is 4.7625km at 60N.
!    * The pole point is (I,J) = (400.5,1600.5) 
!
      LUGB = 10 !** unit number
      LUGI = 0    !** index 
      JSKIP = 0   !** number of msgs to skip
      JPDS = -1
      JGDS = -1

      call baopen(LUGB, ifile, iret) 
      CALL GETGB (LUGB, LUGI, MI, JSKIP, JPDS,JGDS,KF,K,KPDS,KGDSI, &
                      LI,gfrac,IRET)  !** read the data into 1d gfrac

      do i=1, 20
         write(*, *) "KGDSI(", i, ") =", KGDSI(i)
      end do


!***  Convert IFRAC grid into 1D array to be passed into 
!     IPOLATES routine and convert to a real fraction value.

!    KGDSI (apply to all NLDAS, GLDAS, NSIPP) 

        IP = 3                  !** 0: bilinear; 3: budget 

        do i=1,20
          IPOPT(i)=0
        end do
!  Budget interp specific. comment out for bilinear
         IPOPT(1) = -1
         IPOPT(2) = -1

!    NKGDSO: output grid specs

        do i=1,200
          NKGDSO(i)=0
        end do

!*** FOR 1/4 degree LIS 
        NKGDSO(1)=0
        NKGDSO(2)=ncols
        NKGDSO(3)=nrows
        NKGDSO(4)=20875
        NKGDSO(5)=-130125
        NKGDSO(6)=128
        NKGDSO(7)=50625
        NKGDSO(8)=-70375
        NKGDSO(9)=250
        NKGDSO(10)=250
        NKGDSO(11)=64
        NKGDSO(20)=255


        KM = 1
        IBI = 1

        NIBO = 1
        CALL IPOLATES (IP,IPOPT,KGDSI,NKGDSO,MI,NLDAS,KM, &
                       IBI,LI,gfrac, &
                       NNO,NRLAT,NRLON,NIBO,NLO,Ngfrac,NIRET)
       write(*, *)"Interpolation done. Return code: ", NIRET

      call baclose(LUGB, iret)    !*** close the file

       ogfrac = -9999.0
        count1 = 0
        do j = 1, nrows    !** 1D --> 2D map
          do i = 1, ncols
             if (NLO(i+count1)) then
              ogfrac(i,j) = Ngfrac(i + count1)
             else 
              ogfrac(i,j) = -9999.0 
             end if
          end do
           count1 = count1 + ncols
        end do

!---  Open and write to output file(s)  ---------------------

       open(20,file=ofile, form='unformatted', access="direct", &
        recl=nrows*ncols*4) 
        write(20, rec=1) ogfrac
       close (20) 

!---------------------------------------------------

      stop
      end
