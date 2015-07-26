
PV_MagLog					log of magnitudes

PV_MagLog(buffer)

Converts the magnitudes to their log values. No renormalisation is performed. This is primarily intended for analysis purposes, but can also be used in combination with [PV_MagExp] for vocoder manipulation.

buffer - fft buffer.

s.boot;

(
b = Buffer.alloc(s,2048,1);
c = Buffer.read(s,"sounds/a11wlk01.wav");
)

(
SynthDef("help-maglog", {  arg out=0, bufnum=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(bufnum, in);
	chain = PV_MagLog(chain); 
	// No effect; just convert to log and back...
	chain = PV_MagExp(chain); 
	Out.ar(out, 0.3 * IFFT(chain).poll.dup); 
}).play(s,[\out, 0, \bufnum, b.bufnum, \soundBufnum, c.bufnum]);
)


