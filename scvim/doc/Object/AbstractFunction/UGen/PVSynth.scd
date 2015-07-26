
PVSynth			resyntesize data with a bank of sine tones from a CSound PV analysis file

PVSynth.ar(pvbuffer, numBins, binStart, binSkip, filePointer, freqMul, freqAdd, mul, add )

This currently only works with .pv files. .pvx and CSound 5 files will be implemented soon.
DANGER! The values stored inside the pv file for magnitudes are NOT scaled to a linear amplitude system. See PVFile (and the example below) for suggestions on how to scale these values so you don't destroy things.

pvbuffer - The buffer containing pv data (stored with PVFile)
numBins - The number of bins to resynthesize. Default is 0.
binStart - The bin number to start on. Default value is 0.
binSkip - The number of bins to skip. Default value is 1.
filePointer - A pointer into the soundfile. 0.0 is the beginning, 1.0 is the end. Default value is 0.
freqMul - Freq value scaler. Default value is 1.0.
freqAdd - Freq value offset. Default value is 0.0.

See also: PVFile, PVInfo

s = Server.local.boot;

// load a file and save it to a buffer
a = PVFile.new("sounds/cl-c4.pv", s).loadToBuffer;

// what this example does
(
x = SynthDef(\helpPVSynth, {arg scale = 1;
	Out.ar(0, Pan2.ar(
		PVSynth.ar(a.buffer, a.nBins, 0, 1, MouseX.kr(0, 1), 
			mul: a.magScale * scale),
		0.0));
}).play(s, [\scale, 0.2]);
)

x.free;


