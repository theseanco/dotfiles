
MonoGrainBF		granulates real-time input with Ambisonic panning

MonoGrainBF.ar(in, winsize, grainrate, winrandpct, azimuth, azrand, elevation, elrand, rho, mul, add)

	in - a mono input
	winsize - the window size in seconds
	grainrate - the rate of which new grains are created (in Hz)
	winrandpct - a randomness factor for window size (as a percentage of the winsize)
	azimuth - in radians, -pi to pi
	azrand - percentage of deviation from the azimuth
	elevation - in radians, -0.5pi to 0.5pi
	elrand - percentage of deviation from the elevation
	rho - the speaker radius.  (1 places shound at the radius, <1 within the radius, >1 is outside the radius)
		beyond the radius, this mostly acts as an amplitude scaler (no filtering is done).

Examples:

s.boot;

(
s.sendMsg(\b_allocRead, 0, "sounds/a11wlk01-44_1.aiff", 0, -1);

SynthDef(\monograinbf, {arg buffer = 0;
	var w, x, y, z, out, winsize, grainrate, azimuth, azrand;
	winsize = 0.04;
	grainrate = 100;
	azimuth = MouseX.kr(-pi, pi); // move around the radius
	azrand = MouseY.kr(0, 1); // 0 = no randomness, 1 = totally random
	#w, x, y, z = MonoGrainBF.ar(PlayBuf.ar(1, buffer, loop: 1), winsize, grainrate, 0, azimuth, 		azrand);
	out = DecodeB2.ar(2, w, x, y, 0.5);
	Out.ar(0, out);
}).send(s);

)


s.sendMsg(\s_new, \monograinbf, 1000, 0, 0, \buffer, 0);

s.sendMsg(\n_free, 1000);
s.sendMsg(\b_free, 0);


