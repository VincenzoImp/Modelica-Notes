
model GenerateRandomNumbers //model é un ogetto come class
    //Generate random numbers with the various random number generators

    parameter Real samplePeriod = 1.0; //ogni quanto viene generato il numero
    //Sample period for the generation of random numbers
    parameter Integer globalSeed = 30020; //seed globale
    //Global seed to initialize random number generator

    // Random number generators with exposed state
    parameter Integer localSeed = 614657; //seed locale
    //Local seed to initialize random number generator
    output Real r1024; //Random number generated with Xorshift1024star. é un generatore a 1024 bit

    protected discrete Integer state1024[Modelica.Math.Random.Generators.Xorshift1024star.nState]; //le variabili discrete possono variare solo a tempo discreto nella simulazione. gli interi sono di default discreti e i reali sono di defaul continui. continui significa che possono essere modificati a tempo continuo. inizializziamo questo vettore lungo tanto quanto vale "Modelica.Math.Random.Generators.Xorshift1024star.nState"

    algorithm
        when initial() then //operazione che viene fatta solo all'inizializzazione, questo sostituisce l'inizial equazion. initial() ritorna true solo se stiamo al tempo 0
        // Generate initial state from localSeed and globalSeed

            state1024 := Modelica.Math.Random.Generators.Xorshift1024star.initialState(localSeed, globalSeed); //inizializziamo lo stato del nostro generatore al valore iniziale
            r1024     := 0;
        
        elsewhen sample(0,samplePeriod) then //se non siamo all'inizializzazione e se sample(0,samplePeriod) é vero allora entro
            (r1024,state1024) := Modelica.Math.Random.Generators.Xorshift1024star.random(pre(state1024));
        end when;

end GenerateRandomNumbers;


/*
questo é un generatore random di numeri. genera un numero tra zero e uno con distribuzione uniforme
occorre decidere due seed, uno locale e uno globale
*/






/*

parameter Integer localSeed = 1;
parameter Integer globalSeed = 23;

Integer state[Xorshift1024star.nState];
Real r;

initial equation
  state = initialState(localSeed, globalSeed);


equation

when sample(0, 1) then

 (r, state) = random(pre(state));

end when;



end System;

*/
