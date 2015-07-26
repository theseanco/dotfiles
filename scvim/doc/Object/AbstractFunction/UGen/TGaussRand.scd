


TGaussRandtriggered gaussian random distribution

TGaussRand.kr(lo, hi, trig)
TGaussRand.ar(lo, hi, trig)



lo - minimum value
hi - maximum value


(
{ 
	var trig;
	trig = Dust.kr(10);
	Pan2.ar(SinOsc.ar(
			TGaussRand.kr(300, 3000, trig)
		), 
		TGaussRand.kr(-1, 1, trig),
		0.1
	)
}.play;
)
