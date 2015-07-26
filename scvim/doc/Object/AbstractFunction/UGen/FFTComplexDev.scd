
FFTComplexDev - Measure complex deviation of signal

	FFTComplexDev.kr(chain, rectify=0, powthresh=0.1)

Calculates the complex deviation of the signal, which is a measure of the total rate of change of  the complex spectral components, across all the FFT bins. A stationary signal (such as a steady sine wave) should exhibit zero deviation, because its magnitude remains constant and its phase changes linearly, whereas a non-stationary signal (such as a sine wave of modulating frequency, or more complex changing sound) should exhibit a positive complex deviation.

This measure can be used as a component in onset detection - see [OnsetsDS] - but may also have other applications.

The comparison is frame-by-frame, so its behaviour will depend to some extent upon your frame size. Also note that this measure only makes sense when used with a continuous stream of FFT frames - so it should be used with the normal [FFT] UGen, not with [FFTTriggered].

The optional second argument rectify specifies (at creation time - cannot be modulated) whether all bins whose power is decreasing should be ignored. Set it greater than zero to activate the rectification feature (it's either on or off; no shades of gray).

The other optional argument powthresh tells the UGen to ignore FFT bins where the power is lower than a threshold. (This option can be modulated at control rate.)

For more details about both algorithms (rectified and non-rectified) see 

	Dixon, S. (2006) Onset Detection Revisited. In Proceedings of the 9th International Conference on Digital Audio Effects (DAFx-06), Montreal, Canada. pp. 133-137.

Examples

These examples use the standard unrectified measure, with a fixed powthresh value. Feel free to dabble with the parameters.

s.boot;
b = Buffer.alloc(s, 512, 1);

// Move the mouse to vary the frequency, and the amount of noise added.
// Watch the scope/post window to see the change in complex deviation.
(
x = {
var in, chain, flux;
in = SinOsc.ar(MouseX.kr(50, 500, 1), 0, 0.1) + WhiteNoise.ar(MouseY.kr(0, 0.1));
chain = FFT(b.bufnum, in);
flux = FFTComplexDev.kr(chain);
flux.poll(10, "Complex deviation");
Out.ar(0, in.dup);
Out.kr(0, flux);
}.play(s);
)

x.free;b.free;


// Load an audio file and plot the complex deviation as a function of time
b = Buffer.alloc(s, 512, 1);
c = Buffer.read(s, "sounds/a11wlk01.wav");
(
x = {
var in, chain, cxdev;
in = PlayBuf.ar(1, c.bufnum, BufRateScale.kr(c.bufnum));
chain = FFT(b.bufnum, in);
cxdev = FFTComplexDev.kr(chain, 0, 10) * 0.1;
cxdev.poll(10, "Complex deviation");
Out.ar(0, in.dup * 0.1);
K2A.ar(cxdev)
}.plot(c.numFrames/c.sampleRate, s);
)

x.free; b.free; c.free;


