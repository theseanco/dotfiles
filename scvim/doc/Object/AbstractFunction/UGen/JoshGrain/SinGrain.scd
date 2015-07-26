
SinGrain				granular synthesis with sinusoidal grains

 *ar(trigger, dur, freq, mul, add) 

	trigger - a kr or ar trigger to start a new grain. If ar, grains after the start of the synth are sample accurate.
	The following args are polled at grain creation time
	dur - size of the grain.
	freq - the freq of the grain generators internal oscillator
	
Examples:

s.boot;

SynthDef(\sin_grain_test, {arg gate = 1, amp = 1;
	Out.ar(0,
		SinGrain.ar(Impulse.kr(10), 0.2, WhiteNoise.kr.range(440, 880),
			EnvGen.kr(
				Env([0, 1, 0], [1, 1], \sin, 1),
				gate,
				levelScale: amp,
				doneAction: 2)
			)
		)
	}).load(s);
	
s.sendMsg(\s_new, \sin_grain_test, a=s.nextNodeID, 0, 1, \amp, 0.2);
s.sendMsg(\n_set, a, \gate, 0);


