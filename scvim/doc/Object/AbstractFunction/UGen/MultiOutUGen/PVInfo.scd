
PVInfo			return mag and freq data from a CSound pv

#mag, freq = PVInfo.ar(pvbuffer, binNum, filePointer, mul, add )
#mag, freq = PVInfo.kr(pvbuffer, binNum, filePointer, mul, add )

Here is a short prose explanation of what the UGen does, and any other relevant points.
pvbuffer - explanation of pvbuffer. Default value is nil.
binNum - explanation of binNum. Default value is 0.
filePointer - explanation of filePointer. Default value is 0.
mul - explanation of mul. Default value is 1.
add - explanation of add. Default value is 0.

See also:  PVSynth, PVFile


s = Server.local.boot;

// load a file and save it to a buffer
a = PVFile.new("sounds/cl-c4.pv", s).loadToBuffer;

// what this example does
(
x = SynthDef(\helpPVSynth, {arg scale = 1;
	var src, filts, mag, freq, point;
	src = WhiteNoise.ar;
	point = MouseX.kr(0, 1);
	filts = Mix.fill(100, {arg i;
		#mag, freq = PVInfo.ar(a.buffer, i + 5, point);
		BPF.ar(src, freq, 0.001, mag);
		});
	Out.ar(0, Pan2.ar(filts * a.magScale * scale), 0.0);
}).play(s, [\scale, 2]);
)

x.free;


