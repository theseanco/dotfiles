
Balance -    					balances two signals with each other

Balance(in, test, numperiods, mul, add)

Usage

in - the signal you want to balance
test - the signal that should be used to balance in. If test is a k-rate sig, it will represent a target RMS.

Balance will try to match the RMS levels of in to the RMS of test


s = Server.internal.boot;
s.scope(2);

SynthDef(\noise, {arg noiseout = 1;
	var noise, filt;
	noise = WhiteNoise.ar(MouseX.kr(0, 1));
	filt = BPF.ar(noise, LFNoise2.kr(0.2, 440, 880), 0.001);
	// comment out to compare without balance
	filt = Balance.ar(filt, Amplitude.kr(noise, 0.01, 0.2).max(0.01));
//	filt = filt * 1000;
	Out.ar(0, [filt, noise * noiseout]);
	}).load(s);
	
s.sendMsg(\s_new, \noise, a = s.nextNodeID, 0, 1);
s.sendMsg(\n_set, a, \noiseout, 0);
s.sendMsg(\n_free, a);

SynthDef(\test, {
	var src, sig;
	src = SinOsc.ar(440, 0, MouseX.kr(0, 1));
	sig = SinOsc.ar(440, 0, 0.1);
	// comment out to compare without balance
	sig = Balance.ar(sig, src);
	Out.ar(0, [src, sig]);
	}).load(s);
	
s.sendMsg(\s_new, \test, a = s.nextNodeID, 0, 1);

s.sendMsg(\n_free, a);


