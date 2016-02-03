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
!  $Id: 4km-0.25.F90,v 1.1 2006/04/11 20:50:53 lis Exp lis $ 
!-----------------------------------------------------------------
      implicit none

      integer, parameter :: icols=1121, irows=881   !** input grid
      integer, parameter :: MI = icols * irows       !** map to 1D 
      integer, parameter :: ncols=240, nrows=120  !** 0.25 
      integer, parameter :: NLDAS = ncols * nrows     !** map to 1D 
      real, parameter :: xres = 1/4.0          !** 5km res
      real, parameter :: yres = 1/4.0
      real  IFRAC(icols, irows) 

      Character*60 ofile  !** output files
      Character*60 ifile  !** input file 

      real :: ogfrac(ncols,nrows)  !** output array
      integer :: i, j, ic, ir
      real :: glat, glon
      real gfrac(MI)       !** input mapped to 1D

!***  Declare inputs and outputs
      integer icount, count1

!*** grib stuff 
      integer JPDS(200), JGDS(200), LUGB, LUGI, JSKIP
      integer KF,K,KPDS(200)
      integer IP,IPOPT(20),KGDSI(200)
      real RGDSO(50), RGDSI(50)
      integer KM, IBI
      integer NNO, NIBO, IRET, NIRET
      real Ngfrac(NLDAS)       !** output mapped to 1D
      real NRLAT(NLDAS), NRLON(NLDAS)  !** output lat/lon

      logical*1 LI(MI), NLO(NLDAS)     !** bitmap 

      ifile = '200508/ST4.2005081600.01h'
      ofile = 'ST4.2005081600.01h.1gd4r' 

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
         RGDSI(i) = real(KGDSI(i))
       end do
         RGDSI(4) = KGDSI(4)/1000.0
         RGDSI(5) = KGDSI(5)/1000.0
         RGDSI(7) = KGDSI(7)/1000.0
         RGDSI(8) = KGDSI(8)/1000.0
         RGDSI(9) = KGDSI(9)/1000.0

!*** FOR 1/4 degree LIS
        RGDSO(1)=0
        RGDSO(2)=ncols
        RGDSO(3)=nrows
        RGDSO(4)=20.875
        RGDSO(5)=-130.125
        RGDSO(6)=128
        RGDSO(7)=50.625
        RGDSO(8)=-70.375
        RGDSO(9)=0.25
        RGDSO(10)=0.250
        RGDSO(11)=64
        RGDSO(20)=255

     if (IRET==0) then
        call interp_stiv(kpds,MI,gfrac, LI, RGDSI, RGDSO, &
             ncols,nrows,ogfrac)
     else
        write(*, *) "Error opening input file ", ifile 
        stop
     endif
     call baclose(LUGB, iret)    !*** close the file

!---  Open and write to output file(s)  ---------------------

       open(20,file=ofile, form='unformatted', access="direct", &
        recl=nrows*ncols*4)
        write(20, rec=1) ogfrac
       close (20)

!---------------------------------------------------

      stop
      end


!BOP
! !ROUTINE: interp_stiv
!
! !DESCRIPTION:
!   This subroutine interpolates a given STIV field
!   to the LIS domain.  Special treatment for some
!   initialization fields.
!   Code based on retgdas.F90 in LISv4.2
!
! !INTERFACE:
subroutine interp_stiv(kpds,ngdas,f,lb,RGDSI,lis_gds,nc,nr, &
     varfield)
! !USES:
!EOP
  implicit none

  integer, intent(in) :: nc, nr, ngdas
  integer, intent(in) :: kpds(200)
  real :: lis_gds(50), RGDSI(50)
  real, intent(out)   :: f(ngdas)
  real, intent(out)   :: varfield(nc,nr)
  !Suffixes 1 are for bilinear (rlat1,rlat1)
  !Suffixes 2 are for conservatie (rlat2,rlat2)
  real, allocatable      :: rlat1(:)
  real, allocatable      :: rlon1(:)
  integer, allocatable   :: n111(:)
  integer, allocatable   :: n121(:)
  integer, allocatable   :: n211(:)
  integer, allocatable   :: n221(:)
  real, allocatable      :: w111(:),w121(:)
  real, allocatable      :: w211(:),w221(:)

  real, allocatable      :: rlat2(:)
  real, allocatable      :: rlon2(:)
  integer, allocatable   :: n112(:,:)
  integer, allocatable   :: n122(:,:)
  integer, allocatable   :: n212(:,:)
  integer, allocatable   :: n222(:,:)
  real, allocatable      ::  w112(:,:),w122(:,:)
  real, allocatable      ::  w212(:,:),w222(:,:)

  integer :: ip, ipopt(20),ibi,km,iret
  integer :: ibo
  integer :: count,i,j,mo

  real, dimension(nc*nr) :: lis1d
  logical*1 :: lb(ngdas)
  logical*1 :: lo(nc*nr)

!=== End variable declarations
!BOC
!-----------------------------------------------------------------------
  mo = nc*nr
       allocate(rlat1(nc*nr))
       allocate(rlon1(nc*nr))
       allocate(n111(nc*nr))
       allocate(n121(nc*nr))
       allocate(n211(nc*nr))
       allocate(n221(nc*nr))
       allocate(w111(nc*nr))
       allocate(w121(nc*nr))
       allocate(w211(nc*nr))
       allocate(w221(nc*nr))
       call bilinear_interp_input(RGDSI,lis_gds,&
            nc*nr,rlat1,rlon1,&
            n111,n121,n211,n221,w111,w121,w211,w221)
       allocate(rlat2(nc*nr))
       allocate(rlon2(nc*nr))
       allocate(n112(nc*nr,25))
       allocate(n122(nc*nr,25))
       allocate(n212(nc*nr,25))
       allocate(n222(nc*nr,25))
       allocate(w112(nc*nr,25))
       allocate(w122(nc*nr,25))
       allocate(w212(nc*nr,25))
       allocate(w222(nc*nr,25))
       call conserv_interp_input(RGDSI,lis_gds,&
            nc*nr,rlat2,rlon2,&
            n112,n122,n212,n222,w112,w122,w212,w222)

!-----------------------------------------------------------------------
! Initialize input/output bitmap. Important for soil moisture and temp.
!-----------------------------------------------------------------------
  ibi = 1
  ibo = 1
  lo = .true.
!-----------------------------------------------------------------------
! Interpolate to LIS grid
!-----------------------------------------------------------------------
         call conserv_interp(lis_gds,ibi,lb,f,ibo,lo,lis1d, ngdas,mo, &
              rlat2,rlon2,w112,w122,w212,w222,n112,n122,n212,n222,iret)
!        call bilinear_interp(lis_gds,ibi,lb,f,ibo,lo,lis1d,ngdas,mo,&
!             rlat1, rlon1,w111,w121,w211,w221,n111,n121,n211,n221,iret)
!-----------------------------------------------------------------------
! Create 2D array for main program. 
!-----------------------------------------------------------------------
  count = 0
  do j = 1, nr
     do i = 1, nc
     if (LO(i+count)) then
        varfield(i,j) = lis1d(i+count)
     else
        varfield(i,j) = -9999.0 
     end if
     enddo
     count = count + nc
  enddo

end subroutine interp_stiv

