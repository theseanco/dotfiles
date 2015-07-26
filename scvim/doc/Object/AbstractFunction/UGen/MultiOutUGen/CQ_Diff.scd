

CQ_Diff		Logarithmic spectral difference measure


CQ_Diff.kr(in1, in2, databufnum)


A measure of spectral difference. Uses the "Constant Q" transformation to analyse on a logarithmic frequency scale, which hopefully avoids one problem with difference measures based directly on FFT bin differences, namely that its linear frequency scale can end up prioritising the higher frequencies. The comparison is still quite crude, however. Weighting of frequency bins according to known perceptual curves would be one way to improve the comparison, but has not been implemented here.

The constant Q code has largely been stolen from the [Qitch] UGen. As with that UGen, you MUST initialise it with a suitable auxiliary data file - please read the Qitch helpfile for more details.



Example:



s = Server.local.boot;


b = Buffer.read(s, "QspeckernN2048SR44100.wav"); 
//this line is absolutely essential! You must load the data required by the UGen! 


( // The left and right channel will be compared...
x = {	|f1=440, f2=440, n1=0, n2=0, v1=1, v2=1|
	[
		SinOsc.ar(f1, 0, 0.3) + WhiteNoise.ar(n1) * v1,
		SinOsc.ar(f2, 0, 0.3) + WhiteNoise.ar(n2) * v2
	]
}.play(s);
)

(
y = {
	var l,r;
	
	# l, r = In.ar([0,1]);
	
	CQ_Diff.kr(l, r, b.bufnum).poll(3, "CQ_Diff:");
}.play(s, addAction: \addToTail);
)


// Now vary the left and right channels...
x.set(\f1, 439);
x.set(\f1, 139);
x.set(\f1, 1440);
x.set(\f1, 440);
x.set(\n1, 0.1);
x.set(\n1, 0.3);
x.set(\n1, 0.9);
x.set(\n1, 0.0);
x.set(\v1, 0.0);
x.set(\v2, 0.0);


x.free;

// Also try it with this test signal:
(
x = {	|f1=440, f2=440|
	[
		LPF.ar(WhiteNoise.ar, f1),
		LPF.ar(WhiteNoise.ar, f2)
	]
}.play(s);
)
