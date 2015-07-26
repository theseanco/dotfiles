


TBrownRandtriggered random walk generator

TBrownRand.kr(lo, hi, dev, dist, trig)
TBrownRand.ar(lo, hi, dev, dist, trig)



lo - minimum value
hi - maximum value
dev - maximum step (0-1)
dist- Gendyn distribution (0-5: see Gendy1 for details)

Generates a random walk from lo to hi with a Gendyn distribution 
each time the trig signal changes from nonpositive to positive values




(
{ 
	var trig = Dust.kr(10);
	SinOsc.ar(
			TBrownRand.kr(300, 3000, 1.0, MouseX.kr(0, 5), trig)
		) * 0.1
}.play;
)

(
{ 
	var trig = Dust.kr(10);
	Pan2.ar(
		SinOsc.ar(LinExp.kr(TBrownRand.kr(dev:0.2, trig:trig), 0, 1, 300, 3000)),
		TBrownRand.kr(-1.0, 1.0, 1.0, 4, trig),
		0.1
	)
}.play;
)
