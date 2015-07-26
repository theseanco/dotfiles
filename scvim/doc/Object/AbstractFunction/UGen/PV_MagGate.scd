
PV_MagGate			reduces magnitudes above or below thresh

PV_MagGate.ar(buffer,  thresh, remove)

For positive values of thresh, acts something like a noise reduction.  For negative values, highlights smaller sounds.
buffer - fft buffer A.
thresh - if positive, scales magnitudes below thresh.  if negative scales magnitudes above abs(thresh)
remove -amount to scale magnitudes.


s.boot;
(
b = Buffer.alloc(s, 2048, 1);
c = Buffer.read(s, "sounds/a11wlk01.wav");
)

(
SynthDef("help-magGate", { arg out=0, bufnum=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(bufnum, in);
	chain = PV_MagGate(chain, MouseX.kr(0, 100), MouseY.kr(0, 1)); 
	Out.ar(out,  IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum, \soundBufnum, c.bufnum]);
)	

(
SynthDef("help-magGate2", { arg out=0, bufnum=0, soundBufnum=2;
	var in, chain, remove;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(bufnum, in);
	remove = MouseY.kr(0, 1);
	chain = PV_MagGate(chain, MouseX.kr(-50, 0), remove); 
	Out.ar(out,  (remove * 3 - 2) * IFFT(chain).dup);
}).play(s,[\out, 0, \bufnum, b.bufnum, \soundBufnum, c.bufnum]);
)		
		

