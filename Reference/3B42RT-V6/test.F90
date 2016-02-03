
	program a
        integer tstep, hour, minute, ti, i

        ti = 24*60/48
         
         Do i=1, 100
          write(*, *) "enter hour minute: "
          read(*, *) hour, minute
          write(*, *) "your entered hour minute: ", hour, minute
          tstep = nint( (hour*60 + minute)/ ti + 0.5 )
          write(*, *) "your entered hour minute: ", hour, minute, &
             "tstep=", tstep
         end do

	end

           

