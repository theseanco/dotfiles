
Streson			String resonance filter


Streson.ar(input, delayTime, res, mul, add)



input - audio input
delayTime - delay (1/ffreq)
res - resonance (0-1)

This filter is based on Victor Lazzrini's csound opcode by the same name.


{ Streson.ar(LFSaw.ar([220, 180], 0, mul:EnvGen.kr(Env.asr(0.5, 1, 0.02), 1.0) * 0.2), LinExp.kr(LFCub.kr(0.1, 0.5*pi), -1, 1, 280, 377).reciprocal, 0.9, 0.3) }.play