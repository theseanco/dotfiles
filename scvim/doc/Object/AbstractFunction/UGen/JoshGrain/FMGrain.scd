
FMGrain				granular synthesis with FM grains

 *ar(trigger, dur, carfreq, modfreq, index, mul, add) 

	trigger - a kr or ar trigger to start a new grain. If ar, grains after the start of the synth are sample accurate.
	The following args are polled at grain creation time
	dur - size of the grain.
	carfreq - the carrier freq of the grain generators internal oscillator
	modfreq - the modulating freq of the grain generators internal oscillator
	index - the index of modulation
	
Examples:

s.boot;

SynthDef(\fm_grain_test, {arg gate = 1, amp = 1;
	Out.ar(0,
		FMGrain.ar(Impulse.ar(20), 0.2, 440, 200, 
			LFNoise1.kr(1).range(1, 10),
			EnvGen.kr(
				Env([0, 1, 0], [1, 1], \sin, 1),
				gate,
				levelScale: amp,
				doneAction: 2)
			)
		)
	}).load(s);
	
s.sendMsg(\s_new, \fm_grain_test, a=s.nextNodeID, 0, 1, \amp, 0.1);
s.sendMsg(\n_set, a, \gate, 0);


