
SinGrainIBF				granular synthesis with sinusoidal grains with Ambisonic panning
								and user supplied envelopes

 *ar(trigger, dur, freq, , envbuf1, envbuf2, ifac, azimuth, elevation, rho, wComp, mul, add) 

	trigger - a kr or ar trigger to start a new grain. If ar, grains after the start of the synth are sample accurate.
	The following args are polled at grain creation time
	dur - size of the grain.
	freq - the freq of the grain generators internal oscillator
	envbuf1 - a buffer with a stored signal to be used for the envelope of the grain
	envbuf2 - a buffer with a stored signal to be used for the envelope of the grain
	ifac - an interpolation factor. interpolates between the two envelopes where 0 is all envbuf1, and 1 is all
		envbuf2
	azimuth -  in radians, -pi to pi
	elevation -  in radians, -0.5pi to +0.5pi
	rho - the speaker radius (1 places shound at the radius, <1 within the radius, >1 is outside the radius)
		beyond the radius, nothing happens.
	wComp - chooses how the W channels is scaled. If 0, a scaler of 0.707 is used. If 1, W is varied according 
		to the scaling of the X, Y and Z channels. 0 is the default.

	
Examples:

s.boot;

SynthDef(\sin_grain_test, {arg gate = 1, amp = 1, envbuf1, envbuf2;
	var w, x, y, z, trig;
	trig = Impulse.kr(20);
	#w, x, y, z = SinGrainIBF.ar(trig, 0.05, WhiteNoise.kr.range(440, 880), envbuf1, envbuf2,
		MouseX.kr(0, 1),
		WhiteNoise.kr.range(-0.25pi, 0.25pi), 0, 1,
			EnvGen.kr(
				Env([0, 1, 0], [1, 1], \sin, 1),
				gate,
				levelScale: amp,
				doneAction: 2)
			);
	Out.ar(0, DecodeB2.ar(4, w, x, y));
	}).load(s);
	
y = Env([0, 1, 0], [1, 1], \sin).asSignal(1024);
z = Env([0, 1, 0], [1, 1], [10, -10]).asSignal(1024);
s.sendMsg(\b_alloc, b = s.bufferAllocator.alloc(1), 1024, 1, [\b_setn, b, 0, 1024] ++ y)
s.sendMsg(\b_alloc, c = s.bufferAllocator.alloc(1), 1024, 1, [\b_setn, c, 0, 1024] ++ z)
s.sendMsg(\s_new, \sin_grain_test, a=s.nextNodeID, 0, 1, \amp, 0.2, \envbuf1, b, \envbuf2, c);
s.sendMsg(\n_set, a, \gate, 0);
s.sendMsg(\b_free, b);
s.sendMsg(\b_free, c);


