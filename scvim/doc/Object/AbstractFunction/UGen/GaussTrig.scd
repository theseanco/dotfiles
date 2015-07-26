


GaussTrig			impulses around a certain frequency


GaussTrig.ar(freq, dev, mul, add)



freq - mean frequency.
dev - random deviation from mean (0 <= dev < 1)





(

SynthDef("help-GaussTrig", { arg out=0;
	Out.ar(out, 
		Ringz.ar(
			WhiteNoise.ar(
				Decay.kr(
					GaussTrig.kr(10.dup, MouseX.kr(0, 0.9), 0.5),
					0.02,
					0.2
				)
			),
			2000,
			0.02
		).fold2(0.2)
	)
}).play;
)





