
MoogLadder			Moog Filter Emulation


MoogLadder.ar(input, ffreq, res, mul, add)



input - audio input
ffreq - cutoff freq
res - resonance (0-1)


{ MoogLadder.ar(Mix.ar(LFSaw.ar([120, 180], 0, 0.33)), LinExp.kr(LFCub.kr(0.1, 0.5*pi), -1, 1, 180, 8500), 0.75).dup }.play
