! This program aggregates 3hrly 3B42RT data into GPCP 1dd grid 
! starting from 0Z to 24Z 
! i.e.,  for day1: 
! day1 = 0.5*0Z + 3Z + 6Z + 9Z + 12Z + 15Z + 18Z + 21Z + 0.5*0Z(day+1)
! usage: aggr-to-gpcp1dd year month 

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
	integer, parameter :: nc=1440, nr=400, nf=8  
	integer, parameter :: ic=360, ir=100
        integer iday, im, iy, ih, i, j, icnt(nc, nr), iargc, Nday(12), ios
	real aggr(nc, nr), input(nc, nr), w(nf+1)
	real gpcp(ic, ir)
        integer lday, lm, ly, hours(nf+1)
        character*80 ifile(nf+1), ofile, ctmp, ctmp2, pref
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
       w(1) = 0.5
       w(nf+1) = 0.5

       write(cim, '(I2.2)') im 
       write(ciy, '(I4.4)') iy 

       Do iday = 1, Nday(im)
        write(ciday, '(I2.2)') iday        
        ofile="3B42RT."//ciy(3:4)//trim(cim)//trim(ciday)//".1dd"
        ly = iy
        lm = im
        lday = iday + 1         ! last day
        if (lday .GT. Nday(lm) ) then 
           lm = im +1     ! last month
           if (lm .EQ. 13) then
              lm = 1
              ly = iy + 1
           end if 
           lday = 1
        end if
        write(cly, '(I4.4)') ly 
        write(clm, '(I2.2)') lm 
        write(clday, '(I2.2)') lday

        !3B42RT.2002021900.1gd4r
        ! present day
        pref = "../"//ciy//trim(cim)//"/3B42RT."//ciy(1:4)//trim(cim)//trim(ciday)
        ifile(1) = trim(pref)//"00.1gd4r" 
        ifile(2) = trim(pref)//"03.1gd4r"
        ifile(3) = trim(pref)//"06.1gd4r"
        ifile(4) = trim(pref)//"09.1gd4r"
        ifile(5) = trim(pref)//"12.1gd4r" 
        ifile(6) = trim(pref)//"15.1gd4r" 
        ifile(7) = trim(pref)//"18.1gd4r" 
        ifile(8) = trim(pref)//"21.1gd4r"

        ! last day
        pref = "../"//cly//trim(clm)//"/3B42RT."//cly(1:4)//trim(clm)//trim(clday)
        ifile(9) = trim(pref)//"00.1gd4r" 
        
        aggr = 0.0 
        icnt = 0
        Do ih = 1, nf+1
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
              aggr(i, j) = aggr(i, j) + input(i, j) * 3.0 * w(ih)   !with weight
              icnt(i, j) = icnt(i, j) + 1
             end if
            End Do
           End Do

         end if

        End Do  ! done ih

          Do j=1, nr
            Do i=1, nc
             If (icnt(i, j).LE.3) then    ! fill with missing data
               aggr(i,  j) = -9999.0
             else
               aggr(i,  j) = aggr(i, j) * nf / icnt(i, j)  !avg to daily
             end if
            end do
           end do

	call to1dd(aggr, gpcp, nc, nr, ic, ir) 

          write(*, *) "Aggr'd: output file: ", ofile
	  open(20, file=ofile, form="unformatted", access="direct", &
            recl=ic*ir*4) 
          write(20, rec=1) gpcp 
          close(20)
      End Do   ! done with iday 
         
	return 
        End


       function isleap(year)
        logical isleap
        integer year
	if (mod(year, 4).EQ.0 .and. mod(year, 400) .NE. 0) then
         isleap = .true.
        else
         isleap =  .false.
        endif
        end 
          
! convert 0.25-degree to 1-degree grid
       subroutine to1dd(aggr, gpcp, nc, nr, ic, ir) 
	real aggr(nc, nr), gpcp(ic, ir) 
	integer cnt(ic, ir) 
	integer i, j, i1, j1 

	Do j=1, ir
	 Do i=1, ic
           gpcp(i, j) = 0.0 
           cnt(i, j) = 0 
           Do j1 = (j-1)*4 + 1, j*4
             Do i1 = (i-1)*4 + 1, i*4
              If(aggr(i1, j1).GE.0.0) then   !* skip undef
                gpcp(i, j) = gpcp(i, j) + aggr(i1, j1)/16.0
                cnt(i, j) = cnt(i, j) + 1
              end if 
	     End Do ! i1
	   End Do ! j1 

           If (cnt(i, j).LE.7) then    ! fill with missing data
               gpcp(i,  j) = -9999.0
           else
               gpcp(i,  j) = gpcp(i, j) * 16 / cnt(i, j)  
           end if
	
	 End Do ! i
        End Do ! j

	return
	end 


               
          

	 




