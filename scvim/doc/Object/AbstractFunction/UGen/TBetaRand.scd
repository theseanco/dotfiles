


TBetaRandtriggered beta random distribution

TBetaRand.kr(lo, hi, prob1, prob2, trig)
TBetaRand.ar(lo, hi, prob1, prob2, trig)



lo - minimum value
hi - maximum value
prob1, prob2 - if prob1 & prob2 are less than 1, values tend towards lo & hi.  if they are equal to 1, there is a linear random distribution.  higher than 1, the distribution tends towards gaussian, with the possibility of a mean skewed towards the prob of the lowest value. 




(
{ 
	var trig = Dust.kr(10);
	SinOsc.ar(
			TBetaRand.kr(300, 3000, 0.1, 0.1, trig)
		) * 0.1
}.play;
)

(
{ 
	var trig, prob1, prob2;
	trig = Dust.kr(10);
	prob1 = MouseX.kr(1, 5);
	prob2 = MouseY.kr(1, 5);
	SinOsc.ar(
			TBetaRand.kr(300, 3000, prob1, prob2, trig)
		) * 0.1
}.play;
)
