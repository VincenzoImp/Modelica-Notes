
block Markov_Chain

    output Integer x;

    // import Rng = MLibrary.Random.Generator ;

    parameter Integer N = 3;   // size of Markov chain. numero di stati
    parameter Integer x_0 = 1;  // initial state MC. stato iniziale

    // Transition Matrix MC
    parameter Real A[N, N] = //matrice di transizione
    [
    0.1, 0.8, 0.1;
    0.1, 0.1, 0.8;
    0.8, 0.1, 0.1
    ];

    parameter Real samplePeriod = 1.0 //ogni quanti secondi viene generato un numero random
        "Sample period for the generation of random numbers";
    parameter Integer globalSeed = 30020 //seed globale
        "Global seed to initialize random number generator";
        // Random number generators with exposed state
    parameter Integer localSeed = 614657 //seed locale
        "Local seed to initialize random number generator";
    output Real r1024 "Random number generated with Xorshift1024star";

    protected discrete Integer state1024[Modelica.Math.Random.Generators.Xorshift1024star.nState];

    algorithm
        when initial() then //inizializzo le variabili
            // Generate initial state from localSeed and globalSeed
            state1024 := Modelica.Math.Random.Generators.Xorshift1024star.initialState(localSeed, globalSeed);
            r1024 := 0;
            x := x_0;
        
        elsewhen sample(0,samplePeriod) then //aggiorno le variabili
            (r1024,state1024) := Modelica.Math.Random.Generators.Xorshift1024star.random(pre(state1024));
            x := pick(r1024, pre(x), A); //x indica lo stato in cui ho transito dopo il colpo di clock appena avvenuto, quindi alla funzione pick do in input il numero tra 0 e 1 generato dal generatore randomico uniforme, lo stato in cui stavo prima del colpo di clock, e la matrice di transizione. e la funzione pick mi restituisce lo stato in cui sono transito allo scattare del colpo di clock
        
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


