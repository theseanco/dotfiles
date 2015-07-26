
BMoog	24db/oct rolloff - 4nd order resonant Low/High/Band Pass Filter.


BMoog.ar(in, freq, q, mode, saturation, mul, add)

BlackRain's yet 'nother moog impersonation. oh yes.



in - input signal to be processed
freq - cutoff frequency.
q - bandwidth / cutoffFreq.  0 < q > 1
mode- filter mode:
	< 1 - low pass filter.
	< 2 - high pass filter.
	< 3 - bandpass filter.
	defaults to lowpass.
	
see also:SOS RLPF RHPF BLowPass BLowPass4 BHiPass BHiPass4 BLowShelf BHiShelf BBandPass BBandStop BAllPass IIRFilter

s.boot;
(
z = {
	BMoog.ar(
		AudioIn.ar([1,2]),
		MouseX.kr(20,20000,\exponential), // cutoff freq.
		MouseY.kr(1.0, 0.0, \linear), // q
		0, // mode - lowpass

		0.25); // mul
}.play)
z.release;

(
z = {
	var sig, freq;
	freq = MouseX.kr(20,12000,\exponential);
	sig = BMoog.ar(
		LFSaw.ar([freq * 0.99, freq * 1.01], 0, 0.1) ! 2,
		SinOsc.kr(SinOsc.kr(0.1),1.5pi,1550,1800),
		MouseY.kr(1,0,\linear),
		0);	// filter mode - lowpass
	 (CombN.ar(sig, 0.4, [0.4,0.35],2) * 0.4) + (sig * 0.5);
}.play)
z.release

(
z = {
	var sig, freq;
	freq = MouseX.kr(20,12000,\exponential);
	sig = BMoog.ar(
		LFSaw.ar([freq * 0.99, freq * 1.01], 0, 0.1) ! 2,
		SinOsc.kr(SinOsc.kr(0.1),1.5pi,1550,1800),
		MouseY.kr(1,0,\linear),
		1);	// filter mode - highpass
	 (CombN.ar(sig, 0.4, [0.4,0.35],2) * 0.4) + (sig * 0.5);
}.play)
z.release

(
z = {
	var sig, freq;
	freq = MouseX.kr(20,12000,\exponential);
	sig = BMoog.ar(
		LFSaw.ar([freq * 0.99, freq * 1.01], 0, 0.1) ! 2,
		SinOsc.kr(SinOsc.kr(0.1),1.5pi,1550,1800),
		MouseY.kr(1,0,\linear),
		2);	// filter mode - bandpass
	 (CombN.ar(sig, 0.4, [0.4,0.35],2) * 0.4) + (sig * 0.5);
}.play)
z.release

(
z = {
	var sig, freq;
	freq = MouseX.kr(20,12000,\exponential);
	sig = BMoog.ar(
		LFSaw.ar([freq * 0.99, freq * 1.01], 0, 0.1) ! 2,
		SinOsc.kr(SinOsc.kr(0.1),1.5pi,1550,1800),
		MouseY.kr(1,0,\linear),
		LFSaw.kr(1,0,3));	// filter mode - sweep modes
	 (CombN.ar(sig, 0.4, [0.4,0.35],2) * 0.4) + (sig * 0.5);
}.play)
z.release

// bhob's benchmark ;)
(
z = {
	var sig;
	sig = BMoog.ar(
		Mix.ar(LFSaw.ar([120, 180], 0, 0.2)),
		LinExp.kr(LFCub.kr(0.1, 0.5pi), -1, 1, 280, 1500),
		0.75,
		2.0).dup;
	 (CombN.ar(sig, 0.4, [0.4,0.35],2) * 0.4) + (sig * 0.5);
	}.play
)
z.release

