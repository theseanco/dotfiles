
TGrains2		buffer granulator with linear att/dec



Triggers generate grains from a buffer. Each grain has a linear and is panned between two channels of multiple outputs.


TGrains2.ar(numChannels, trigger, bufnum, rate, centerPos, dur, pan, amp, att, dec, interp)


numChannels - number of output channels.
trigger - at each trigger, the following arguments are sampled and used 
		as the arguments of a new grain. 
		A trigger occurs when a signal changes from <= 0 to > 0.
		If the trigger is audio rate then the grains will start with sample accuracy.
bufnum - the index of the buffer to use. It must be a one channel (mono) buffer.
rate   -  1.0 is normal, 2.0 is one octave up, 0.5 is one octave down
			-1.0 is backwards normal rate ... etc.
		Unlike PlayBuf, the rate is multiplied by BufRate, so you needn't do that yourself.
centerPos - the position in the buffer in seconds at which the grain envelope will reach 
			maximum amplitude.
dur    -   duration of the grain in seconds.
pan    -   a value from -1 to 1. Determines where to pan the output in the same manner as PanAz.
amp   - amplitude of the grain.
att- attack time of grain in seconds.
dec- decay time of grain in seconds.
interp - 1,2,or 4. Determines whether the grain uses (1) no interpolation, (2) linear interpolation, 
			or (4) cubic interpolation.



s.sendMsg(\b_allocRead, 10, "sounds/a11wlk01.wav");

(
{
	var b = 10, trate, dur, clk;
	trate = MouseY.kr(2,200,1);
	dur = 4 / trate;
	clk = Dust.kr(trate);
	TGrains2.ar(2, clk, 10, 1.0, LFNoise2.kr(0.5).range(0, BufDur.kr(b)), dur, 0, TRand.kr(0.1, 0.2, clk), MouseX.kr(0.003, 0.01), 0.007, 4);
}.play;
)

(
{
	var b = 10, trate, dur, clk, pos, pan;
	trate = MouseY.kr(8,120,1);
	dur = 12 / trate;
	clk = Impulse.kr(trate);
	pos = MouseX.kr(0,BufDur.kr(b)) + TRand.kr(0, 0.01, clk);
	pan = WhiteNoise.kr(0.6);
	TGrains2.ar(2, clk, b, 1, pos, dur, pan, 0.1, dur * 0.3, dur * 0.5);
}.play;
)