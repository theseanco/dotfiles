
FFTDiffMags		A simple spectral difference measure

Compares the spectra of two signals, finding the magnitude of the difference for each frequency bin. These differences are averaged onto the (control-rate) output.



	FFTDiffMags.kr(chain1, chain2)

	

Note that this crude measure works on a bin-by-bin basis and is not clever enough to detect higher-order similarities between spectra (such as general treble/bass balance).

See also PV_DiffMags which performs the same calculation but doesn't sum the difference values - it leaves them in the frequency-domain buffer for further use.




// How different are the spectra of square waves at different PWM settings?
// This test outputs two square waves, one of whose PWM is controlled by  
// MouseX - in the middle of the screen, the PWMs match,
// but at either side they are more different.
// Watch the output to channel 0 to see the shape of the returned signal

Server.default_(s = Server.internal.boot);
b = Buffer.alloc(s, 1024, 1);
c = Buffer.alloc(s, 1024, 1);
(
{
var chain1, chain2, chain, sig1, sig2, difference;
sig1 = Pulse.ar(100, MouseX.kr(0.1, 0.9));
sig2 = Pulse.ar(100, 0.5);
chain1 = FFT(b.bufnum, sig1);
chain2 = FFT(c.bufnum, sig2);
difference = FFTDiffMags.kr(chain1, chain2);

difference.poll(1, "difference between spectra:");

[sig1, sig2] * 0.1;
}.scope
)