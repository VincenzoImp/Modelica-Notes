
block RandomVariable

    output Integer x;

    // import Rng = MLibrary.Random.Generator ;

    parameter Integer N = 5;   // number of slots in probability distribution for random variable

    // Probability Distribution of random variable in {1, 2, ... N}
    parameter Real P[N] =  {0.01, 0.01, 0.96, 0.01, 0.01}; //matrice di distribuzione di probabilitá

    parameter Real samplePeriod = 1.0 //ogni quanti secondi viene generato un numero dal random
    "Sample period for the generation of random numbers";
    parameter Integer globalSeed = 30020 //seed globale
    "Global seed to initialize random number generator";
    // Random number generators with exposed state
    parameter Integer localSeed = 614657 //seed locale
    "Local seed to initialize random number generator";
    output Real r1024 "Random number generated with Xorshift1024star";

    protected discrete Integer state1024[Modelica.Math.Random.Generators.Xorshift1024star.nState];

    algorithm

        assert(check(P), "Probability Distribution does not sum up to 1"); //asserzione che se non risulta piú vera il programma termina. check() é una funzione che controlla che la matrice di distribuzione di probabilitá sommi a 1

        when initial() then //al tempo zero inizializzo le variabli
            // Generate initial state from localSeed and globalSeed
            state1024 := Modelica.Math.Random.Generators.Xorshift1024star.initialState(localSeed, globalSeed);
            r1024 := 0;
            x := 0;
        elsewhen sample(0,samplePeriod) then
            (r1024, state1024) := Modelica.Math.Random.Generators.Xorshift1024star.random(pre(state1024));
            x := pick(r1024, P); //si chiama la funzione pick che ha il seguente compito: il valore uniforme generato dal random (r1024) va ad interrogare la matrice (P) per capire in quale caso é ricaduto. logicamente il valore uniforme generato dal random ha piú probabilitá di capitare nel caso con piú probabilitá descritto nella matrice che si sta interrogando
        end when;

end RandomVariable;



function  pick
    input Real z;   // uniformly distributed random input
    input Real[:] P;   // probability distribution
    output Integer w;  // Random variable
    protected Integer i; 
    protected Real y; 
    
    algorithm
    //  Idea:
    //  if z is in [0, P[1]] then w = 1,
    //  if z is in (P[1], P[1] + P[2]] then w = 2
    //  if z is in (P[1] + P[2], P[1] + P[2] + P[3]] then w = 3
    //  ....
    //  if z is in (P[1] + P[2] + P[3] + .... P[N-1], 1] then w = N

    i := 1;
    y := P[i];

    while ((z > y) and (i < size(P, 1))) loop
        i := i + 1;
        y := y + P[i];
    end while;

    w := i;

end pick;




function  check
    input  Real[:] P;   // probability distribution
    output Boolean w;

    protected Real y;

    algorithm

    y := 0.0;

    for i in 1:size(P, 1) loop  
        y := y + P[i];
    end for;

    // w := ((y >= 0.9999) and (y <= 1.0001));
    w := (y == 1.0);
end check;


