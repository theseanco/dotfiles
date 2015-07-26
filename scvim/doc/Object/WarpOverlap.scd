
WarpOverlap			Create a texture of Warps

Inspired by Chad Kirby's SuperCollider2 Warp1 class, which was inspired by Richard Karpen's sndwarp for CSound. A granular time strecher and pitchshifter. See the [Warp1] helpfile for more information about Warp1's specifics. This texture will create a series of Warp1s that keep up with the current time.

WarpOverlap.ar(numChans = 1, buffer, overlaps = 4, starttime = 0, stretch = 1, harm = 1, windowsize = 6, 
			step = 1, warpwindowsize = 0.11, warpwindowoverlaps = 8, warpwindowran = 0.1, mul = 1,
			add = 0)

	buffer - the buffer number of a mono soundfile.
	overlaps - the number of overlapping warps to create (should be equal to or greater then 3).
		this must be a fixed integer. The architechture of the SynthDef
		cannot change after it is compiled.
	starttime - an initial starttime for the warp pointer (in the total buffer)
	stretch - a stretch factor for the individual Warps.
	harm - a float, or an instance of a Ref. If a Ref is used, its values are sequentially distributed among the 
		larger overlapping windows.
	windowsize - the windowsize in seconds of the larger overlapping windows.
	step - a control on the pointer increment. 1 keeps the pointer up with the current time, 0 will halt time.
	warpwindowsize - a float, or an instance of a Ref. The size of the individual warp windows.
	warpwindowoverlaps - a float, or an instance of a Ref. The number of window overlaps for each warp. 
	warpwindowran - a float, or an instance of a Ref. The amount of randomness in each warp's windows.
	


Examples:

s.boot;

(
s.sendMsg(\b_allocRead, 0, "sounds/a11wlk01.wav", 0, -1);

SynthDef(\warpoverlap, {arg buffer = 0, stretch = 1, windowsize = 6, mul = 1, gate = 1;
	var out, env, overlaps, harm, wwinsize, wwinoverlap, wwinran;
	overlaps = 8;
	harm = [3, 7, 5, -12].midiratio.asRef;
	wwinsize = `[0.11, 0.11, 0.11, 0.2];
	wwinsize = 0.11;
	wwinoverlap = 8;
	wwinran = 0.1;
	env = EnvGen.kr(Env([0.01, 1, 0.01], [0.1, 0.1], 'exp', 1), gate, doneAction: 2);
	out = WarpOverlap.ar(1, buffer, overlaps, 0, stretch, harm, windowsize, wwinsize, wwinoverlap, wwinran, mul);
	Out.ar(0, out * env);
}).send(s);

)

s.sendMsg(\s_new, \warpoverlap, a=s.nextNodeID, 0, 1, \buffer, 0, \stretch, 30, \mul, 0.1)

s.sendMsg(\n_free, a);




