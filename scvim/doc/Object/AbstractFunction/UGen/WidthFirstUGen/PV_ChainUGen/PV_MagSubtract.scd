
PV_MagSubtract		Spectral subtraction (difference of magnitudes)

	chain = PV_MagSubtract(chain1, chain2, zerolimit)

Subtracts the magnitudes in chain2 away from the magnitudes in chain1. In other words, the output consists of an FFT chain with the phases of chain1, and magnitudes corresponding to (chain1.mags - chain2.mags).

The zerolimit option, if greater than 0, tells the unit to hard-limit the magnitudes to zero, never going lower. 

See PV_MagSmooth for a nice example of using this for spectral subtraction noise removal.
Also FFTDiffMags which performs a similar calculation but sums the differences to form a single control-rate output.

Example

s.boot;
b = Buffer.alloc(s, 1024);
c = Buffer.alloc(s, 1024);

(
x = {
var sig1, sig2, chain1, chain2, chainOut, out;

sig1 = Saw.ar(440);
sig2 = Saw.ar(660);
chain1 = FFT(b.bufnum, sig1);
chain2 = FFT(c.bufnum, sig2);
chainOut = PV_MagSubtract(chain1, chain2);

out = IFFT(chainOut);

// You hear a sequence: sig1 for 1 sec, sig2 for 1 sec, 
//  then the difference for 2 secs.
(Select.ar(LFSaw.kr(0.25).range(0, 4), [sig1, sig2, out, out]) * 0.1).dup

}.play;
)
x.free;
b.free; c.free;


