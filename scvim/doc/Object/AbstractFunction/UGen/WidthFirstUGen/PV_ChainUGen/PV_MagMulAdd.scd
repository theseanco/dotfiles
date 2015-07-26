
PV_MagMulAdd				simple scaling of FFT magnitudes

chain = PV_MagMulAdd(chain, mul, add)

Applies the following simple linear transformation to every magnitude in the FFT:

	mag = mag * mul + add

This is probably not a very useful audio effect in itself, but may be a component of other analysis or transformation processes...

chain - fft chain.

s.boot;

(
b = Buffer.alloc(s,2048,1);
c = Buffer.read(s,"sounds/a11wlk01.wav");
d = Buffer.alloc(s,2048,1);
)

// Here, mouse left/right controls "mul", so simply amplifies; 
//  up/down is "add", so kind of artificially raises the noise floor.
(
SynthDef("help-pvmagmuladd", {  arg out=0, bufnum=0, soundBufnum=2;
	var in, chain;
	in = PlayBuf.ar(1, soundBufnum, BufRateScale.kr(soundBufnum), loop: 1);
	chain = FFT(bufnum, in);
	chain = PV_MagMulAdd(chain, MouseX.kr(0,2), MouseY.kr(0,1));
	Out.ar(out, 0.3 * IFFT(chain)); 
}).play(s,[\out, 0, \bufnum, b, \soundBufnum, c]);
)


