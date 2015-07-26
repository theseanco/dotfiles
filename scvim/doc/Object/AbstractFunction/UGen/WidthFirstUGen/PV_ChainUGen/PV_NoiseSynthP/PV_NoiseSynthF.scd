
PV_NoiseSynthF			return only bins that are unstable
PV_PartialSynthF			return only bins that are stable

PV_NoiseSynthF and PV_PartialSynthF base these decisions on whether or not freq data across numFrames is within a given threshold

PV_NoiseSynthF(buffer, threshold, numFrames)
PV_PartialSynthF(buffer, threshold, numFrames)

Examples:

{SinOsc.ar(440, 0, 0.5) + PinkNoise.ar(0.4)}.play; // a sample sig

SynthDef(\partialsynth, {arg fftbuf;
	var in, chain, out;
	in = SinOsc.ar(440, 0, 0.5) + PinkNoise.ar(0.4);
	chain = FFT(fftbuf, in);
	// resynhtesize according to MouseX. If 0, only sound with VERY stable changes of frequecy
	// will be returned. Upper limit should be Nyqust / nBins , e.g. 22050 / 2048 -> 21.532
	// or + and - 21.532
	chain = PV_NoiseSynthF(chain, MouseX.kr(0, 21.532));
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
	// resynhtesize according to MouseX. If 0, only sound with VERY stable changes of frequecy
	// will be zeroed out. Upper limit should be Nyqust / nbins , e.g. 22050 / 1024 -> 21.532
	// or + and - 21.532
	chain = PV_NoiseSynthF(chain, MouseX.kr(0, 21.532));
	out = IFFT(chain);
	Out.ar(0, out.dup); 
	}).load(s);


// the fft buf
s.sendMsg(\b_alloc, 0, 2048);

// start the synth
s.sendMsg(\s_new, \noisesynth, z = s.nextNodeID, 0, 1, \fftbuf, 0);
// free it
s.sendMsg(\n_free, z);
s.sendMsg(\b_free, 0);


s.quit



