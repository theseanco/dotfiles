
Spreader			spreads a mono signal into stereo space by dividing the spectrum

Spreader.ar(in, theta, filtsPerOctave, mul, add)

Spreader uses all pass filters to internally alter the phase of different spectral components of 'in', then outputs a version of this to a stereo field, sending alternating bands to a different speaker. Thta gives a 'width' to the new image. 0 allows the original to pass through to both speakers, 0.5pi represents the widest difference, pi basically gives you an inverted signal between the two speakers. filtsPerOctave tells the UGen how to split the spectrum across 10 octaves of spectral space. A value here of '8' (the default) results in 80 Allpass1 filters.

WARNING: this can be computationally quite expensive.

based on a SynthDef created by Joe Anderson and Juan Pampin, using Regalia-Mitra based allpass filters.

s=Server.internal.boot;
s.scope;

(
// bpo is 'bands per octave'.
// This parameter is read only at init (so you can't modulate it)
SynthDef(\mono_orban,{ arg in_bus, buffer, bpo = 8, out_bus=0, theta = 1.57;
	var in, out;
	// read in mono
//	in = LeakDC.ar(SoundIn.ar(in_bus));	
	in = PlayBuf.ar(1, buffer, loop: 1);
	// sweep through with a mono sin tone... see how the sound moves?
//	in = SinOsc.ar(MouseX.kr(40, 4000), 0, 0.1);
	// decorrelated PinkNoise
//	in = PinkNoise.ar(0.2);
	out = Spreader.ar(in, theta, bpo);
	Out.ar(out_bus, out);
}).send(s);

)

z = Buffer.read(s, "sounds/a11wlk01.wav");
b = Synth(\mono_orban, [\buffer, z]);
b.set([\theta, 0])
b.set([\theta, 0.2])
b.set([\theta, 0.5pi])
b.set([\theta, pi])
b.free;

// less bands
b = Synth(\mono_orban, [\buffer, z, \bpo, 4]);
b.set([\theta, 0])
b.set([\theta, 0.2])
b.set([\theta, 0.5pi])
b.set([\theta, pi])
b.free;


