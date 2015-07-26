
PV_OddBin			Return the odd numbered bins in an FFT buffer
PV_EvenBin			Return the even numbered bins in an FFT buffer

PV_OddBin(buffer)
PV_EvenBin(buffer)

Examples:

// resynthesize only odd or even bins

{SinOsc.ar(440 + SinOsc.kr(0.05).range(0, 440), 0, 0.5)}.play; // a sample sig

SynthDef(\evenbin, {arg fftbuf1, fftbuf2;
	var in, chain1, chain2, out1, out2;
	in = SinOsc.ar(440 + SinOsc.kr(0.05).range(0, 440), 0, 0.5);
	chain1 = FFT(fftbuf1, in);
	chain1 = PV_EvenBin(chain1);
	out1 = IFFT(chain1);
	chain2 = FFT(fftbuf2, in);
	chain2 = PV_OddBin(chain2);
	out2 = IFFT(chain2);
//	Out.ar(0, out1 + out2); // add back together
	Out.ar(0, [out1, out2]); // or split apart
	}).load(s);

s.boot;

// the fft buf
s.sendMsg(\b_alloc, 0, 2048);
s.sendMsg(\b_alloc, 1, 2048);

// start the synth
s.sendMsg(\s_new, \evenbin, z = s.nextNodeID, 0, 1, \fftbuf1, 0, \fftbuf2, 1);
// free it
s.sendMsg(\n_free, z);
s.sendMsg(\b_free, 0);
s.sendMsg(\b_free, 1);

s.quit



