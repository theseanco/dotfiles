
BufGrain				granular synthesis with sound sampled in a buffer

 *ar(trigger, dur, sndbuf, rate, pos, interp, mul, add) 

	trigger - a kr or ar trigger to start a new grain. If ar, grains after the start of the synth are sample accurate.
	The following args are polled at grain creation time
	dur - size of the grain.
	sndbuf - the buffer holding an audio signal
	rate - the playback rate of the sampled sound
	pos - the playback position for the grain to start with (0 is beginning, 1 is end of file)
	interp - the kind of interpolation for the sampled sound in the grain (1 - none, 2 - linear, 4 - cubic)
	
Examples:

s.boot;

SynthDef(\buf_grain_test, {arg gate = 1, sndbuf, amp = 1;
	Out.ar(0,
		BufGrain.ar(Impulse.kr(10), 0.2, sndbuf, MouseX.kr(0.5, 8), PinkNoise.kr.range(0, 1), 2,
			EnvGen.kr(
				Env([0, 1, 0], [1, 1], \sin, 1),
				gate,
				levelScale: amp,
				doneAction: 2)
			)
		)
	}).load(s);
	
s.sendMsg(\b_allocRead, z = s.bufferAllocator.alloc(1), "sounds/a11wlk01-44_1.aiff");

s.sendMsg(\s_new, \buf_grain_test, a=s.nextNodeID, 0, 1, \amp, 0.2, \sndbuf, z);
s.sendMsg(\n_set, a, \gate, 0);
s.sendMsg(\b_free, z);


