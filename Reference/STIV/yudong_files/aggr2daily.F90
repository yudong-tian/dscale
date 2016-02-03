! This program aggregates hrly Stage 4 data into daily precip data 
! starting from 12Z of previous day to 12Z of present day, 
! to follow Higgins daily data convention.
! i.e.,  for day1: 
! day1 = day0@13Z + day0@14Z + ... + day0@23Z 
!      + day1@0Z + day1@1Z + ... + day1@12Z 
! usage: aggr2daily year month 

	Program aggr2
	implicit NONE
        integer i, iday, im, iy, iargc, Nday(12)
        character*80 ctmp


        i =  iargc()
        If (i.NE.2) Then
          call getarg(0, ctmp) !** get program name
          Write(*, *) "Usage: ", trim(ctmp), &
            "year month" 
          Write(*, *) "Example: ", trim(ctmp), " 2005 2" 
          Stop
        End If

       
       call getarg(1, ctmp)
       read(ctmp, *) iy
       call getarg(2, ctmp)
       read(ctmp, *) im

       call faggr(iy, im)  
        
       stop 
       end 


       subroutine faggr(iy, im)
	integer, parameter :: nc=240, nr=120, nf=24
        integer iday, im, iy, ih, i, j, icnt(nc, nr), iargc, Nday(12), ios
	real aggr(nc, nr), input(nc, nr), w(nf)
        integer lday, lm, ly, hours(nf)
        character*80 ifile(nf), ofile, ctmp, ctmp2, pref
        character*4 cly, clm, clday 
        character*4 ciy, cim, ciday 
	logical isleap

       Nday(1) = 31
       Nday(2) = 28
       Nday(3) = 31
       Nday(4) = 30
       Nday(5) = 31
       Nday(6) = 30
       Nday(7) = 31
       Nday(8) = 31
       Nday(9) = 30
       Nday(10) = 31
       Nday(11) = 30
       Nday(12) = 31
       if (isleap(iy)) then
          Nday(2) = 29
       end if

       ! weights for aggregation
       w = 1.0

       write(cim, '(I2.2)') im 
       write(ciy, '(I4.4)') iy 

       Do iday = 1, Nday(im)
        write(ciday, '(I2.2)') iday        
        !ST4.20060121.1gd4r
        ofile="ST4."//ciy(1:4)//trim(cim)//trim(ciday)
        ly = iy
        lm = im
        lday = iday - 1         ! last day
        if (lday .EQ. 0) then 
           lm = im -1     ! last month
           if (lm .EQ. 0) then
              lm = 12
              ly = iy - 1
           end if 
           lday = Nday(lm) 
        end if
        write(cly, '(I4.4)') ly 
        write(clm, '(I2.2)') lm 
        write(clday, '(I2.2)') lday

        ! ST4.2006012113.01h.1gd4r
        ! last day
        pref = "../"//cly//trim(clm)//"/ST4."//cly(1:4)//trim(clm)//trim(clday)
        ifile(1) = trim(pref)//"13.01h.1gd4r" 
        ifile(2) = trim(pref)//"14.01h.1gd4r" 
        ifile(3) = trim(pref)//"15.01h.1gd4r" 
        ifile(4) = trim(pref)//"16.01h.1gd4r" 
        ifile(5) = trim(pref)//"17.01h.1gd4r" 
        ifile(6) = trim(pref)//"18.01h.1gd4r" 
        ifile(7) = trim(pref)//"19.01h.1gd4r" 
        ifile(8) = trim(pref)//"20.01h.1gd4r" 
        ifile(9) = trim(pref)//"21.01h.1gd4r" 
        ifile(10) = trim(pref)//"22.01h.1gd4r" 
        ifile(11) = trim(pref)//"23.01h.1gd4r" 
        ! present day
        pref = "../"//ciy//trim(cim)//"/ST4."//ciy(1:4)//trim(cim)//trim(ciday)
        ifile(12) = trim(pref)//"00.01h.1gd4r" 
        ifile(13) = trim(pref)//"01.01h.1gd4r" 
        ifile(14) = trim(pref)//"02.01h.1gd4r" 
        ifile(15) = trim(pref)//"03.01h.1gd4r" 
        ifile(16) = trim(pref)//"04.01h.1gd4r" 
        ifile(17) = trim(pref)//"05.01h.1gd4r" 
        ifile(18) = trim(pref)//"06.01h.1gd4r" 
        ifile(19) = trim(pref)//"07.01h.1gd4r" 
        ifile(20) = trim(pref)//"08.01h.1gd4r" 
        ifile(21) = trim(pref)//"09.01h.1gd4r" 
        ifile(22) = trim(pref)//"10.01h.1gd4r" 
        ifile(23) = trim(pref)//"11.01h.1gd4r" 
        ifile(24) = trim(pref)//"12.01h.1gd4r" 
        
        aggr = 0.0 
        icnt = 0
        Do ih = 1, nf
         write(*, *) "Input file: ", ifile(ih)
	 open(19, file=ifile(ih), form="unformatted", access="direct", &
            recl=nc*nr*4, status="old",  iostat=ios)
         if(ios.ne.0) then 
           write(*, *)"skipping ", ifile(ih)
           close(19)
         else 
           read(19, rec=1) input
           close(19)
            
          Do j=1, nr
            Do i=1, nc
             If(input(i, j).GE.0.0) then   !* skip undef
              aggr(i, j) = aggr(i, j) + input(i, j) * w(ih)   !with weight
              icnt(i, j) = icnt(i, j) + 1
             end if
            End Do
           End Do

         end if

        End Do  ! done ih

          Do j=1, nr
            Do i=1, nc
             If (icnt(i, j).EQ.0) then    ! fill with missing data
               aggr(i,  j) = -9999.0
             end if
            end do
           end do

          write(*, *) "Aggr'd: output file: ", ofile
	  open(20, file=ofile, form="unformatted", access="direct", &
            recl=nc*nr*4) 
          write(20, rec=1) aggr 
          close(20)
      End Do   ! done with iday 
         
	return 
        End


       function isleap(year)
        logical isleap
        integer year
	if (mod(year, 4).EQ.0 .and. mod(year, 400) .NE. 0) then
        isleap = .true.
        end if
        isleap =  .false.
        end 
          
