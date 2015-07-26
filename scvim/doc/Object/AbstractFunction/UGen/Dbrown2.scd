
Dbrown2 demand rate brownian movement with Gendyn distributions

superclass: UGen


*new(lo, hi, step, dist, length)
		
lo		minimum value
hi 		maximum value
step		maximum step for each new value
dist		gendyn distribution (seeGendy1)
length	number of values to create
	
	Dbrown2 returns numbers in the continuous range between lo and hi.
	The arguments can be a number or any other ugen
		
	see also:Demand
	
	
// example
	
	// Dbrown2
	(
	{ 
		var a, freq, trig;
		a = Dbrown2(0, 15, 1, [1, 4], inf);
		trig = Dust.kr(MouseX.kr(1, 40, 1));
		freq = Demand.kr(trig, 0, a) * 30 + 340; 
		SinOsc.ar(freq) * 0.1
	
	}.play;
	)
	
	
	
	
		
	
	