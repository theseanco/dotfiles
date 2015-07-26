
PV_Compander			simple spectral compression/expansion

PV_Compander.ar(buffer,  thresh, slopeAbove, slopeBelow)

applies compression/expansion to individual magnitudes.
buffer - fft buffer A.
thresh -mag thresh  
slopeAbove, slopeBelow- same as Compander


s.boot;
(
b = Buffer.alloc(s, 2048, 1);
c = Buffer.read(s, "sounds/a11wlk01.wav");
)

// mostly compress
(
SynthDef("help-Compander", { arg out=0, bufnum=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(bufnum, in);
	chain = PV_Compander(chain, MouseX.kr(1, 50), 1.2, 0.25); 
	Out.ar(out,  IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum, \soundBufnum, c.bufnum]);
)	

// mostly expand
(
SynthDef("help-Compander2", { arg out=0, bufnum=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(bufnum, in);
	chain = PV_Compander(chain, MouseX.kr(1, 50), 2.0, 0.85); 
	Out.ar(out, IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum, \soundBufnum, c.bufnum]);
)

// pv sustainer
(
SynthDef("help-Compander3", { arg out=0, bufnum=0;
	var trig, in, chain;
	in =Mix.ar(Ringz.ar(GaussTrig.ar(7.3), [160, 180], 0.2)).softclip;
	chain = FFT(bufnum, in);
	chain = PV_Compander(chain, MouseX.kr(1, 80), 0.1, 1.0); 
	Out.ar(out, Limiter.ar(IFFT(chain), 0.999, 0.05).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)	

(
SynthDef("help-Compander3", { arg out=0, bufnum=0;
	var trig, in, chain;
	in=LPF.ar(Mix.ar(CombL.ar(Decay.ar(Dust.ar(0.5.dup(4)), 0.01, WhiteNoise.ar), 0.02, Array.rand(4, 0.005, 0.01), 0.2)), 1500);
	chain = FFT(bufnum, in);
	chain = PV_Compander(chain, MouseX.kr(1, 80), 0.1, 1.0); 
	Out.ar(out, Limiter.ar(IFFT(chain), 0.999, 0.05).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)		
		

