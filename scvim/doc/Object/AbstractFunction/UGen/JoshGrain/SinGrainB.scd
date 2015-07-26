
SinGrainB			granular synthesis with sinusoidal grains and user supplied envelope

 *ar(trigger, dur, freq, envbuf, mul, add) 

	trigger - a kr or ar trigger to start a new grain. If ar, grains after the start of the synth are sample accurate.
	The following args are polled at grain creation time
	dur - size of the grain.
	freq - the freq of the grain generators internal oscillator
	envbuf - a buffer with a stored signal to be used for the envelope of the grain
	
Examples:

s.boot;

SynthDef(\sin_grain_test, {arg gate = 1, amp = 1, envbuf;
	Out.ar(0,
		SinGrainB.ar(Impulse.kr(20), 0.2, WhiteNoise.kr.range(440, 880), envbuf,
			EnvGen.kr(
				Env([0, 1, 0], [1, 1], \sin, 1),
				gate,
				levelScale: amp,
				doneAction: 2)
			)
		)
	}).load(s);

z = Env([0, 1, 0], [1, 1], [10, -10]).asSignal(1024);
s.sendMsg(\b_alloc, b = s.bufferAllocator.alloc(1), 1024, 1, [\b_setn, b, 0, 1024] ++ z)
s.sendMsg(\s_new, \sin_grain_test, a=s.nextNodeID, 0, 1, \amp, 0.2, \envbuf, b);
s.sendMsg(\n_set, a, \gate, 0);
s.sendMsg(\b_free, b);


