
IIRFilter	 24db/oct rolloff, 4nd order resonant Low Pass Filter.


IIRFilter.ar(in, freq, rq, mul, add)

in - input signal to be processed
freq - cutoff frequency.
rq - the reciprocal of Q.  bandwidth / cutoffFreq. 

see also:SOS BLowPass BLowPass4 BHiPass BHiPass4 BLowShelf BHiShelf BBandPass BBandStop BAllPass BMoog

s.boot;
(
z = {
	IIRFilter.ar(
		AudioIn.ar([1,2]),
		MouseX.kr(20,20000,\exponential), // cutoff freq.
		MouseY.kr(0.01, 1.0, \linear), // rq
		0.5); // mul
}.play)
z.release;

(
z = {
	var sig, freq;
	freq = MouseX.kr(20,12000,\exponential);
	sig = IIRFilter.ar(
		LFSaw.ar([freq * 0.99, freq * 1.01], 0, 0.1) ! 2,
		SinOsc.kr(SinOsc.kr(0.1),1.5pi,1550,1800),
		MouseY.kr(0.01,1,\linear));
	 (CombN.ar(sig, 0.4, [0.4,0.35],2) * 0.4) + (sig * 0.5);
}.play)
z.release

