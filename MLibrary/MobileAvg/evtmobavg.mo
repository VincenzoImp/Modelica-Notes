
within MLibrary.MobileAvg;

model evtmobavg

constant Integer N = 5;   // max num item in buf

constant Integer BufOffset = 5;
constant Integer M = (N+BufOffset) ;

constant Integer BufSize = 1;
constant Integer NumItems = 2;
constant Integer Avg = 3;
constant Integer FirstItem = 4;    // first item index from 0
constant Integer LastItem = 5;     // last item index from 0

Real buf[M];
Real x;

Boolean initbuf;
Boolean insertbuf;

initial equation

//initbuf = false;
//insertbuf = false;
// x = 0;

algorithm

// function initbuf
when (sample(0, 0.1) and initbuf) then

buf[BufSize] := N;
buf[NumItems] := 0;
buf[Avg] := N;
buf[FirstItem] := 0;
buf[LastItem] := 0;

for i in 1:N loop

buf[BufOffset + i] := N/2;

end for;

//initbuf := false;

end when;
/// end initbuf


when (sample(0, 0.1) and insertbuf) then

/*

if (pre(buf[NumItems])  < pre(buf[BufSize]))
then
                       // avg := (avg*size + x)/(size + 1) = (size/(size+1))*avg + x/(size + 1);

  buf[Avg] := (pre(buf[NumItems])/(pre(buf[NumItems]) +1))*pre(buf[Avg]) +
                 (x/(pre(buf[NumItems]) +1));
  buf[NumItems] := pre(buf[NumItems]) + 1;
  buf[FirstItem] := pre(buf[FirstItem]);
else
                                  //  avg := (avg*N - buf[first] + x)/N = avg + (x - buf[first])/N
  buf[Avg] := pre(buf[Avg]) +
  ((x - pre(buf[BufOffset + 1 + integer( floor(pre(buf[FirstItem])) )]) )/(pre(buf[NumItems])));
  buf[FirstItem] := mod(pre(buf[FirstItem]) + 1,pre(buf[BufSize]));
  buf[NumItems] := pre(buf[NumItems]);
end if;


 buf[BufOffset + 1 + integer( floor(pre(buf[LastItem])) )] := x;

 buf[LastItem] := mod(pre(buf[LastItem]) + 1,pre(buf[BufSize]));
 
*/


 for i in (BufOffset+1):M loop
// for i in 1:BufOffset loop
// for i in 1:M loop

buf[i] := 10 + i;

end for;



//insertbuf := false;

end when;
/// end insertbuf



end evtmobavg;

