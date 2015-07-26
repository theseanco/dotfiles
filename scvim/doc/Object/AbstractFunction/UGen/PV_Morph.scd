
PV_Morph		one kind of spectral morphing

PV_Morph.ar(bufferA,  bufferB, morph)

Morphs between two fft buffers.
bufferA - fft buffer A.
bufferB - fft buffer B.
morph - 0-1.


s.boot;
(
b = Buffer.alloc(s,2048,1);
c = Buffer.alloc(s,2048,1);
d = Buffer.read(s,"sounds/a11wlk01.wav");
)

(
SynthDef("help-morph", { arg out=0, bufnumA=0, bufnumB=1;
	var inA, chainA, inB, chainB, chain;
	inA = Pulse.ar(180, LFCub.kr(1, 0, 0.1, 0.3), 0.5);
	inB = VarSaw.ar(190, 0, LFCub.kr(0.8, 0, 0.4, 0.5), 0.5);
	chainA = FFT(bufnumA, inA);
	chainB = FFT(bufnumB, inB);
	chain = PV_Morph(chainA, chainB, MouseX.kr); 
	Out.ar(out, IFFT(chain).dup);
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum ]);
)

(
SynthDef("help-morph2", { arg out=0, bufnumA=0, bufnumB=1, soundBufnum=2;
	var inA, chainA, inB, chainB, chain;
	inA = Mix.ar(Formant.ar([120, 180], [1200, 2000], [240, 360], 0.2));
	inB = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chainA = FFT(bufnumA, inA);
	chainB = FFT(bufnumB, inB);
	chain = PV_Morph(chainA, chainB, MouseX.kr); 
	Out.ar(out,  IFFT(chain).dup);
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum, \soundBufnum, d.bufnum]);
)
