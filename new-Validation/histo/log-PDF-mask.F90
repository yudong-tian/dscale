
! Take a mask file as input
! 12/12/14: make y unit as mm/grid/day

! This program computes the PDF of the hourly rainrate 
! maxbin bins, Range is -1 ~ 2, which is log(rain)
! It outputs the average counts or rainfall ammount per grid
!  as a function of rainfall intensity (mm/day).
! 
! Different data sources were read with different subroutines
!
! usage: ./log-PDF inputfile nc nr nt maskfile


        Program histogram

        implicit NONE
        integer, parameter :: maxbin=43
        integer :: nc, nr, nt 
        real, allocatable :: x(:, :), mask(:, :)  ! mm/d 
        real*8 rain, xbin(maxbin), mind, dist
        real*8 y(maxbin)
        integer  ibin, ngrids, mbin
        integer i, j, it,  iargc, Ns, aflag, lflag, cflag
        character*120 ctmp, dset, ssn, ifile, mfile 
        character*2 fd

        data xbin /0.345, 0.402, 0.468, 0.545, 0.634, 0.7381, 0.859129, &
          1, 1.16397, 1.35483, 1.57698, 1.83556, 2.13654, 2.48687, & 
          2.89464, 3.36928, 3.92175, 4.5648, 5.31329, 6.18452, 7.1986,      &
          8.37896, 9.75287, 11.3521, 13.2135, 15.3801, 17.902, 20.8374,     &
          24.2541, 28.2311, 32.8602, 38.2483, 44.5199, 51.8198, 60.3168,    &
          70.207, 81.7189, 95.1185, 110.715, 128.869, 150.0, 174.6, 203.2/ 

        aflag=1   ! rain volume

        i =  iargc()
        If (i.LT.5) Then
         call getarg(0, ctmp) !** get program name
         Write(*, *) "Usage: ", trim(ctmp), " inputfile nc nr nt maskfile "
         Stop
        End If

       call getarg(1, ifile)    ! inputfile 
       call getarg(2, ctmp)
       read(ctmp, *) nc
       call getarg(3, ctmp)
       read(ctmp, *) nr
       call getarg(4, ctmp)
       read(ctmp, *) nt
       call getarg(5, mfile)    ! mask file  

       !write(*, *) "Input dimension: nc=", nc, "  nr=", nr, "  nt=", nt
       allocate(x(nc, nr)) 
       allocate(mask(nc, nr)) 

       open(14, file=mfile, form="unformatted", access="direct", recl=nc*nr*4)  
         read(14, rec=1) mask
       close(14) 
       open(12, file=ifile, form="unformatted", access="direct", recl=nc*nr*4)  
       
      y = 0.0
      ngrids = 0

      do it =1, nt 
           
         read(12, rec=it) x

         Do j=1, nr 
           Do  i = 1, nc 
            if (mask(i, j) .GT. 0.5) then 

            rain = x(i, j)   ! mm/d
            if( rain.GE.0 ) ngrids = ngrids + 1
            if( rain.GE.0.255 .and. rain.LE.203.2) then

                  ! find the closest bin
                  mind=10000
                  Do ibin=1, maxbin
                    dist =  abs( log(rain)-log(xbin(ibin)) )
                    if ( dist .LT. mind   ) then
                       mind = dist
                       mbin = ibin
                    endif
                  End Do

                  if (aflag .eq. 1) then ! accumulation
                    y(mbin) = y (mbin) + rain
                  else if (aflag .eq. 0) then ! counts
                    y(mbin) = y (mbin) + 1.0D0
                  else
                    write(*, *)"unrecognized accum_flag. stop"
                    stop
                  end if

            endif  ! rain

            endif  ! mask
           End Do
         End Do

        End Do  !it
        close(12) 

        !write(*, *) "ngrids=", ngrids 

        Do ibin = 1, maxbin
         write(*, '(2F14.6)') xbin(ibin), y(ibin)*1.0/ngrids
        End Do

        deallocate(x) 
        deallocate(mask) 
        End


