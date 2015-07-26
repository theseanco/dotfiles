
PV_CommonMul			multiplies common magnitudes



PV_CommonMul(bufferA,  bufferB, tolerance, remove)


Returns magnitudes common to bufferA & bufferB within a tolerance level.

bufferA - fft buffer A.
bufferB - fft buffer B.
tolerance -magnitudes within which test will pass
remove -scale uncommon magnitudes


s.boot;
(
b = Buffer.alloc(s, 2048, 1);
c = Buffer.alloc(s, 2048, 1);
d = Buffer.read(s, "sounds/a11wlk01.wav");
)

(
SynthDef("help-commonMul", { arg out=0, bufnumA=0, bufnumB=1, soundBufnum=2;
	var inA, inB, chainA, chainB, chain;
	inA = HPF.ar(Mix.ar(LFSaw.ar([100, 150], 0, 0.2)), 1200);
	inB = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chainA = FFT(bufnumA, inA);
	chainB = FFT(bufnumB, inB);
	chain = PV_CommonMul(chainA, chainB, MouseX.kr(0, 50), MouseY.kr); 
	Out.ar(out,  IFFT(chain).dup);
}).play(s,[\out, 0, \bufnumA, b.bufnum, \bufnumB, c.bufnum, \soundBufnum, d.bufnum]);
)