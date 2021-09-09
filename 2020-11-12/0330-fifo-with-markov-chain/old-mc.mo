
block Markov_Chain

import Rng = MLibrary.Random.Generator ;

parameter Real T = 0.1;
parameter Integer x_0 = 2;

// parameters for random number generator
parameter Real SP = 1.0;
parameter Integer GS = 74192;
parameter Integer LS = 184629;

Rng.generator1024 r_in(samplePeriod=SP,globalSeed=GS,localSeed=LS);

output Integer x, u;

Real p[mck.N];

initial equation
x = x_0;

algorithm

for i in 1:mck.N loop p[i] := (1.0/mck.N); end for;


when sample(0, T) then

u := pick(r_in.r1024, p) - mck.N;  // just to easy reading of plots

x := next(pre(x), u + mck.N);

end when;


end Markov_Chain;



function  pick
input Real z;
input Real[:] p;   // array of size size(p, 1)
output Integer w;

protected
Integer i;
Real y;

algorithm


i := 1;
y := p[i];

while ((z > y) and (i < size(p, 1))) loop
  i := i + 1;
  y := y + p[i];
end while;

w := i;

end pick;




function  next
input Integer x;
input Integer u;
output Integer y;


algorithm

y := mod(x + u, mck.N);

end next;



record mck   // Markov Chain Constants

constant Integer N = 10;   // number of states of Markov Chain


end mck;