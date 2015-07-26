
MonoGrain			granulates real-time input

MonoGrain.ar(in, winsize, grainrate, winrandpct, mul, add)

	in - a mono input
	winsize - the window size in seconds
	grainrate - the rate of which new grains are created (in Hz)
	winrandpct - a randomness factor for window size (as a percentage of the winsize)	

Examples:

s.boot;

(
s.sendMsg(\b_allocRead, 0, "sounds/a11wlk01-44_1.aiff", 0, -1);

SynthDef(\monograin, {arg buffer = 0;
	var out, winsize, grainrate;
	winsize = MouseX.kr(0.1, 0.01);
	grainrate = MouseY.kr(10, 4);
	out = MonoGrain.ar(PlayBuf.ar(1, buffer, loop: 1), winsize, grainrate, 0); 
	Out.ar(0, out);
}).send(s);

)


s.sendMsg(\s_new, \monograin, 1000, 0, 0, \buffer, 0);

s.sendMsg(\n_free, 1000)


