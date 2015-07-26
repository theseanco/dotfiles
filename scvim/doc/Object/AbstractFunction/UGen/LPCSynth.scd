
LPCSynth
LPCVals -    					utilize LPC data

LPCSynth(buffer, signal, pointer, mul, add)
#cps, rmso, err = LPCVals(buffer, pointer)

- LPCSynth uses data from a LPC data file to filter a signal
- LPCVals returns pitch, rms and error data from the LPC data file

buffer - the buffer where data is stored from LPCFile (see LPCFile).
pointer - a pointer into the LPC data file, where 0 is the begining and 1 is the end.
signal - the signal to filter.

Usage

This uses the fate.lpc file, created with the following command:

lpanal -p 50 -h 300 fate.aiff fate.lpc

-p = num poles
-h = hop size in samples 

analysis window are 2X the hop size


s = Server.local.boot;

// this file came with the JoshUGens... Leonard Bernstein talking about Beethoven.
// Place it in your SC3/sounds directory.
a = LPCFile.new("sounds/fate.lpc", server: s).loadToBuffer;

(
z = {
var cps, rmso, err, voc, noise, timepoint, dur;
timepoint = LFSaw.ar(0.4/a.sndDur, 1, 0.5, 0.5);

# cps, rmso, err = LPCVals.ar(a.buffer, timepoint);
// a periodic Blip to filter, amplitude is 1 - error
noise = WhiteNoise.ar(err); // a noise source

voc = Blip.ar(cps, 100);
// the rms values tend to be high... scale them back quite a bit!
Out.ar(0, LPCSynth.ar(a.buffer, voc + noise, timepoint, rmso)); 
}.play(s)
)
z.free;
// clean up
s.sendBundle(0.1, [\b_free, a.buffer]);




