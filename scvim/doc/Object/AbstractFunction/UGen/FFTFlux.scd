

FFTFlux - Spectral flux statistic



	FFTFlux.kr(chain)

Calculates thespectral flux of the signal, which is a measure of the rate of change of the FFT power spectrum. It measures the difference between the current and previous FFT frames, by calculating the 2-norm (the Euclidean distance between the two spectra) after normalising for power.

For example, a stationary sine wave (or triangle, square, ...) would be expected to exhibit near-zero spectral flux (zero if the period fits neatly into the FFT windowing period). But the boundary between two different musical notes would often be expected to exhibit a peak in spectral flux.

The comparison is frame-by-frame, so its behaviour will depend to some extent upon your frame size. Also note that this measure only makes sense when used with a continuous stream of FFT frames - so it should be used with the normal [FFT] UGen, not with [FFTTriggered].

Examples:


s = Server.internal.boot; 
b = Buffer.alloc(s,2048,1);

// Move the mouse to vary the frequency.
// Watch the scope to see the change in sp.flux.
// You'll see that it's higher when freq is changing.
(
x = {
var in, chain, flux;
in = SinOsc.ar(MouseX.kr(50, 500, 1), 0, 0.1);
chain = FFT(b.bufnum, in);
flux = FFTFlux.kr(chain, 0.9) * 100; // Scale by 100 for more humane numbers
flux.poll(1, "Flux");
Out.ar(0, in.dup);
Out.kr(0, flux);
}.scope;
)

x.free;


// Same again, but with filtered white noise.
// White noise naturally has a significant level of spectral flux
// but again, the flux is much higher while the spectral qualities are changing.
(
x = {
var in, chain, flux;
in = LPF.ar(WhiteNoise.ar(0.1), MouseX.kr(50, 5000, 1));
chain = FFT(b.bufnum, in);
flux = FFTFlux.kr(chain, 0.9) * 100; // Scale by 100 for more humane numbers
flux.poll(1, "Flux");
Out.ar(0, in.dup);
Out.kr(0, flux);
}.scope;
)

x.free;


// Now you try it! Audio input. NB this time we're taking the log because real signals vary a lot.
(
x = {
var in, chain, flux;
in = AudioIn.ar([1,2]).mean;
chain = FFT(b.bufnum, in);
flux = (FFTFlux.kr(chain, 0.9) * 100).log * 0.2;
flux = flux.max(-100); // This is to avoid an infinity created by the log UGen
flux.poll(1, "Log flux");
Out.kr(0, flux);
}.scope;
)

x.free;