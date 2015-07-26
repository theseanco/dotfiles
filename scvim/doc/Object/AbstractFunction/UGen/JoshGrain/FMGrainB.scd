
FMGrainB				granular synthesis with FM grains and user supplied envelope

 *ar(trigger, dur, carfreq, modfreq, index, envbuf, mul, add) 

	trigger - a kr or ar trigger to start a new grain. If ar, grains after the start of the synth are sample accurate.
	The following args are polled at grain creation time
	dur - size of the grain.
	carfreq - the carrier freq of the grain generators internal oscillator
	modfreq - the modulating freq of the grain generators internal oscillator
	index - the index of modulation
	envbuf - a buffer with a stored signal to be used for the envelope of the grain
	
Examples:

s.boot;

SynthDef(\fm_grain_test, {arg gate = 1, amp = 1, envbuf;
	Out.ar(0,
		FMGrainB.ar(Impulse.kr(10), 0.2, WhiteNoise.kr.range(440, 880), 200, 
			LFNoise1.kr(1).range(1, 10), envbuf,
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
s.sendMsg(\s_new, \fm_grain_test, a=s.nextNodeID, 0, 1, \amp, 0.2, \envbuf, b);
s.sendMsg(\n_set, a, \gate, 0);
s.sendMsg(\b_free, b);


