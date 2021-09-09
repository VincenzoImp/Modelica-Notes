
within MLibrary.MobileAvg;

model mobileavg

constant Integer N = 100;   // max num item in buf

constant Integer BufOffset = 5;
constant Integer M = (N+BufOffset) ;

constant Integer BufSize = 1;
constant Integer NumItems = 2;
constant Integer Avg = 3;
constant Integer FirstItem = 4;    // first item index from 0
constant Integer LastItem = 5;     // last item index from 0

Real buf[M];

function init
output Real outbuf[M];

algorithm

  outbuf[BufSize] := N;
outbuf[NumItems] := 0;
outbuf[Avg] := 0;
outbuf[FirstItem] := 0;
outbuf[LastItem] := 0;


for i in 1:N loop

outbuf[BufOffset + i] := 0;

end for;


end init;


function insert
input Real x;
input Real inbuf[M];
output Real outbuf[M];

protected

algorithm

outbuf[BufSize] := inbuf[BufSize];

for i in 1:N loop

outbuf[BufOffset + i] := inbuf[BufOffset + i];

end for;

if (inbuf[NumItems]  < inbuf[BufSize])
then
                       // avg := (avg*size + x)/(size + 1) = (size/(size+1))*avg + x/(size + 1);

  outbuf[Avg] := (inbuf[NumItems]/(inbuf[NumItems] +1))*inbuf[Avg] +
                 (x/(inbuf[NumItems] +1));
  outbuf[NumItems] := inbuf[NumItems] + 1;
  outbuf[FirstItem] := inbuf[FirstItem];
else
                                  //  avg := (avg*N - buf[first] + x)/N = avg + (x - buf[first])/N
  outbuf[Avg] := inbuf[Avg] +
  ((x - inbuf[BufOffset + 1 + integer( floor(inbuf[FirstItem]) )] )/(inbuf[NumItems]));
  outbuf[FirstItem] := mod(inbuf[FirstItem] + 1,inbuf[BufSize]);
  outbuf[NumItems] := inbuf[NumItems];
end if;


 outbuf[BufOffset + 1 + integer( floor(inbuf[LastItem]) )] := x;

 outbuf[LastItem] := mod(inbuf[LastItem] + 1,inbuf[BufSize]);


end insert;




end mobileavg;

