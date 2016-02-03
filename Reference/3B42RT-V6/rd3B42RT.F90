! This problem reads the raw 3B42RT Huffman precip data
! and output in GrADS format. Input data is from 60S to 60N. 
! We crop the data to 50S - 50N. 
! usage: rd3B42RT <inputfile> <outputfile> 

	Program rd3B42RT

	implicit NONE
	integer, parameter :: nc=1440, nr=480
	integer*2 input(nc, nr) 
	real output(nc, nr), output1(nc, nr-80)
        integer i, j,  iargc, N
        character*80 ifile, ofile, ctmp

        i =  iargc()
        If (i.NE.2) Then
          call getarg(0, ctmp) !** get program name
          Write(*, *) "Usage: ", trim(ctmp), &
            " <inputfile> <outputfile>" 
          Stop
        End If

       call getarg(1, ctmp)
       ifile = trim(ctmp)
       call getarg(2, ctmp)
       ofile = trim(ctmp)

        write(*, *)"input file: ", ifile
	open(19, file=ifile, form="unformatted", access="direct", &
            recl=2880, status="old")
        Do j=1, nr
          read(19, rec=(j+1) ) input(:, j)
        End Do
        close(19)

!   Convert integer to real, flip N-S, and set undef values
	Do j=1, nr
	  Do i = 1, nc
           if( input(i, j).GE.0 ) then
             output(i, nr-j+1) = input(i, j)*0.01
	   else 
  	     output(i, nr-j+1) = -9999.0
           end if
	  End Do
        End Do
        Do j=41, 440 
          output1(:, j-40) = output(:, j) 
        End Do 
	open(20, file=ofile, form="unformatted", access="direct", &
          recl=nc*(nr-80)*4)
	write(20, rec=1) output1
    	close(20)

	Stop
	End



