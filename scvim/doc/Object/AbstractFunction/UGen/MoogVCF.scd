
MoogVCF				Moog Filter Emulation

MoogVCF.ar(input, ffreq, res, mul, add)

MoogVCF is a port of the CSound opcode moogvcf written by Josep Comajuncosas and Hans Mikelson.  This UGen is a digital emulation of the Moog diode ladder filter configuration.  It is based loosely on the paper "Analyzing the Moog VCF with Considerations for Digital Implemnetation" by Stilson and Smith (CCRMA).

input - audio input
ffreq - cutoff freq
res - resonance (0-1)

{ MoogVCF.ar(
	Pulse.ar([40,121],[0.3,0.7]),SinOsc.kr(LFNoise0.kr(0.42).range(0.001,2.2)).range(30,4200), 
	0.83)}.play(s);


