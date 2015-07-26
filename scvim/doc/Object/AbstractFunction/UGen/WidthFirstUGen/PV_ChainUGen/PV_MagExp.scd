
PV_MagExp					exponential of magnitudes

PV_MagExp(buffer)

Converts the magnitudes to their exponentials. No renormalisation is performed. This can be used in combination with [PV_MagLog] for vocoder manipulation.

WARNING: If you use it without a corresponding PV_MagLog, this is likely to push the levels very very high. So please mind your ears.

buffer - fft buffer.

s.boot;

(
b = Buffer.alloc(s,2048,1);
c = Buffer.read(s,"sounds/a11wlk01.wav");
)

(
SynthDef("help-magexp", {  arg out=0, bufnum=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(bufnum, in);
	chain = PV_MagLog(chain); 
	
	// PV_ConformalMap behaves quite differently in the log domain
	chain=PV_ConformalMap(chain, MouseX.kr(-1.0,1.0), MouseY.kr(-1.0,1.0));

	chain = PV_MagExp(chain); 
	Out.ar(out, 0.3 * IFFT(chain).clip2(1).dup); 
}).play(s,[\out, 0, \bufnum, b.bufnum, \soundBufnum, c.bufnum]);
)


