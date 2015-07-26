


LFBrownNoise2			random walk cubic interp


LFBrownNoise2.ar(freq, dev, dist, mul, add)

Random walk with Gendyn distributions.
freq - approximate rate at which to generate random values.
dev - scale maximum step (0-1).
dist - Gendyn distribution to use (0-5: see Gendy1 for details).




(

SynthDef("help-LFNoise2", { arg out=0;
	Out.ar(out, 
		LFBrownNoise2.ar(1000, 1, MouseX.kr(0, 5), 0.25)
	)
}).play;
)

//use as frequency control
(
SynthDef("help-LFNoise2", { arg out=0;
	Out.ar(out, 
		SinOsc.ar(
			LFBrownNoise2.kr(8.dup, 0.2, 0, 400, 450),
			0, 0.2
		)
	)
}).play;
)


