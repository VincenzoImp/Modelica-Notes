
block Markov_Chain


import Rng = MLibrary.Random.Generator ;

parameter Integer N = 5;   // size of Markov chain
parameter Integer x_0 = 1;  // initial state MC

// Transition Matrix MC
parameter Real A[N, N] =
{
{0.1, 0.1, 0.1, 0.3, 0.4},
{0.1, 0.1, 0.1, 0.4, 0.3},
{0.1, 0.1, 0.1, 0.35, 0.35},
{0.1, 0.1, 0.1, 0.2, 0.5},
{0.1, 0.1, 0.1, 0.1, 0.6}
};

output Integer x;
output Integer size = N;


      parameter Real samplePeriod = 1.0
        "Sample period for the generation of random numbers";
      parameter Integer globalSeed = 30020
        "Global seed to initialize random number generator";

    // Random number generators with exposed state
      parameter Integer localSeed = 614657
        "Local seed to initialize random number generator";
       output Real r1024 "Random number generated with Xorshift1024star";

protected
      discrete Integer state1024[Modelica.Math.Random.Generators.Xorshift1024star.nState];

algorithm
      when initial() then
        // Generate initial state from localSeed and globalSeed

        state1024 := Modelica.Math.Random.Generators.Xorshift1024star.initialState(localSeed, globalSeed);
        r1024     := 0;
	x := x_0;
	
      elsewhen sample(0,samplePeriod) then
       (r1024,state1024) := Modelica.Math.Random.Generators.Xorshift1024star.random(pre(state1024));
       x := pick(r1024, pre(x), A);
       
      end when;


end Markov_Chain;



function  pick
input Real z;   // uniformly random input
input Integer x;  // present state
input Real[:,:] A;   // Transition Matrix
output Integer w;  // next state

protected
Integer i;
Real y;

algorithm


i := 1;
y := A[x, i];

while ((z > y) and (i < size(A, 1))) loop
  i := i + 1;
  y := y + A[x, i];
end while;

w := i;

end pick;


