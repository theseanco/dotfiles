
PV_NoiseSynthP			return only bins that are unstable
PV_PartialSynthP			return only bins that are stable

PV_NoiseSynthP and PV_PartialSynthP base these decisions on whether or not phase data across numFrames is within a given threshold

PV_NoiseSynthP(buffer, threshold, numFrames, initflag)
PV_PartialSynthP(buffer, threshold, numFrames, initflag)

	buffer - the FFT buffer
	threshold - a phase value (in radians) with which to allow values to pass through or be zeroed out
	numFrames - the number of FFT frames needed to make the above decision
	initflag - if 0, all bins are zeroed out while the initial is calculated, if 1, all bins pass through.

Examples:

{SinOsc.ar(440, 0, 0.5) + PinkNoise.ar(0.4)}.play; // a sample sig

SynthDef(\partialsynth, {arg fftbuf;
	var in, chain, out;
	in = SinOsc.ar(440, 0, 0.5) + PinkNoise.ar(0.4);
	chain = FFT(fftbuf, in);
	// resynhtesize according to MouseX if 0, only sound with VERY stable changes of phase
	// will be returned. If pi, everything will be returned (+ or - pi)
	chain = PV_PartialSynthP(chain, MouseX.kr(0, pi));
	out = IFFT(chain);
	Out.ar(0, out.dup); 
	}).load(s);

s.boot;

// the fft buf
s.sendMsg(\b_alloc, 0, 2048);

// start the synth
s.sendMsg(\s_new, \partialsynth, z = s.nextNodeID, 0, 1, \fftbuf, 0);
// free it
s.sendMsg(\n_free, z);
s.sendMsg(\b_free, 0);



SynthDef(\noisesynth, {arg fftbuf;
	var in, chain, out;
	in = SinOsc.ar(440, 0, 0.5) + PinkNoise.ar(0.4);
	chain = FFT(fftbuf, in);
	// resynhtesize according to MouseX if 0, every thing will be returned... as the value
	// increases, bins with VERY stable change of phase are zeroed out, until everything is
	// at +-pi
	chain = PV_NoiseSynthP(chain, MouseX.kr(0, pi));
	out = IFFT(chain);
	Out.ar(0, out.dup); 
	}).load(s);

s.boot;

// the fft buf
s.sendMsg(\b_alloc, 0, 2048);

// start the synth
s.sendMsg(\s_new, \noisesynth, z = s.nextNodeID, 0, 1, \fftbuf, 0);
// free it
s.sendMsg(\n_free, z);
s.sendMsg(\b_free, 0);


s.quit



