
RLPFD			TB303 Filter Emulation


RLPFD.ar(input, ffreq, res, dist, mul, add)



input - audio input
ffreq - cutoff freq
res - resonance (0-1)
dist - distortion (0-1).  interacts with resonance

This filter can be a little quiet, so i often multiply it by 3 or so.  Watch out for high frequencies + hi res + hi dist = feedback.


{ RLPFD.ar(Mix.ar(LFSaw.ar([120, 180], 0, 0.33)), LinExp.kr(LFCub.kr(0.1, 0.5*pi), -1, 1, 280, 1500), 0.6, 0.5, mul:3).dup }.play