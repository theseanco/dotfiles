
PV_MagMinus			subtract spectral energy



PV_MagMinus.ar(bufferA,  bufferB, remove)


Subtracts buffer B's magnitudes from buffer A.

bufferA - fft buffer A.
bufferB - fft buffer B.
remove - scale the removal process.


s.boot;
(
b = Buffer.alloc(s, 2048, 1);
c = Buffer.alloc(s, 2048, 1);
d = Buffer.read(s, "sounds/a11wlk01.wav");
)

(
SynthDef("help-magMinus", { arg out=0, bufnumA=0, bufnumB=1, soundBufnum=2;
	var inA, inB, chainA, chainB, chain;
	inA = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	inB = WhiteNoise.ar(LFNoise2.kr(20).max(0));
	chainA = FFT(bufnumA, inA);
	chainB = FFT(bufnumB, inB);
	chain = PV_MagMinus(chainA, chainB, MouseX.kr(0, 1)); 
	Out.ar(out,  IFFT(chain).dup);
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum, \soundBufnum, d.bufnum]);
)